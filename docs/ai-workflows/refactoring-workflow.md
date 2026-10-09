# Refactoring workflow for Cursor

1. Define the refactoring goal and behavior that must remain unchanged.
2. Inspect call sites, public APIs, tests, and architecture boundaries.
3. Use `architecture-planner` to propose the smallest sequence of changes and list compatibility risks.
4. Ask the user before broad refactors, public API changes, file moves/renames, dependency changes, or generated-file operations.
5. Refactor in small steps; keep behavior changes separate from structural changes.
6. Run focused tests after each meaningful step, then broader checks.
7. Use `code-reviewer` to inspect the diff without editing it.
8. Report what changed, what behavior is preserved, and which checks were run.
