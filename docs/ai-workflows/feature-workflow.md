# Feature workflow for Cursor

Use this workflow for a new feature or a cross-layer feature change.

## Prompt template

> Implement the following feature in this repository: **[describe requirement]**.
>
> First inspect the existing source, README, dependencies, `home` feature, Mason brick, DI, routing, and tests. Do not assume files or patterns that have not been verified.
>
> Phase 1 — Plan: use `architecture-planner` to return the data/state flow, candidate files, tests, risks, and approval gates. Do not edit until the plan is clear.
>
> Phase 2 — Implement: after the plan is accepted, use `feature-implementer` and `api-data-specialist` only for their scoped responsibilities. Prefer Mason if its actual output matches existing conventions. Do not add dependencies or perform broad refactors without asking.
>
> Phase 3 — Verify: use `test-engineer` to add/run focused tests and relevant analyzer/format checks.
>
> Phase 4 — Review: use `code-reviewer` and, for security-sensitive changes, `security-reviewer`. Reviewers must not edit files.
>
> Pause for my approval before dependency changes, architecture/public API changes, deleting/renaming files, bulk generation, environment/build/signing changes, security-sensitive changes, or destructive commands.
>
> Final response: summarize the implementation, files changed, checks run and results, outstanding risks, and decisions awaiting approval.

## Completion checklist

- [ ] Existing patterns inspected and reused.
- [ ] No unapproved dependency or architecture changes.
- [ ] Feature is wired into DI/routing only as required.
- [ ] Tests cover relevant success and failure behavior.
- [ ] Formatting/analyzer/test results are reported accurately.
- [ ] Diff contains no unrelated edits or accidental secrets.
- [ ] Important decisions and remaining risks are explicit.
