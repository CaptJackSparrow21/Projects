import SwiftUI
import AppKit

struct ContentView: View {

    // MARK: - Download Manager

    @StateObject private var downloader = DownloadManager()

    // MARK: - User Input

    @State private var url = ""
    @State private var downloadType = "Single Video"
    @State private var format = "Video"
    @State private var quality = "Best Available (up to 4K)"
    @State private var subtitles = "English"

    @State private var saveLocation =
        FileManager.default.urls(
            for: .downloadsDirectory,
            in: .userDomainMask
        ).first?.path ?? ""

    // MARK: - Options

    private let downloadTypes = [
        "Single Video",
        "Playlist"
    ]

    private let formats = [
        "Video",
        "Audio"
    ]

    private let qualities = [
        "Best Available (up to 4K)",
        "2160p",
        "1440p",
        "1080p",
        "720p",
        "480p",
        "360p"
    ]

    private let subtitleOptions = [
        "English",
        "English (Auto-generated)",
        "All subtitles",
        "No subtitles"
    ]

    // MARK: - Body

    var body: some View {

        ScrollView(.vertical, showsIndicators: true) {

            VStack(alignment: .leading, spacing: 0) {

                // --------------------------------------------------
                // Header
                // --------------------------------------------------

                header

                // --------------------------------------------------
                // YouTube URL
                // --------------------------------------------------

                urlSection

                // --------------------------------------------------
                // Download Type
                // --------------------------------------------------

                downloadTypeSection

                // --------------------------------------------------
                // Format
                // --------------------------------------------------

                formatSection

                // --------------------------------------------------
                // Quality
                // --------------------------------------------------

                if format == "Video" {
                    qualitySection
                }

                // --------------------------------------------------
                // Subtitles
                // --------------------------------------------------

                subtitleSection

                // --------------------------------------------------
                // Save Location
                // --------------------------------------------------

                saveLocationSection

                // --------------------------------------------------
                // Download Button
                // --------------------------------------------------

                downloadSection

                // --------------------------------------------------
                // Progress / ETA / Current Video
                // --------------------------------------------------

                if downloader.isDownloading || downloader.progress > 0 {
                    progressSection
                }

                // --------------------------------------------------
                // Error
                // --------------------------------------------------

                if !downloader.errorMessage.isEmpty {
                    errorSection
                }

                // --------------------------------------------------
                // Bottom Space
                // --------------------------------------------------

                Color.clear
                    .frame(height: 60)
            }
            .frame(maxWidth: 1100)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 60)
            .padding(.top, 35)
        }
        .frame(
            minWidth: 900,
            minHeight: 650
        )
        .background(
            Color(nsColor: .windowBackgroundColor)
        )
    }

    // MARK: - Header

    private var header: some View {

        VStack(spacing: 12) {

            Image(
                systemName: "arrow.down.circle.fill"
            )
            .font(.system(size: 70))
            .foregroundStyle(.blue)

            Text("YT Downloader")
                .font(
                    .system(
                        size: 40,
                        weight: .bold
                    )
                )

            Text(
                "Download videos and audio from YouTube"
            )
            .font(.title3)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 45)
    }

    // MARK: - URL

    private var urlSection: some View {

        VStack(
            alignment: .leading,
            spacing: 10
        ) {

            Text("YouTube URL")
                .font(.title3)
                .fontWeight(.bold)

            TextField(
                "Paste YouTube URL here...",
                text: $url
            )
            .textFieldStyle(.roundedBorder)
            .font(.system(size: 18))
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 28)
    }

    // MARK: - Download Type

    private var downloadTypeSection: some View {

        optionRow(title: "Download Type") {

            Picker(
                "",
                selection: $downloadType
            ) {

                ForEach(
                    downloadTypes,
                    id: \.self
                ) { item in

                    Text(item)
                        .tag(item)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 350)
        }
        .padding(.bottom, 28)
    }

    // MARK: - Format

    private var formatSection: some View {

        optionRow(title: "Format") {

            Picker(
                "",
                selection: $format
            ) {

                ForEach(
                    formats,
                    id: \.self
                ) { item in

                    Text(item)
                        .tag(item)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 220)
        }
        .padding(.bottom, 28)
    }

    // MARK: - Quality

    private var qualitySection: some View {

        optionRow(title: "Quality") {

            Picker(
                "",
                selection: $quality
            ) {

                ForEach(
                    qualities,
                    id: \.self
                ) { item in

                    Text(item)
                        .tag(item)
                }
            }
            .frame(width: 320)
        }
        .padding(.bottom, 28)
    }

    // MARK: - Subtitles

    private var subtitleSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            optionRow(title: "Subtitles") {

                Picker(
                    "",
                    selection: $subtitles
                ) {

                    ForEach(
                        subtitleOptions,
                        id: \.self
                    ) { item in

                        Text(item)
                            .tag(item)
                    }
                }
                .frame(width: 330)
            }

            HStack(
                alignment: .top,
                spacing: 12
            ) {

                Image(
                    systemName: "captions.bubble.fill"
                )
                .foregroundStyle(.blue)

                Text(subtitleDescription)
                    .foregroundStyle(.secondary)

                Spacer()
            }
            .padding(16)
            .background(
                RoundedRectangle(
                    cornerRadius: 12
                )
                .fill(
                    Color.secondary.opacity(0.10)
                )
            )
        }
        .disabled(format == "Audio")
        .opacity(
            format == "Audio"
            ? 0.5
            : 1
        )
        .padding(.bottom, 28)
    }

    // MARK: - Subtitle Description

    private var subtitleDescription: String {

        switch subtitles {

        case "English":
            return
                "Download available English subtitles and embed them inside the video."

        case "English (Auto-generated)":
            return
                "Download YouTube's automatically generated English subtitles and embed them inside the video."

        case "All subtitles":
            return
                "Download all available subtitles and embed them inside the video."

        default:
            return
                "Subtitles will not be downloaded."
        }
    }

    // MARK: - Save Location

    private var saveLocationSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Save Location")
                .font(.title3)
                .fontWeight(.bold)

            HStack(spacing: 14) {

                Image(
                    systemName: "folder.fill"
                )
                .foregroundStyle(.blue)

                Text(
                    saveLocation.isEmpty
                    ? "Choose a folder"
                    : saveLocation
                )
                .lineLimit(1)
                .truncationMode(.middle)

                Spacer()

                Button("Choose Folder") {
                    chooseFolder()
                }
                .buttonStyle(.bordered)
            }
            .padding(16)
            .background(
                RoundedRectangle(
                    cornerRadius: 12
                )
                .fill(
                    Color.secondary.opacity(0.10)
                )
            )
        }
        .padding(.bottom, 30)
    }

    // MARK: - Download Section

    private var downloadSection: some View {

        VStack(spacing: 12) {

            HStack(spacing: 12) {

                Button {

                    startDownload()

                } label: {

                    HStack(spacing: 8) {

                        Image(
                            systemName:
                                downloader.isDownloading
                                ? "arrow.down.circle"
                                : "arrow.down.circle.fill"
                        )

                        Text(
                            downloader.isDownloading
                            ? "Downloading..."
                            : "Download"
                        )
                        .fontWeight(.semibold)
                    }
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(
                    url.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty ||
                    downloader.isDownloading
                )

                if downloader.isDownloading {

                    Button {

                        downloader.cancel()

                    } label: {

                        Label(
                            "Cancel",
                            systemImage:
                                "xmark.circle.fill"
                        )
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                    .controlSize(.large)
                }
            }
        }
        .padding(.bottom, 30)
    }

    // MARK: - Progress

    private var progressSection: some View {

        VStack(
            alignment: .leading,
            spacing: 16
        ) {

            // --------------------------------------------------
            // Progress Header
            // --------------------------------------------------

            HStack {

                HStack(spacing: 8) {

                    Image(
                        systemName:
                            downloader.isDownloading
                            ? "arrow.down.circle"
                            : "checkmark.circle.fill"
                    )
                    .foregroundStyle(
                        downloader.isDownloading
                        ? .blue
                        : .green
                    )

                    Text(
                        downloader.isDownloading
                        ? "Downloading..."
                        : downloader.status
                    )
                    .font(.headline)
                }

                Spacer()

                Text(
                    "\(Int(downloader.progress * 100))%"
                )
                .font(.headline)
            }

            // --------------------------------------------------
            // Progress Bar
            // --------------------------------------------------

            ProgressView(
                value: downloader.progress,
                total: 1
            )
            .progressViewStyle(.linear)

            // --------------------------------------------------
            // Current Video
            // --------------------------------------------------

            VStack(
                alignment: .leading,
                spacing: 10
            ) {

                Text("Currently downloading")
                    .font(.headline)

                Text(
                    downloader.currentVideo.isEmpty
                    ? "Preparing video..."
                    : downloader.currentVideo
                )
                .lineLimit(3)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )

                // --------------------------------------------------
                // Speed + ETA
                // --------------------------------------------------

                HStack {

                    HStack(spacing: 8) {

                        Image(
                            systemName: "speedometer"
                        )

                        Text(
                            downloader.speed.isEmpty
                            ? "Calculating speed..."
                            : downloader.speed
                        )
                    }

                    Spacer()

                    if !downloader.eta.isEmpty {

                        HStack(spacing: 8) {

                            Image(
                                systemName: "clock"
                            )

                            Text(
                                "ETA \(downloader.eta)"
                            )
                        }
                    }
                }
                .foregroundStyle(.secondary)
            }
            .padding(18)
            .background(
                RoundedRectangle(
                    cornerRadius: 12
                )
                .fill(
                    Color.secondary.opacity(0.10)
                )
            )

            // --------------------------------------------------
            // Status
            // --------------------------------------------------

            Text(downloader.status)
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .background(
            RoundedRectangle(
                cornerRadius: 14
            )
            .fill(
                Color.secondary.opacity(0.06)
            )
        )
        .padding(.bottom, 28)
    }

    // MARK: - Error

    private var errorSection: some View {

        VStack(
            alignment: .leading,
            spacing: 10
        ) {

            Label(
                "Error",
                systemImage:
                    "exclamationmark.triangle.fill"
            )
            .font(.headline)
            .foregroundStyle(.red)

            Text(
                downloader.errorMessage
            )
            .textSelection(.enabled)
            .foregroundStyle(.secondary)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
        }
        .padding(20)
        .background(
            RoundedRectangle(
                cornerRadius: 14
            )
            .fill(
                Color.red.opacity(0.10)
            )
        )
        .padding(.bottom, 28)
    }

    // MARK: - Option Row

    @ViewBuilder
    private func optionRow<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {

        HStack(spacing: 20) {

            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .frame(
                    width: 180,
                    alignment: .leading
                )

            Spacer()

            content()
        }
    }

    // MARK: - Start Download

    private func startDownload() {

        downloader.startDownload(

            url: url.trimmingCharacters(
                in: .whitespacesAndNewlines
            ),

            downloadType: downloadType,

            format: format,

            quality: quality,

            subtitles: subtitles,

            saveLocation: saveLocation
        )
    }

    // MARK: - Choose Folder

    private func chooseFolder() {

        let panel = NSOpenPanel()

        panel.title = "Choose Download Folder"

        panel.message =
            "Choose where your downloaded videos or audio should be saved."

        panel.canChooseFiles = false

        panel.canChooseDirectories = true

        panel.allowsMultipleSelection = false

        panel.canCreateDirectories = true

        if panel.runModal() == .OK,
           let selectedURL = panel.url {

            saveLocation = selectedURL.path
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
