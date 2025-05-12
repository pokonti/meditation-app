# Tynys Ber – Meditation & Mindfulness App

**Tynys Ber** is SwiftUI and UIKit based iOS application for guided meditation, mental wellness and relaxation. Powered by Firebase, the app delivers a modern and intuitive mindfulness experience suitable for both beginners and experienced meditators.


---

## Features

- **Meditation Audio Playback** (streamed via AVPlayer)
- **Favorite Courses** (toggle heart icon and filter in tab)
- **Search Functionality** Use keywords to search across titles and themes with real-time filtering.
- **Remote Content Fetching** (via `MeditationAPI.swift`)
- **Loading States & Error Handling**
- **Custom Course Cards** and sectioned UI layout
- **AudioPlayerView** with real-time progress, rewind, forward, and pause/play
- **Authentication** User login and registration are handled through Firebase authentication

---

## Architecture

- **MVVM (Model-View-ViewModel)** for separation of logic and UI
- **Custom Router (`AppRouter.swift`)** for UIKit-driven navigation
- **EnvironmentObject Injection** for global state sharing (auth, favorites, router)
- **SwiftUI + AVFoundation** for modern UI and media playback

---

### Technologies Used

- **SwiftUI & UIKit** 
- **AVFoundation** – for streaming and controlling meditation audio  
- **Firebase Auth** – secure authentication and user session management  
- **REST API** – to fetch all courses and meditations from a custom FastAPI backend  


## Getting Started

### Clone the Repository

```bash
git clone https://github.com/your-username/tynys-ber-app.git
cd tynys-ber-app
```

## API Reference

The app fetches data from the following endpoint:
```
https://laudable-liberation-production-53fd.up.railway.app/docs
```

### Response: Section

Each section contains metadata about a meditation course:

```
{
  "id": 1,
  "title": "Basics",
  "subtitle": "COURSE",
  "duration": "3–10 MIN",
  "image_url": "https://drive.google.com/uc?export=download&id=...",
  "meditations": [ ... ]
}
```

### Response: Meditation (inside a section)
```
{
  "id": 1,
  "title": "Morning Calm",
  "duration_sec": 420,
  "theme": "Gratitude",
  "drive_id": "https://...mp3",
  "image_url": "https://...",
  "section_id": 1
}
```
### Video Link
https://youtube.com/shorts/9huBKIk_fG8?feature=share 
