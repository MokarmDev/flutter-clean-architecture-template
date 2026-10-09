---
name: flutter-feature-development
description: >-
  Implements a new feature-first Clean Architecture module using Mason, home as
  reference, GetIt, Cubit, Either, and go_router. Use when adding a feature,
  scaffolding with mason make feature, or wiring DI/routes/endpoints.
---

# Flutter Feature Development

## Purpose

Add a new feature that matches this template’s Clean Architecture without
copying cart/profile stubs.

## When to Use

- User asks to add a feature, module, or screen with data loading
- Scaffolding via Mason
- Completing stub features (`cart`, `profile`) properly

## Preconditions

- Read `lib/features/home/` as the behavioral reference
- Read `bricks/BRICKS_GUIDE.md` for Mason steps
- Confirm whether remote API, local cache, or both are needed

## Workflow

### Step 1 — Inspect similar features

Compare `home` (full) vs target needs. Note pagination/cache only if required.

### Step 2 — Scaffold

```bash
mason get
mason make feature --feature_name <snake> --entity_name <Pascal>
```

### Step 3 — Implement layers (dependency direction)

1. Domain entity + repository contract + `UseCase` returning `Either`
2. Model extends entity; manual `fromJson`/`toJson`
3. Remote DS returns raw data via `ApiConsumer` (not Either)
4. `RepositoryImpl` uses `safeCall`; optional Hive cache like home
5. Cubit + `CancelableSafeCubitMixin`; states Initial/Loading/Loaded/Error
6. Page: `BlocProvider(create: (_) => sl<XCubit>()..load...)`

### Step 4 — Wire project integration

1. `ApiEndpoints` entry
2. `initFeature()` in `injection_container.dart`
3. `RouteNames` + `app_router.dart` (+ `NavEnum` if tab)
4. Locale keys in `assets/translations/` + regenerate if UI strings added

### Step 5 — Validate

```bash
dart format lib/features/<feature>
flutter analyze
flutter test
```

Regenerate code if Hive/Envied annotations were added.

## Project-Specific Rules

- Do not construct cubits with `FeatureCubit()` — use `sl<>()`
- Do not return Either from remote data sources
- Do not introduce Freezed/json_serializable/Riverpod
- Prefer Mason output over cart/profile patterns

## Validation

- [ ] Domain has no Dio/Flutter UI imports (Hive on entity only if caching like home)
- [ ] DI: factory cubit, lazy singleton use case/repo/DS
- [ ] Route registered
- [ ] Analyze clean for touched files

## Common Mistakes

- Copying UnimplementedError stubs from cart/profile
- Skipping `safeCall` in repository
- Forgetting route or `init*` registration
- Hardcoded UI strings

## Definition of Done

Feature compiles, follows home/Mason layering, is registered in DI and router,
and includes basic tests for new business logic when practical.
