# YT Downloader

A simple and clean native macOS application for downloading YouTube videos and audio.

YT Downloader provides an easy-to-use graphical interface for downloading individual YouTube videos or playlists without requiring users to work directly with command-line tools.

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
- 🚫 No Subtitles option
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
- 📜 Fully scrollable interface for comfortable use on different window sizes
- 📂 Automatically organize playlist downloads using the playlist name

---

# 📸 Screenshots

Screenshots of the application can be added here.

Suggested screenshots:

- Main application window
- Video download
- Audio download
- Playlist download
- Subtitle selection
- Download progress
- Playlist progress
- Completed download

Example:

[Application Screenshot]
💻 Requirements

To build and run YT Downloader from source, you need:

A Mac
macOS
Xcode
Internet connection

Xcode is required if you want to build the application from source code.

📥 Installation

There are currently two ways to use YT Downloader.

Method 1 — Build From Source

You can build the application yourself using Xcode.

This is currently the recommended method if you want to use the latest version of the source code.

Method 2 — Pre-built Release

A pre-built version may be provided through the GitHub Releases section in the future.

Pre-built releases will be added when available.

🛠️ Build From Source

If you want to modify or build YT Downloader yourself, follow these steps.

1. Clone the Repository

Open Terminal and run:

git clone https://github.com/CaptJackSparrow21/Projects.git
2. Go to the Project Directory

The YT Downloader project is located inside:

Projects/
└── Just for Fun/
    └── YT Downloader/

Run:

cd Projects/"Just for Fun"/"YT Downloader"
3. Open the Xcode Project

Open the Xcode project:

open "YT Downloader.xcodeproj"

You can also open the .xcodeproj file manually using Finder.

4. Select the Application Target

Inside Xcode:

Select the YT Downloader project.
Select the YT Downloader target.
Make sure the platform is set to macOS.
Select your Mac as the run destination.
5. Build and Run

Press:

⌘ + R

or click the Run ▶ button in Xcode.

Xcode will build the application and launch it on your Mac.

▶️ Using YT Downloader

Using YT Downloader is simple.

The basic workflow is:

YouTube URL
     ↓
Download Type
     ↓
Format
     ↓
Quality
     ↓
Subtitles
     ↓
Save Location
     ↓
Download
Step 1: Copy a YouTube URL

Open YouTube and copy the URL of the video or playlist you want to download.

For a video, the URL may look like:

https://www.youtube.com/watch?v=XXXXXXXXXXX

For a playlist, the URL may look like:

https://www.youtube.com/playlist?list=XXXXXXXXXXX
Step 2: Paste the URL

Open YT Downloader and paste the URL into:

YouTube URL

You can paste the URL using:

⌘ + V
Step 3: Select Download Type

Choose between:

Single Video

Use this when downloading one YouTube video.

Playlist

Use this when downloading a YouTube playlist.

Step 4: Select Format

Choose:

Video

Use this to download the video.

Audio

Use this when you only want the audio.

Step 5: Select Quality

For video downloads, select the desired quality.

Depending on the YouTube video, available qualities may include:

Best Available
4K
1080p
720p
480p
Other available qualities

The available quality depends on the source video.

Best Available

The Best Available option selects the best suitable quality available for the video, up to the supported limit.

Step 6: Select Subtitles

If subtitles are available, select the desired subtitle option.

Available options include:

English
English Auto-generated
All Subtitles
No Subtitles

The application can download available subtitles and embed them into the video when supported.

English

Downloads available English subtitles.

English Auto-generated

Uses YouTube's automatically generated English subtitles when available.

All Subtitles

Downloads all available subtitle languages.

No Subtitles

Does not download or embed subtitles.

Step 7: Choose Save Location

By default, downloads are saved to:

~/Downloads

You can select another folder using:

Choose Folder

Select the folder where you want your downloaded files to be stored.

Step 8: Start Download

Click:

Download

The application will start downloading the selected content.

During the download, the application displays the current download information and progress.

🎥 Downloading a Single Video

To download a single video:

Copy the YouTube video URL.
Paste it into the URL field.
Select Single Video.
Select Video or Audio.
If downloading video, select the desired quality.
Select your subtitle preference.
Choose the save location.
Click Download.

The application will download the selected content.

🎵 Downloading Audio

To download only audio:

Paste the YouTube URL.
Select Single Video or Playlist.
Select Audio.
Choose the available audio option.
Select the save location.
Click Download.

The application will download the audio from the selected content.

📚 Downloading a Playlist

To download a playlist:

Copy the YouTube playlist URL.
Paste it into the URL field.
Select Playlist.
Select Video or Audio.
Choose the desired options.
Choose the save location.
Click Download.

The application will process the videos contained in the playlist.

📊 Playlist Progress

When downloading a playlist, the application displays the current playlist progress.

For example:

7 / 9

means:

7 videos
out of
9 total videos

The currently downloading video is also displayed.

The progress information makes it easy to understand how much of the playlist has already been processed.

📂 Playlist Folder Organization

When downloading a playlist, the application uses the playlist name for the folder rather than a generic folder name.

For example:

Downloads/
└── My YouTube Playlist/
    ├── Video 1
    ├── Video 2
    ├── Video 3
    └── ...

This makes it easier to identify and organize downloaded playlists.

📝 Subtitle Handling

YT Downloader supports subtitle downloading and embedding.

When subtitles are selected, the application processes the subtitle files and embeds them into the video when supported.

The goal is to keep the final download folder clean and focused on the downloaded media.

For example, instead of having multiple separate subtitle files:

video.mp4
video.en.vtt
video.en-US.vtt

the selected subtitles can be embedded into the video when supported.

📊 Download Progress

While downloading, YT Downloader displays information about the current operation.

The application can display:

Download progress
Current video
Download speed
Estimated time remaining (ETA)
Playlist progress

For example:

Downloading...

7 / 9

Currently downloading
Video Title

Speed
...

ETA
...
⏱️ ETA

The application displays an estimated time remaining during supported downloads.

The ETA provides an approximate indication of how much time is left for the current download operation.

The actual time may change depending on:

Internet speed
Server conditions
Video size
Download speed
Number of videos remaining
🚀 Download Speed

While downloading, the application displays the current download speed.

The displayed speed can change during the download depending on network and server conditions.

❌ Cancel Download

If a download is currently running, the application provides a:

Cancel

button.

Clicking the button cancels the active download operation.

📁 Download Location

The default download location is:

~/Downloads

You can change it using the:

Choose Folder

button.

You can select any folder that you want to use for downloaded content.

🖥️ User Interface

YT Downloader is designed as a native macOS application.

The main interface contains:

YT Downloader

YouTube URL
────────────────────────────

Download Type
[ Single Video ] [ Playlist ]

Format
[ Video ] [ Audio ]

Quality
[ Best Available (up to 4K) ]

Subtitles
[ English ]

Subtitle Information

Save Location
[ Choose Folder ]

[ Download ]

During a download, additional information appears below the main controls.

📜 Scrollable Interface

The application uses a fully scrollable interface rather than trying to fit every control and download detail into one fixed-size window.

This makes it easier to access:

Download controls
Progress
Current video
Speed
ETA
Playlist progress
Other download information

Simply scroll through the application window when additional information appears below the main controls.

🔧 Troubleshooting
The Application Does Not Open

If macOS displays a security warning for an unsigned application:

Open System Settings.
Go to Privacy & Security.
Look for the security message related to YT Downloader.
If you trust the application, allow it to open.

This may happen when running a locally built or unsigned application.

Download Does Not Start

Check the following:

Make sure the YouTube URL is correct.
Make sure your Mac is connected to the internet.
Try opening the URL in a browser.
Make sure the video or playlist is accessible.
Try another YouTube URL.
Video Quality Is Unavailable

Not every YouTube video provides every quality.

For example, a particular video may not have 4K available.

Try:

Best Available

or another available quality.

The actual available quality depends on the source video.

Subtitles Are Unavailable

Not every YouTube video has subtitles.

If subtitles are unavailable, the application may not be able to download or embed them.

If subtitles are not required, select:

No Subtitles
Playlist Download Does Not Work

Make sure the URL is a valid YouTube playlist URL.

For example:

https://www.youtube.com/playlist?list=XXXXXXXXXXX

Also make sure:

The playlist is accessible.
The videos are available.
The URL was copied correctly.
Your Mac has an active internet connection.
ETA or Download Information Is Not Immediately Visible

The application uses a scrollable interface.

If the download information appears below the main controls, simply scroll down to view:

Current video
Progress
Speed
ETA
Playlist progress
🔐 macOS Security

A locally built or unsigned macOS application may trigger a Gatekeeper security warning.

This can happen because the application has not been signed and notarized through Apple's distribution process.

If a future release is signed and notarized, installation should be smoother.

🧑‍💻 Technology

YT Downloader is a native macOS application developed using Apple's development tools and Swift/SwiftUI.

The project uses:

Swift
SwiftUI
AppKit
Xcode

The application provides a graphical user interface instead of requiring users to operate the downloader through Terminal commands.

🛠️ Development

If you want to modify the application:

Clone the repository.
Open the YT Downloader Xcode project.
Make your changes.
Build and test the application.
Commit your changes.
Push them to GitHub.

Example:

git clone https://github.com/CaptJackSparrow21/Projects.git

Then:

cd Projects/"Just for Fun"/"YT Downloader"

Open the project:

open "YT Downloader.xcodeproj"
📂 Project Structure

The project is part of the larger Projects repository.

Projects/
│
├── Just for Fun/
│   │
│   └── YT Downloader/
│       │
│       ├── README.md
│       ├── LICENSE
│       │
│       ├── YT Downloader.xcodeproj
│       │
│       ├── YT Downloader/
│       │   │
│       │   ├── ContentView.swift
│       │   ├── DownloadManager.swift
│       │   └── ...
│       │
│       └── ...
│
└── ...
🔄 Updating the Project

If you have already cloned the repository and want to get the latest changes:

git pull

Then open the project in Xcode and build it again.

🤝 Contributing

This project is primarily maintained by the author.

Suggestions, bug reports, and feedback are welcome.

If you find a bug or have an idea for improving YT Downloader, you can open a GitHub Issue.

However, the source code and project remain under the ownership and usage restrictions described in the LICENSE file.

Unauthorized modification, redistribution, or publication of modified versions is not permitted.

🐛 Reporting Bugs

When reporting a bug, please provide as much information as possible.

Useful information includes:

macOS version
Application version
Steps to reproduce the issue
Expected behavior
Actual behavior
Error message
Screenshot if applicable

Example:

macOS:
Application Version:

Steps:
1. Open YT Downloader
2. Paste URL
3. Select Playlist
4. Click Download

Expected:
Playlist should download.

Actual:
Download stops after the first video.
💡 Feature Requests

If you have an idea for a new feature, you can open an issue.

Some useful information to include:

Feature name
What the feature should do
Why it would be useful
Example of how you would use it
🚀 Future Improvements

Possible future improvements include:

 Download queue
 Pause and resume downloads
 Multiple simultaneous downloads
 Download history
 Drag-and-drop URL support
 Improved playlist management
 More video quality options
 More audio options
 Better filename management
 Improved error handling
 Improved progress information
 Automatic update support
 Signed macOS application
 Apple notarization
 .dmg installer
 Easier one-click installation
 More customization options
⚖️ Disclaimer

This project is intended for downloading content that you are legally allowed to download.

Downloading content from YouTube may be subject to:

YouTube's Terms of Service
Copyright laws
Local laws and regulations
Rights belonging to the content creator

Users are responsible for ensuring that they have the necessary rights or permissions to download and use any content.

Only download content that you are legally permitted to download.

The developer does not encourage copyright infringement or unauthorized distribution of copyrighted material.

🔒 License and Copyright

Copyright © 2026 CaptJackSparrow21

All rights reserved.

This project and its source code are proprietary.

The source code is publicly available on GitHub for viewing and reference purposes, but public availability does not grant permission to modify, redistribute, republish, sublicense, sell, or create derivative works from the source code or application.

You may:
View the source code.
Download the project for personal reference.
Build the application for personal use, subject to the applicable terms.
You may not:
Modify and redistribute the project.
Publish modified versions.
Redistribute the source code as your own.
Sell the source code or application.
Create and distribute derivative versions.
Remove copyright or ownership notices.
Re-upload the project to another repository as your own.

Any permission outside these terms must be obtained from the copyright holder.

See the LICENSE file in this repository for the complete terms.

👨‍💻 Author

Created by CaptJackSparrow21

GitHub:

https://github.com/CaptJackSparrow21

⭐ Support the Project

If you find YT Downloader useful, you can support the project by:

⭐ Starring the repository
🐛 Reporting bugs
💡 Suggesting features
📢 Sharing the project

Please do not redistribute or modify the project without permission.

📌 Project Status

Active Development

YT Downloader is currently being developed as a personal project.

Features and behavior may change as development continues.

🔗 Project Repository

The complete project repository is available on GitHub:

https://github.com/CaptJackSparrow21/Projects
