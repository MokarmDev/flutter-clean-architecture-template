---
name: testing
description: Create and run focused Dart and Flutter tests following this repository's existing test conventions.
---

# Testing workflow

Thin approval wrapper. For the full testing workflow, follow
`.cursor/skills/flutter-testing/SKILL.md`.

## Gates (do not skip)

1. Inspect existing `test/` conventions and dependencies first.
2. No real network or credentials in unit tests.
3. Do not add testing packages or restructure the suite without approval.
4. Replace `widget_test.dart` only when the task explicitly includes tests or that file.
5. Report command results honestly; never claim unrun checks passed.
