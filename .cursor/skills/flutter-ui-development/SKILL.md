---
name: flutter-ui-development
description: >-
  Builds Flutter pages and widgets using ScreenUtil, AppTheme, LocaleKeys,
  shared widgets, and home loading/empty/error patterns. Use when creating or
  editing UI, pages, themes, or localization strings.
---

# Flutter UI Development

## Purpose

Implement UI consistent with existing theme, i18n, and state presentation.

## When to Use

- New/edited pages or widgets
- Theme, spacing, or localization UI work
- Loading / empty / error UI

## Preconditions

- Check `lib/config/theme/` and `lib/shared/widgets/`
- Check `home` presentation widgets for list/grid patterns
- Prefer existing shared widgets before creating new ones

## Workflow

### Step 1 — Place files

- Page → `presentation/pages/`
- Feature widgets → `presentation/widgets/`
- Cross-feature → `lib/shared/widgets/`

### Step 2 — Provide state

Wrap page body with `BlocProvider` using `sl<Cubit>()`. Use `BlocBuilder` for
UI; `BlocListener` for one-off side effects.

### Step 3 — Apply design system

- Sizing: `.w` / `.h` / `.sp` (ScreenUtil)
- Text styles: `Theme.of(context).textTheme.*`
- Colors: `AppColors` / theme — avoid one-off hex when theme tokens exist
- Strings: `LocaleKeys` / `.tr()` — update JSON then regenerate keys

### Step 4 — State views

| State | UI |
|-------|-----|
| Loading | `LoadingWidget` (home pattern); `ProductCardShimmer` exists but unused |
| Empty | `NoDataFoundWidget` |
| Error | message + Retry calling cubit method |
| Loaded | list/grid builders |

### Step 5 — Images & forms

- Network images via shared cached image widget + error handling
- TextFields: capitalization, keyboardType, textInputAction

### Step 6 — Validate

```bash
flutter analyze
```

## Project-Specific Rules

- Material app with custom font `TheYearofHandicrafts`
- Bottom tabs via shell + `CustomBottomNavBar`
- No SnackBars as default error UX

## Validation

- [ ] Prefer `LocaleKeys` for new user-facing strings (do not copy home's remaining hardcoded strings)
- [ ] const where possible
- [ ] Matches home empty/error/loading approach

## Common Mistakes

- Building lists with non-builder Column of many children
- Ignoring ScreenUtil
- Creating parallel color systems outside `AppColors`/`AppTheme`

## Definition of Done

UI matches theme and i18n, handles loading/empty/error, and rebuilds only as needed.
