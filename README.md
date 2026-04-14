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
| `dio_cache_interceptor` | HTTP response caching via Dio interceptor |
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

Android (minSdk 21), iOS, Web

## Testing

Tests live under `test/`, mirroring the `lib/` folder structure.

```
test/
├── domain/
│   ├── models/        # Serialization tests for all domain models
│   │   ├── character_test.dart
│   │   ├── episode_test.dart
│   │   ├── location_test.dart
│   │   └── origin_test.dart
│   └── usecases/      # Unit tests for use cases (repository mocked)
│       ├── get_characters_usecase_test.dart
│       └── get_episodes_usecase_test.dart
├── mocks/             # Mockito-generated mocks
└── utils/             # Shared test helpers (dummy values)
```

**Model tests** verify `fromJson`/`toJson` against realistic API payloads, including nested objects (`Origin`, `Location`) and list fields. They act as a contract test between the model definitions and the API response shape.

**Use case tests** mock the repository layer and assert correct result propagation (`Ok`/`Error`) without hitting the network.

### Running tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Strip generated files from the coverage report
lcov --remove coverage/lcov.info '**/*.g.dart' '**/generated/*' -o coverage/lcov_cleaned.info

# Generate HTML report
genhtml coverage/lcov_cleaned.info -o coverage/html
open coverage/html/index.html
```

> Generated files (`*.g.dart`) are excluded from coverage because they are produced by `json_serializable` and not written by hand. The model classes themselves are covered through the serialization tests.

## Caching Strategy

HTTP responses are cached using `dio_cache_interceptor` with an in-memory store (`MemCacheStore`) and `CachePolicy.forceCache`. This means:

- Every response is cached for the lifetime of the app session.
- Subsequent identical requests are served from memory without hitting the network.
- **No TTL is set intentionally.** The Rick and Morty API is static — episodes and characters never change — so there is no value in expiring and re-fetching data that will always return the same result. Skipping TTL keeps the implementation simple and eliminates unnecessary network traffic.

The cache is wired at the `DioClient` level (`lib/core/network/dio_client.dart`), so it applies transparently to all requests made by the app.

## API

Data is sourced from the public [Rick and Morty REST API](https://rickandmortyapi.com/api):

| Endpoint | Usage |
|---|---|
| `GET /episode?page={page}` | Paginated episode list |
| `GET /character/{ids}` | Fetch characters by comma-separated IDs |
