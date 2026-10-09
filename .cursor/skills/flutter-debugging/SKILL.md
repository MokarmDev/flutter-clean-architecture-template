---
name: flutter-debugging
description: >-
  Debugs Flutter issues by layer (UI → Cubit → UseCase → Repository → DS)
  using logs, states, and Dio failures. Use when fixing bugs, crashes, empty
  screens, or incorrect emissions.
---

# Flutter Debugging

## Purpose

Find root cause with evidence; apply the smallest correct fix.

## When to Use

- Runtime bugs, wrong UI state, failed API loads
- Emit-after-close / cancelled request issues
- Flavor / env / DI misconfiguration

## Preconditions

- Reproduce with the correct flavor:
  `flutter run --flavor dev -t lib/main_dev.dart`
- Note stack traces and `AppBlocObserver` / Logger output

## Workflow

### Step 1 — Reproduce

Capture exact steps, flavor, and whether offline/cache applies.

### Step 2 — Identify layer

Trace: Page → Cubit state → UseCase → Repository (`safeCall`) → DataSource → Dio.

### Step 3 — Inspect evidence

- Cubit current state (`Loading` stuck? `Error` message?)
- Dio/LoggingInterceptor output (no secrets)
- Hive cache emptiness for home-like flows
- GetIt registration (missing `init*` or factory?)

### Step 4 — Root cause

Distinguish: network Failure, parse/FormatException, DI, routing, or UI-only.

### Step 5 — Minimal fix

Change only the failing layer. Prefer aligning stubs with home patterns when
cart/profile UnimplementedError is the cause.

### Step 6 — Regression

Add/adjust a test when feasible; re-run analyze/tests.

## Project-Specific Rules

- Do not “fix” by catching and swallowing in UI
- Do not switch state-management libraries to resolve a bug
- Theme issues → `ThemeCubit` / SharedPreferences path (no Either)

## Validation

- [ ] Bug no longer reproduces
- [ ] No unrelated behavior change
- [ ] `flutter analyze` clean for touched files

## Common Mistakes

- Speculative refactors without reproduction
- Treating cache fallback as a network success bug
- Ignoring cancelable mixin returning null after dispose

## Definition of Done

Root cause documented briefly; fix verified; regression guarded when practical.
