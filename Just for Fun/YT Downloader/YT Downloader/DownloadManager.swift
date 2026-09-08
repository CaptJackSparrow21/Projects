import Foundation
import Combine

final class DownloadManager: NSObject, ObservableObject, @unchecked Sendable {

    // MARK: - Published UI State

    @Published var isDownloading = false
    @Published var progress: Double = 0

    @Published var currentVideo = "Preparing video..."
    @Published var speed = "Calculating speed..."
    @Published var eta = "--:--"
    @Published var status = "Starting..."

    @Published var currentVideoNumber = 0
    @Published var totalVideos = 1
    @Published var playlistName = ""

    @Published var errorMessage = ""
    @Published var completedMessage = ""

    // MARK: - Process

    private var process: Process?
    private var outputPipe: Pipe?
    private var errorPipe: Pipe?

    // MARK: - Paths

    private let ytDlpPath = "/opt/homebrew/bin/yt-dlp"
    private let ffmpegPath = "/opt/homebrew/bin/ffmpeg"
    private let denoPath = "/opt/homebrew/bin/deno"

    // MARK: - Start Download

    func startDownload(
        url: String,
        downloadType: String,
        format: String,
        quality: String,
        subtitles: String,
        saveLocation: String
    ) {

        let cleanURL = url.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !cleanURL.isEmpty else {
            errorMessage = "Please enter a YouTube URL."
            return
        }

        guard FileManager.default.fileExists(atPath: ytDlpPath) else {
            errorMessage = "yt-dlp was not found at \(ytDlpPath)"
            return
        }

        guard FileManager.default.fileExists(atPath: ffmpegPath) else {
            errorMessage = "FFmpeg was not found at \(ffmpegPath)"
            return
        }

        cancel()

        isDownloading = true
        progress = 0

        currentVideoNumber = 0
        totalVideos = 1

        playlistName = ""

        currentVideo = "Preparing video..."
        speed = "Calculating speed..."
        eta = "--:--"
        status = "Preparing..."

        errorMessage = ""
        completedMessage = ""

        let isPlaylist = downloadType == "Playlist"

        if isPlaylist {

            preparePlaylist(
                url: cleanURL,
                format: format,
                quality: quality,
                subtitles: subtitles,
                saveLocation: saveLocation
            )

        } else {

            startProcess(
                url: cleanURL,
                isPlaylist: false,
                playlistFolder: saveLocation,
                format: format,
                quality: quality,
                subtitles: subtitles
            )
        }
    }

    // MARK: - Playlist Preparation

    private func preparePlaylist(
        url: String,
        format: String,
        quality: String,
        subtitles: String,
        saveLocation: String
    ) {

        let metadataProcess = Process()
        let metadataOutputPipe = Pipe()

        metadataProcess.executableURL = URL(fileURLWithPath: ytDlpPath)

        metadataProcess.arguments = [
            "--js-runtimes",
            "deno:\(denoPath)",
            "--flat-playlist",
            "--dump-single-json",
            "--skip-download",
            url
        ]

        metadataProcess.standardOutput = metadataOutputPipe
        metadataProcess.standardError = Pipe()

        do {
            try metadataProcess.run()
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.isDownloading = false
                self?.errorMessage =
                    "Unable to start yt-dlp: \(error.localizedDescription)"
            }
            return
        }

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in

            metadataProcess.waitUntilExit()

            let data = metadataOutputPipe.fileHandleForReading.readDataToEndOfFile()

            guard
                let json = try? JSONSerialization.jsonObject(with: data)
                    as? [String: Any]
            else {
                DispatchQueue.main.async {
                    self?.isDownloading = false
                    self?.errorMessage =
                        "Could not read playlist information."
                }
                return
            }

            let entries = json["entries"] as? [[String: Any]] ?? []

            let title =
                json["title"] as? String ??
                json["playlist_title"] as? String ??
                "YouTube Playlist"

            let count = max(entries.count, 1)

            let folderName =
                self?.cleanFolderName(title) ?? "YouTube Playlist"

            let playlistFolder = URL(fileURLWithPath: saveLocation)
                .appendingPathComponent(
                    folderName,
                    isDirectory: true
                )

            try? FileManager.default.createDirectory(
                at: playlistFolder,
                withIntermediateDirectories: true
            )

            DispatchQueue.main.async { [weak self] in

                guard let self else {
                    return
                }

                self.totalVideos = count
                self.playlistName = folderName
                self.status = "Starting playlist..."

                self.startProcess(
                    url: url,
                    isPlaylist: true,
                    playlistFolder: playlistFolder.path,
                    format: format,
                    quality: quality,
                    subtitles: subtitles
                )
            }
        }
    }

    // MARK: - Start yt-dlp

    private func startProcess(
        url: String,
        isPlaylist: Bool,
        playlistFolder: String,
        format: String,
        quality: String,
        subtitles: String
    ) {

        let process = Process()
        let outputPipe = Pipe()
        let errorPipe = Pipe()

        self.process = process
        self.outputPipe = outputPipe
        self.errorPipe = errorPipe

        process.executableURL = URL(fileURLWithPath: ytDlpPath)

        process.arguments = buildArguments(
            url: url,
            isPlaylist: isPlaylist,
            playlistFolder: playlistFolder,
            format: format,
            quality: quality,
            subtitles: subtitles
        )

        process.standardOutput = outputPipe
        process.standardError = errorPipe

        outputPipe.fileHandleForReading.readabilityHandler = {
            [weak self] handle in

            let data = handle.availableData

            guard !data.isEmpty else {
                return
            }

            guard let text = String(data: data, encoding: .utf8) else {
                return
            }

            DispatchQueue.main.async {
                self?.parseOutput(text)
            }
        }

        errorPipe.fileHandleForReading.readabilityHandler = {
            [weak self] handle in

            let data = handle.availableData

            guard !data.isEmpty else {
                return
            }

            guard let text = String(data: data, encoding: .utf8) else {
                return
            }

            DispatchQueue.main.async {
                self?.parseError(text)
            }
        }

        do {
            try process.run()
        } catch {

            outputPipe.fileHandleForReading.readabilityHandler = nil
            errorPipe.fileHandleForReading.readabilityHandler = nil

            DispatchQueue.main.async { [weak self] in
                self?.isDownloading = false
                self?.process = nil
                self?.outputPipe = nil
                self?.errorPipe = nil

                self?.errorMessage =
                    "Could not start yt-dlp: \(error.localizedDescription)"
            }

            return
        }

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in

            process.waitUntilExit()

            outputPipe.fileHandleForReading.readabilityHandler = nil
            errorPipe.fileHandleForReading.readabilityHandler = nil

            let statusCode = process.terminationStatus

            DispatchQueue.main.async {

                guard let self else {
                    return
                }

                guard self.process === process else {
                    return
                }

                self.isDownloading = false
                self.process = nil
                self.outputPipe = nil
                self.errorPipe = nil

                if statusCode == 0 {

                    self.progress = 1.0
                    self.eta = "00:00"
                    self.speed = "Completed"

                    self.status = "Completed"
                    self.currentVideo = "Download completed"

                    self.completedMessage =
                        "Download completed successfully."

                } else if self.errorMessage.isEmpty {

                    self.status = "Failed"

                    self.errorMessage =
                        "yt-dlp exited with code \(statusCode)."
                }
            }
        }
    }

    // MARK: - Build Arguments

    private func buildArguments(
        url: String,
        isPlaylist: Bool,
        playlistFolder: String,
        format: String,
        quality: String,
        subtitles: String
    ) -> [String] {

        var args: [String] = []

        // JavaScript runtime
        args += [
            "--js-runtimes",
            "deno:\(denoPath)"
        ]

        // FFmpeg
        args += [
            "--ffmpeg-location",
            ffmpegPath
        ]

        // Progress
        args += [
            "--newline",
            "--progress",
            "--progress-delta",
            "0.5"
        ]

        // Do not overwrite existing files
        args += [
            "--no-overwrites",
            "--continue",
            "--no-part"
        ]

        // Format
        if format == "Audio" {

            args += [
                "-f",
                "bestaudio/best",
                "-x",
                "--audio-format",
                "mp3"
            ]

        } else {

            let formatSelector: String

            if quality.contains("2160") || quality.contains("4K") {

                formatSelector =
                    "bestvideo[height<=2160]+bestaudio/best[height<=2160]"

            } else if quality.contains("1440") {

                formatSelector =
                    "bestvideo[height<=1440]+bestaudio/best[height<=1440]"

            } else if quality.contains("1080") {

                formatSelector =
                    "bestvideo[height<=1080]+bestaudio/best[height<=1080]"

            } else if quality.contains("720") {

                formatSelector =
                    "bestvideo[height<=720]+bestaudio/best[height<=720]"

            } else {

                formatSelector =
                    "bestvideo+bestaudio/best"
            }

            args += [
                "-f",
                formatSelector,
                "--merge-output-format",
                "mp4"
            ]
        }

        // Subtitles
        if format == "Video" {

            switch subtitles {

            case "English":

                args += [
                    "--write-subs",
                    "--sub-langs",
                    "en.*",
                    "--embed-subs",
                    "--sub-format",
                    "best"
                ]

            case "English (Auto-generated)":

                args += [
                    "--write-auto-subs",
                    "--sub-langs",
                    "en.*",
                    "--embed-subs",
                    "--sub-format",
                    "best"
                ]

            case "All subtitles":

                args += [
                    "--write-subs",
                    "--write-auto-subs",
                    "--all-subs",
                    "--embed-subs",
                    "--sub-format",
                    "best"
                ]

            default:
                break
            }
        }

        // Output folder
        if isPlaylist {

            args += [
                "--paths",
                "home:\(playlistFolder)",
                "-o",
                "%(playlist_index)03d - %(title)s.%(ext)s"
            ]

        } else {

            args += [
                "--paths",
                "home:\(playlistFolder)",
                "-o",
                "%(title)s.%(ext)s"
            ]
        }

        // Useful information
        args += [
            "--print",
            "before_dl:YT_TITLE:%(title)s"
        ]

        if isPlaylist {

            args += [
                "--print",
                "before_dl:YT_INDEX:%(playlist_index)s/%(n_entries)s"
            ]
        }

        args.append(url)

        return args
    }

    // MARK: - Parse Output

    private func parseOutput(_ text: String) {

        let lines = text.components(separatedBy: .newlines)

        for line in lines {

            let cleanLine =
                line.trimmingCharacters(
                    in: .whitespacesAndNewlines
                )

            guard !cleanLine.isEmpty else {
                continue
            }

            // Current video
            if cleanLine.hasPrefix("YT_TITLE:") {

                currentVideo =
                    cleanLine
                    .replacingOccurrences(
                        of: "YT_TITLE:",
                        with: ""
                    )
                    .trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )

                statusText("Downloading...")
            }

            // Playlist position
            if cleanLine.hasPrefix("YT_INDEX:") {

                let index =
                    cleanLine
                    .replacingOccurrences(
                        of: "YT_INDEX:",
                        with: ""
                    )

                if index != "NA/NA" {

                    let parts =
                        index.components(
                            separatedBy: "/"
                        )

                    if parts.count == 2,
                       let current = Int(parts[0]),
                       let total = Int(parts[1]) {

                        currentVideoNumber = current
                        totalVideos = max(total, 1)

                        statusText(
                            "Downloading video \(index)"
                        )
                    }
                }
            }

            // Download progress
            if cleanLine.contains("[download]") {
                parseProgressLine(cleanLine)
            }

            // Processing
            if cleanLine.contains("[Merger]") {
                statusText("Merging video...")
            }

            if cleanLine.contains("[EmbedSubtitle]") {
                statusText("Embedding subtitles...")
            }

            if cleanLine.contains("[ExtractAudio]") {
                statusText("Converting audio...")
            }

            if cleanLine.contains("has already been downloaded") {
                statusText("Already downloaded")
            }

            // Errors
            if cleanLine.contains("ERROR:") {
                parseError(cleanLine)
            }
        }
    }

    // MARK: - Progress

    private func parseProgressLine(_ line: String) {

        // Example:
        // [download] 52.4% of 100MiB at 8.5MiB/s ETA 00:05

        let percentPattern = #"(\d+(?:\.\d+)?)%"#

        if let percent = firstMatch(
            pattern: percentPattern,
            in: line
        ),
        let value = Double(percent) {

            let currentProgress =
                min(
                    max(value / 100.0, 0),
                    1
                )

            if totalVideos > 1 {

                let completed =
                    Double(
                        max(
                            currentVideoNumber - 1,
                            0
                        )
                    )

                progress =
                    min(
                        max(
                            (completed + currentProgress)
                            / Double(totalVideos),
                            0
                        ),
                        1
                    )

            } else {

                progress = currentProgress
            }
        }

        // Speed
        let speedPattern =
            #"at\s+([0-9.]+\s*[KMG]i?B/s)"#

        if let foundSpeed = firstMatch(
            pattern: speedPattern,
            in: line
        ) {
            speed = foundSpeed
        }

        // ETA
        let etaPattern =
            #"ETA\s+([0-9:]+)"#

        if let foundETA = firstMatch(
            pattern: etaPattern,
            in: line
        ) {
            eta = foundETA
        }
    }

    // MARK: - Regex Helper

    private func firstMatch(
        pattern: String,
        in text: String
    ) -> String? {

        guard let regex = try? NSRegularExpression(
            pattern: pattern
        ) else {
            return nil
        }

        let range =
            NSRange(
                text.startIndex..<text.endIndex,
                in: text
            )

        guard let match = regex.firstMatch(
            in: text,
            range: range
        ) else {
            return nil
        }

        guard match.numberOfRanges > 1 else {
            return nil
        }

        let resultRange = match.range(at: 1)

        guard let swiftRange = Range(
            resultRange,
            in: text
        ) else {
            return nil
        }

        return String(text[swiftRange])
    }

    // MARK: - Errors

    private func parseError(_ text: String) {

        let message =
            text
            .replacingOccurrences(
                of: "ERROR:",
                with: ""
            )
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        guard !message.isEmpty else {
            return
        }

        errorMessage = message
    }

    // MARK: - Status

    private func statusText(_ text: String) {
        status = text
    }

    // MARK: - Cancel

    func cancel() {

        guard let process else {
            return
        }

        outputPipe?
            .fileHandleForReading
            .readabilityHandler = nil

        errorPipe?
            .fileHandleForReading
            .readabilityHandler = nil

        if process.isRunning {
            process.terminate()
        }

        self.process = nil
        self.outputPipe = nil
        self.errorPipe = nil

        isDownloading = false

        currentVideo = "Download cancelled"
        status = "Cancelled"

        speed = ""
        eta = "--:--"
    }

    // MARK: - Clean Folder Name

    private func cleanFolderName(_ name: String) -> String {

        let invalidCharacters =
            CharacterSet(
                charactersIn: "/:\\?%*|\"<>"
            )

        let cleaned =
            name
            .components(
                separatedBy: invalidCharacters
            )
            .joined()
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        return cleaned.isEmpty
            ? "YouTube Playlist"
            : cleaned
    }
}
