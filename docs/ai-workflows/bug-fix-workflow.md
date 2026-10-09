# Bug-fix workflow for Cursor

1. Ask for missing reproduction details only when needed.
2. Inspect `git status`, related source, logs, and tests.
3. Use `bug-investigator` for read-only root-cause analysis.
4. Present the evidence and proposed minimal fix. Ask for approval if the fix crosses an approval gate.
5. Implement the smallest fix and add a regression test when practical.
6. Run the reproducer, relevant tests, and analyzer/format checks where available.
7. Use `code-reviewer` for an independent read-only review.
8. Report root cause, changed files, commands/results, and unresolved concerns.

Never make unrelated refactors or silence an exception/lint/test to hide the bug.
