# YT Downloader

A simple and clean native macOS application for downloading YouTube videos and audio.

YT Downloader provides an easy-to-use graphical interface for downloading individual YouTube videos or YouTube playlists without requiring users to work directly with command-line tools.

The application is built using Swift and SwiftUI and is designed specifically for macOS.

---

## ✨ Features

- 🎥 Download YouTube videos
- 🎵 Download audio
- 📹 Download a single video
- 📚 Download YouTube playlists
- 🎚️ Select video quality
- 🏆 Best Available quality option
- 📝 Download available subtitles
- 🌐 English subtitle support
- 🤖 English auto-generated subtitle support
- 🌍 All subtitles option
- 🚫 No subtitles option
- 🎬 Embed subtitles into downloaded videos
- 📁 Choose a custom save location
- 📂 Downloads are saved to the Downloads folder by default
- 📊 Display download progress
- 🚀 Display download speed
- ⏱️ Display estimated time remaining (ETA)
- 📋 Display playlist progress such as `7 / 9`
- 🎞️ Show the currently downloading video
- ❌ Cancel an active download
- 🖥️ Native macOS user interface
- 📜 Fully scrollable interface
- 🧹 Clean and simple graphical interface

---

# 📸 Screenshots

Screenshots of the application can be added here.

Example:

![YT Downloader](screenshots/main-window.png)

More screenshots can be added in the future, such as:

- Main application window
- Video download
- Audio download
- Playlist download
- Download progress
- Subtitle selection
- Completed download

---

# 💻 Requirements

To use YT Downloader, you need:

- A Mac
- macOS
- An active internet connection

To build YT Downloader from source code, you additionally need:

- Xcode
- Swift
- SwiftUI

The application is designed specifically for macOS.

---

# 📥 Installation

There are currently two possible ways to use YT Downloader.

## Method 1 — Build From Source

You can download the source code from this repository and build the application yourself using Xcode.

This is currently the recommended method if you want to use the latest version of the source code.

## Method 2 — Pre-built Application

A pre-built `.app` or `.dmg` release may be provided through the GitHub Releases section in the future.

Once a release is available, users will be able to download the application without opening Xcode.

> Pre-built releases are not currently available.

---

# 🛠️ Build From Source

If you want to build YT Downloader yourself, follow these steps.

## 1. Clone the Repository

Open Terminal and run:

```bash
git clone https://github.com/CaptJackSparrow21/Projects.git
```

Then enter the project directory:

```bash
cd "Projects/Just for Fun/YT Downloader"
```

---

## 2. Open the Project in Xcode

Locate the Xcode project inside the YT Downloader folder.

Open the project in Xcode.

You can also open it from Terminal if the project contains an `.xcodeproj` file:

```bash
open *.xcodeproj
```

If the project uses an `.xcworkspace` file instead, open the workspace:

```bash
open *.xcworkspace
```

---

## 3. Select the Application Target

In Xcode:

1. Open the YT Downloader project.
2. Select the **YT Downloader** target.
3. Select your Mac as the run destination.
4. Make sure the project builds successfully.

---

## 4. Build and Run

Press:

```text
⌘ + R
```

or click the **Run ▶** button in Xcode.

Xcode will build and launch the application.

---

# 🚀 Using YT Downloader

Once YT Downloader is running, you can download a YouTube video or playlist using the graphical interface.

---

## Step 1: Copy a YouTube URL

Open YouTube and copy the URL of the video or playlist you want to download.

For example:

```text
https://www.youtube.com/watch?v=XXXXXXXXXXX
```

For a playlist, copy the playlist URL provided by YouTube.

---

## Step 2: Paste the URL

Open YT Downloader and paste the URL into the:

```text
YouTube URL
```

field.

---

## Step 3: Select Download Type

Choose between:

### Single Video

Use this option when you want to download one YouTube video.

### Playlist

Use this option when you want to download a YouTube playlist.

---

## Step 4: Select Format

Choose between:

### Video

Use this option when you want to download the video.

### Audio

Use this option when you only want the audio.

---

## Step 5: Select Quality

For video downloads, select the desired quality.

Depending on the source video, available qualities may include:

- Best Available
- 4K
- 1080p
- 720p
- 480p
- Other available qualities

The available quality depends on the source video.

If **Best Available** is selected, the application attempts to download the best available quality supported by the source.

---

## Step 6: Select Subtitles

If subtitles are available, select the desired subtitle option.

The application supports available subtitle options such as:

- English subtitles
- English auto-generated subtitles
- All available subtitles
- No subtitles

When subtitles are selected, the application can download the available subtitles and embed them into the downloaded video where supported.

---

## Step 7: Choose Save Location

By default, downloaded files are saved to:

```text
~/Downloads
```

You can choose another folder using:

```text
Choose Folder
```

The selected folder will be used as the download destination.

---

## Step 8: Start Download

After selecting the desired options, click:

```text
Download
```

The application will start processing the selected content.

During the download, the application can display information such as:

- Download progress
- Download speed
- Estimated time remaining
- Current video
- Playlist progress

For example:

```text
7 / 9
```

means that the application is currently processing the seventh item out of nine.

---

# 🎵 Downloading Audio

To download only audio:

1. Copy the YouTube video or playlist URL.
2. Paste the URL into the **YouTube URL** field.
3. Select **Single Video** or **Playlist**.
4. Select **Audio**.
5. Choose the available audio option.
6. Select the save location.
7. Click **Download**.

The application will process the selected content as an audio download.

---

# 🎥 Downloading a Single Video

To download a single YouTube video:

1. Copy the YouTube video URL.
2. Paste it into the **YouTube URL** field.
3. Select **Single Video**.
4. Select **Video**.
5. Choose the desired quality.
6. Select subtitle options if required.
7. Choose the save location.
8. Click **Download**.

The application will download the selected video.

---

# 📚 Downloading a Playlist

To download a YouTube playlist:

1. Copy the YouTube playlist URL.
2. Paste it into the **YouTube URL** field.
3. Select **Playlist**.
4. Select **Video** or **Audio**.
5. Choose the desired quality or audio option.
6. Select subtitle options if required.
7. Choose the save location.
8. Click **Download**.

The application will process the videos contained in the playlist.

The application displays playlist progress while processing the playlist.

For example:

```text
7 / 9
```

means seven of nine playlist items are being processed.

---

# 📝 Subtitles

YT Downloader supports downloading available subtitles.

Depending on the video, available options may include:

### English

Downloads available English subtitles.

### English Auto-Generated

Downloads available automatically generated English subtitles.

### All

Attempts to download all available subtitle languages.

### No Subtitles

Downloads the video without subtitles.

When supported, subtitles can be embedded directly into the downloaded video.

Subtitle availability depends on the source video.

---

# 📊 Download Progress

While downloading, YT Downloader can display useful information about the current download.

This may include:

- Current video
- Download progress
- Download speed
- Estimated time remaining
- Playlist progress

For playlist downloads, the current item and overall playlist progress can be displayed.

Example:

```text
Downloading: Video Title

Progress: 65%

Speed: 8.4 MB/s

ETA: 00:32

Playlist: 7 / 9
```

The exact information displayed depends on the type of download and the available source information.

---

# ❌ Cancelling a Download

An active download can be cancelled using the application's cancel control.

When a download is cancelled, the application stops the active download process.

For playlist downloads, cancelling the operation stops the active playlist download process.

---

# 📁 Download Location

The default download location is:

```text
~/Downloads
```

You can change the download location using:

```text
Choose Folder
```

This allows you to save downloaded files to another folder on your Mac.

---

# 🖥️ User Interface

YT Downloader uses a native macOS graphical interface.

The application is designed so that users do not need to operate the downloader through Terminal commands.

The interface includes:

- YouTube URL input
- Download type selection
- Format selection
- Quality selection
- Subtitle selection
- Save location selection
- Download control
- Download progress information
- Download speed
- ETA
- Playlist progress
- Cancel control

The interface is fully scrollable so that all available controls and download information can be accessed comfortably on different window sizes.

---

# 🔧 Troubleshooting

## Download Does Not Start

Make sure that:

- The YouTube URL is correct.
- Your Mac has an active internet connection.
- The video or playlist is accessible.
- The selected save folder is accessible.

Try copying the YouTube URL again and pasting it into the application.

---

## Video Quality Is Not Available

Not every YouTube video provides the same quality options.

Available qualities depend on the source video.

If a particular quality is unavailable, select another available quality or use:

```text
Best Available
```

---

## Subtitles Are Not Available

Not every YouTube video provides subtitles.

Subtitle availability depends on the source video.

If subtitles are unavailable, the application may not be able to download or embed them.

---

## Playlist Download Does Not Work

Make sure that:

- The URL is a valid YouTube playlist URL.
- The playlist is accessible.
- Your internet connection is working.
- The playlist contains accessible videos.

Some videos inside a playlist may also be unavailable depending on their availability or restrictions.

---

# 🧑‍💻 Development

If you want to modify or improve the application:

1. Clone the repository.
2. Open the YT Downloader Xcode project.
3. Make your changes.
4. Build the project.
5. Test the application.
6. Commit your changes.
7. Push your changes to GitHub.

Example:

```bash
git add .
git commit -m "Update YT Downloader"
git push
```

---

# 📂 Project Structure

The project is organized inside the repository as follows:

```text
Projects/
│
├── Just for Fun/
│   │
│   └── YT Downloader/
│       │
│       ├── YT Downloader Xcode Project
│       ├── Source Files
│       ├── Assets
│       └── README.md
│
└── ...
```

The exact files and folders may change as the project develops.

---

# 🛠️ Technology

YT Downloader is a native macOS application developed using Apple's development tools.

### Technologies Used

- Swift
- SwiftUI
- Xcode
- macOS

The application uses a graphical user interface rather than requiring users to interact with command-line downloader tools directly.

---

# 📌 Project Status

YT Downloader is currently an independent personal project.

The project is actively maintained and may receive new features, improvements, and bug fixes in the future.

Possible future improvements may include:

- Pre-built application releases
- Improved download management
- Additional format options
- More subtitle options
- Improved error handling
- Additional download controls
- UI improvements
- Better playlist management

---

# 🤝 Contributing

This project is primarily maintained by the author.

Suggestions, bug reports, and feature requests are welcome.

If you discover a problem or have an idea for improving the application, you can open an issue in the GitHub repository.

Pull requests may be reviewed by the project owner before being accepted.

---

# 🔒 License

This project is **not currently licensed for modification or redistribution**.

All rights are reserved by the author unless explicit permission is granted.

You may view the source code for learning and reference purposes, but you may not modify, redistribute, publish, sell, or distribute modified versions of this project without explicit permission from the author.

A formal license may be added in the future.

---

# ⚠️ Disclaimer

YT Downloader is intended for downloading content that you are legally allowed to download.

Users are responsible for complying with:

- YouTube's Terms of Service
- Copyright laws
- Intellectual property laws
- Other applicable laws and regulations

Do not use this application to download, reproduce, or distribute copyrighted content without the appropriate permission or legal right to do so.

The author is not responsible for misuse of the application.

---

# 👨‍💻 Author

Created by **CaptJackSparrow21**

GitHub:

https://github.com/CaptJackSparrow21

---

# 📦 Project Repository

The complete project is available on GitHub:

https://github.com/CaptJackSparrow21/Projects

Project location inside the repository:

```text
Projects
└── Just for Fun
    └── YT Downloader
```

---

# ⭐ Support

If you find this project useful, you can:

- ⭐ Star the repository
- 🐛 Report bugs
- 💡 Suggest improvements
- 📢 Share the project
- 💻 Explore the source code

Thank you for checking out YT Downloader!
