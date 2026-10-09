---
name: clean-architecture
description: Inspect or change Dart code while preserving this repository's Clean Architecture dependency boundaries.
---

# Clean Architecture review and implementation

## Procedure
1. Locate the affected feature and inspect a neighboring implementation.
2. Identify which layer owns each responsibility before moving or adding code.
3. Confirm dependency direction: presentation → domain; data implements domain contracts; domain remains pure Dart (no Dio/Flutter UI/GetIt). Do not add new Hive annotations on domain — `home` `ProductEntity` is a known exception; prefer adapters outside domain for new cache.
4. Keep transport/storage details in data sources and map them to domain-facing types using the current repository convention.
5. Follow existing repository contracts, use-case signatures, `Either<Failure, T>` handling, and `safeCall` usage only where confirmed in source.
6. Check imports for forbidden inward-to-outward dependencies.
7. Check DI registration and routing only if the change requires them.
8. Add/update tests and run the narrowest relevant checks.
9. Report any pre-existing architectural violations separately; do not refactor unrelated code.

## Do not
- Introduce a new architecture package or framework without approval.
- Create abstractions only to satisfy a generic clean-architecture ideal.
- Move files across layers without explaining the benefit and impact.
- Assume every feature must have exactly the same files; follow actual patterns and the requirements.
