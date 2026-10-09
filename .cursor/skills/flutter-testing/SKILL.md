---
name: flutter-testing
description: >-
  Adds unit/widget tests for use cases, repositories, and cubits using fakes
  against Clean Architecture contracts. Use when writing tests, fixing
  widget_test, or validating feature behavior.
---

# Flutter Testing

## Purpose

Add tests that match this architecture despite the currently thin suite.

## When to Use

- New business logic
- Bug fixes (regression tests)
- Replacing the obsolete counter `widget_test.dart`

## Preconditions

- No mockito/mocktail in pubspec yet — use hand-written fakes implementing
  repository contracts, or add mocktail if user agrees
- Prefer testing behavior at use case / cubit / repo boundaries

## Workflow

### Step 1 — Choose scope

| Change | Prefer |
|--------|--------|
| Use case / mapping | Unit test with fake repository |
| safeCall / cache | Repository test with fake DS |
| State transitions | Cubit test |
| Loading/empty/error UI | Widget test + BlocProvider |

### Step 2 — Place files

Mirror `lib/` under `test/features/<feature>/...`.

### Step 3 — Write fakes

Implement domain repository interfaces; return `Right`/`Left` deliberately.

### Step 4 — Assert behavior

- Cubit: emit Loading then Loaded/Error
- Repo: on network fail with cache → Right(cache)
- Avoid testing private fields or Dio internals

### Step 5 — Run

```bash
flutter test
flutter analyze
```

## Project-Specific Rules

- Fix or remove counter expectations in `test/widget_test.dart` when touching tests
- Do not require integration_test unless user asks
- Keep tests independent of real network

## Validation

- [ ] Tests fail for the right reason when logic breaks
- [ ] No secrets in fixtures

## Common Mistakes

- Testing implementation details of mixin internals
- Hitting dummyjson in unit tests
- Asserting on pixel-perfect layout

## Definition of Done

Relevant tests pass; new logic has at least one focused test when practical.
