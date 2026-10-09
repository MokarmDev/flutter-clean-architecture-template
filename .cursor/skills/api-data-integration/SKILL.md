---
name: api-data-integration
description: Implement or debug REST API integration using the repository's existing Dio, data source, model, repository, and error-handling conventions.
---

# API and data integration

Thin approval wrapper. For the full Dio/`ApiConsumer` workflow, follow
`.cursor/skills/flutter-api-integration/SKILL.md`.

## Gates (do not skip)

1. Inspect real endpoints, interceptors, models, and `safeCall` usage first.
2. Never invent endpoint URLs, payload fields, auth headers, or response envelopes.
3. Ask approval before new packages, shared interceptor/auth changes, or env/secret changes.
