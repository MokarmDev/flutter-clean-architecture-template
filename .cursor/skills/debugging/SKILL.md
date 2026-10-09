---
name: debugging
description: Diagnose Flutter/Dart bugs from reproducible evidence and propose the smallest safe fix.
---

# Debugging workflow

Thin approval wrapper. For the layer-by-layer checklist, follow
`.cursor/skills/flutter-debugging/SKILL.md`.

## Gates (do not skip)

1. Reproduce with the narrowest command or test before editing.
2. Separate facts from hypotheses; do not invent API behavior.
3. Prefer the smallest fix; ask before broad refactors, dependency changes, or shared config edits.
4. Do not suppress exceptions, disable lints, or weaken tests to hide the symptom.
