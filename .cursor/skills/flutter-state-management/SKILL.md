---
name: flutter-state-management
description: >-
  Implements Cubit + Equatable states with CancelableSafeCubitMixin, GetIt
  factories, and Either folding. Use when adding or fixing cubits, states,
  BlocProvider wiring, or pagination state.
---

# Flutter State Management

## Purpose

Create or fix Cubit-based state following this project’s lifecycle and DI rules.

## When to Use

- New cubit/state
- Fixing emit-after-close or cancelled requests
- Wiring BlocProvider / AppProviders
- Pagination / refresh behavior

## Preconditions

- Confirm Cubit (not Bloc events) is required
- Locate matching use case already registered in GetIt

## Workflow

### Step 1 — Define states

Abstract `Equatable` + `Initial` / `Loading` / `Loaded` / `Error`.

### Step 2 — Implement cubit

```dart
class XCubit extends Cubit<XState> with CancelableSafeCubitMixin<XState> {
  XCubit(this.useCase) : super(XInitial());
  // runCancelable(useCase.call(...)) then fold → safeEmit
}
```

### Step 3 — Register DI

`registerFactory(() => XCubit(sl()))` in feature injection.

### Step 4 — Provide in UI

`BlocProvider(create: (_) => sl<XCubit>()..load())` — never `XCubit()` directly
for feature pages.

### Step 5 — Pagination (if needed)

Follow `ProductCubit`: internal list, `hasReachedMax`, skip/limit,
`isRefresh` clears state.

### Step 6 — Validate

Analyze + unit-test fold paths when logic is non-trivial.

## Project-Specific Rules

- Global theme: `ThemeCubit` in `AppProviders` (exception: no Either)
- API cubits must fold Either and use mixin
- `AppBlocObserver` already logs in debug — do not duplicate verbose logging

## Validation

- [ ] Factory registration
- [ ] safeEmit / runCancelable used for async API cubits
- [ ] UI does not call repositories

## Common Mistakes

- Manual cubit construction bypassing GetIt
- Emitting without checking closed state
- Bloc event classes for simple loads

## Definition of Done

Cubit is DI-wired, cancel-safe, and maps Either to UI states correctly.
