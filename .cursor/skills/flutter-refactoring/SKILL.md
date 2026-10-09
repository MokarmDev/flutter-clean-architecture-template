---
name: flutter-refactoring
description: >-
  Safely refactors Flutter Clean Architecture code while preserving behavior,
  DI contracts, and layer boundaries. Use when renaming, extracting, cleaning
  stubs, or reducing duplication without feature changes.
---

# Flutter Refactoring

## Purpose

Improve structure without changing observable behavior.

## When to Use

- Rename/move within architecture
- Deduplicate (e.g. pagination params)
- Align stubs with home/Mason patterns as a dedicated task
- Extract shared widgets/use cases

## Preconditions

- Understand current behavior (read callers, tests if any)
- Search all usages before renames
- Do not mix large refactors into unrelated feature PRs

## Workflow

### Step 1 — Characterize behavior

Note inputs/outputs of cubits, repos, and routes involved.

### Step 2 — Find usages

Search symbols across `lib/`, `test/`, and `bricks/` if templates must stay aligned.

### Step 3 — Incremental changes

Prefer small steps: move → fix imports → analyze → next step.

### Step 4 — Preserve contracts

- Keep `Either<Failure, T>` at repo/use case boundaries for API features
- Keep GetIt registration names/lifetimes unless intentionally changing DI
- Preserve go_router paths used by deep links/tabs

### Step 5 — Validate

```bash
dart format .
flutter analyze
flutter test
```

### Step 6 — Review diff

Ensure no accidental feature changes or secret edits.

## Project-Specific Rules

- `home` is the target pattern when consolidating
- Theme’s non-Either style is intentional for local prefs — don’t force Either unless asked
- Update Mason brick if you change the canonical scaffold shape

## Validation

- [ ] Behavior preserved
- [ ] No layer violations introduced
- [ ] Analyzer clean

## Common Mistakes

- Rewriting cart/profile “while here” during an unrelated fix
- Introducing Freezed during a rename
- Editing `*.g.dart` instead of sources

## Definition of Done

Refactor complete, validated, diff limited to intended structural changes.
