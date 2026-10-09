---
name: flutter-api-integration
description: >-
  Adds Dio API endpoints through ApiConsumer, models, safeCall repositories,
  and optional Hive cache fallback. Use when integrating REST APIs, pagination,
  or remote data sources.
---

# Flutter API Integration

## Purpose

Connect a feature to the backend using the existing Dio/`ApiConsumer` stack.

## When to Use

- New endpoint or remote data source
- Repository/network error mapping
- Cache fallback for remote lists

## Preconditions

- Base URL via FlavorConfig / Envied — do not hardcode production URLs in features
- Prefer existing `ApiEndpoints` constants

## Workflow

### Step 1 — Endpoint

Add path constant in `lib/core/constants/api_endpoints.dart`.

### Step 2 — Remote data source

Inject `ApiConsumer`. Call `get`/`post`/… Return models/entities. **Do not**
return `Either` here.

### Step 3 — Model mapping

Manual `fromJson`/`toJson`; model extends entity.

### Step 4 — Repository

```dart
return safeCall(() => remote.fetch(...));
// With cache: follow HomeRepositoryImpl fold pattern
```

### Step 5 — Use case + cubit

Use case implements `UseCase<T, Param>`; cubit folds result.

### Step 6 — Auth (when needed)

`SecureStorageService` + `ApiInterceptor` stubs exist — wire tokens carefully;
never log secrets.

### Step 7 — Validate

```bash
flutter analyze
# Manual: flutter run --flavor dev -t lib/main_dev.dart
```

## Project-Specific Rules

- Interceptors live under `lib/core/network/interceptors/`
- `ConnectivityInterceptor` is available but commented out in `DioConsumer`
- Pagination query via `PaginationParams` used by home

## Validation

- [ ] Errors become Failures via safeCall
- [ ] No Dio in presentation/domain (except documented Hive-on-entity exception)
- [ ] Env secrets not duplicated in code

## Common Mistakes

- Either in data source (cart/profile style)
- New HTTP client beside DioConsumer
- Ignoring cache fallback when offline UX is required

## Definition of Done

End-to-end path works: endpoint → DS → repo Either → use case → cubit → UI.
