---
name: flutter-code-review
description: >-
  Reviews Flutter PRs for Clean Architecture violations, Cubit/DI issues,
  security, and missing tests. Use when reviewing diffs, PRs, or when the user
  asks for a code review.
---

# Flutter Code Review

## Purpose

Prioritize real defects over style nits for this template’s architecture.

## When to Use

- User asks for review of changes / PR
- After implementing a feature, before commit

## Preconditions

- Diff available (`git diff` / PR)
- Rules under `.cursor/rules/` are the project standard

## Workflow

### Step 1 — Scope

List touched features and whether they follow `home` vs stubs.

### Step 2 — Architecture

- Dependency direction respected?
- Domain free of Dio/UI (note existing Hive-on-entity exception)?
- Cubit talks to use cases, not data sources?

### Step 3 — Dart / errors

- Null safety and async correct?
- `safeCall` + Either used for API repos?
- Failures user-safe (no secrets)?

### Step 4 — Flutter UI

- LocaleKeys vs hardcoded strings?
- Loading/empty/error handled?
- Unnecessary rebuilds / missing const?

### Step 5 — State management

- Factory + `sl<>()` provision?
- Mixin for async API cubits?
- Side effects in listeners, not builders?

### Step 6 — Testing / security / performance

- Tests for new logic?
- Secrets, logging, secure storage misuse?
- Unbounded lists / missing pagination?

### Step 7 — Report

Use severity:

- Critical — must fix (crashes, layer breaks, secrets)
- Suggestion — should fix (stubs left wired wrong, missing Retry)
- Nice to have — optional polish

## Project-Specific Rules

- Flag cart/profile-style `UnimplementedError` / manual cubit construction in new code
- Flag Freezed/Riverpod/GetX introductions
- Do not demand Firebase or CI that the repo does not have

## Validation

Review covers architecture, Dart, Flutter, state, tests, security — with evidence from the diff.

## Common Mistakes

- Bike-shedding formatting already handled by `dart format`
- Ignoring DI/router wiring gaps
- Treating theme’s local pattern as a defect for preference-only code

## Definition of Done

Clear, prioritized findings tied to files; no contradictory advice vs `.cursor/rules`.
