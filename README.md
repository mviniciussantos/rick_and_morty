# Rick and Morty

A Flutter application for browsing episodes and characters from the [Rick and Morty API](https://rickandmortyapi.com/).

## Features

- **Episodes list** — Browse all Rick and Morty episodes with infinite scroll pagination. Each episode shows the season/episode code, name, and air date.
- **Characters per episode** — Tap any episode to view all characters that appeared in it, with their image, name, species, and status.

## Architecture

The project follows **Clean Architecture** with an **MVVM** presentation layer:

```
lib/
├── core/               # Shared utilities (Result type, pagination, date utils)
├── data/               # Repositories and API service (Dio-based)
│   ├── repositories/   # Abstract interfaces + remote implementations
│   └── services/api/   # Rick and Morty API client
├── domain/             # Business logic
│   ├── models/         # Data models (json_serializable)
│   └── usecases/       # Use cases
├── ui/                 # Presentation layer (MVVM)
│   ├── episodes/       # Episodes screen + ViewModel
│   └── characters/     # Characters screen + ViewModel
└── routing/            # GoRouter configuration
```

**State management:** `provider` — ViewModels extend `ChangeNotifier` and are injected via `MultiProvider` in `main.dart`.

**Error handling:** All repository/service methods return a `Result<T>` sealed class (`success` / `error`), avoiding raw exceptions in the UI.

## Tech Stack

| Package | Purpose |
|---|---|
| `dio` | HTTP client for API requests |
| `provider` | Dependency injection and state management |
| `go_router` | Declarative named routing |
| `json_serializable` | Code generation for JSON serialization |
| `cached_network_image` | Download and cache character images |
| `intl` | Date formatting |

## Getting Started

### Prerequisites

- Flutter SDK (Dart ^3.9.2)
- An internet connection (data is fetched live from the Rick and Morty API)

### Setup

```bash
# Install dependencies
flutter pub get

# Generate serialization code (required after model changes)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### Supported Platforms

Android (minSdk 21), iOS, Web, Windows, macOS.

## API

Data is sourced from the public [Rick and Morty REST API](https://rickandmortyapi.com/api):

| Endpoint | Usage |
|---|---|
| `GET /episode?page={page}` | Paginated episode list |
| `GET /character/{ids}` | Fetch characters by comma-separated IDs |
