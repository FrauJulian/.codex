---
name: csharp-modern
description: Use for implementing or reviewing modern C#/.NET code, including ASP.NET Core, EF Core, async APIs, nullability, performance, readability, testing, and secure backend design. Do not use for non-.NET languages.
---

# Modern C# engineering

Apply this skill when creating, modifying, or reviewing C# and .NET code.

## Workflow

1. Inspect the target framework, C# language version, nullable settings, analyzers, package versions, architecture, and tests.
2. Trace the actual execution path and identify public contracts.
3. Preserve repository conventions unless they cause a concrete defect.
4. Implement the smallest coherent change.
5. Build and run relevant tests.
6. Report changed behavior, validation, and residual risk.

## Correctness and API design

- Make invariants explicit through types, constructors, factories, and validation.
- Keep public APIs small and stable.
- Use nullable reference types accurately.
- Avoid null-forgiving operators unless the invariant is locally proven.
- Prefer clear result/error semantics over ambiguous nulls or magic values.
- Preserve culture, time-zone, precision, encoding, and serialization semantics.
- Use immutable data where it clarifies ownership; avoid copying large data without reason.
- Use records for value-like semantics, not automatically for every DTO.
- Keep methods cohesive and control flow direct.

## Async, concurrency, and resources

- Use asynchronous APIs for I/O and propagate CancellationToken.
- Avoid sync-over-async, async void outside event handlers, unobserved tasks, and fire-and-forget work.
- Make ownership and lifetime of background tasks explicit.
- Dispose synchronous and asynchronous resources correctly.
- Protect shared mutable state and document concurrency assumptions.
- Avoid holding locks across await.
- Use channels, concurrent collections, or synchronization primitives only when their semantics fit.
- Configure retries, timeouts, and idempotency together.

## ASP.NET Core

- Keep middleware order deliberate.
- Validate authentication and authorization at the server boundary.
- Use typed options and validate configuration at startup when practical.
- Return consistent errors, preferably using the repository's problem-details convention.
- Keep controllers/endpoints thin; move domain logic to appropriate services.
- Use correct dependency-injection lifetimes.
- Do not capture scoped dependencies in singletons.
- Propagate request cancellation.
- Apply rate limiting, request-size limits, and output caching only with explicit requirements.

## EF Core and data access

- Project only required columns.
- Avoid accidental N+1 queries and premature materialization.
- Use tracking only when changes will be persisted.
- Bound result sets and use stable pagination.
- Keep transaction boundaries explicit.
- Handle concurrency tokens and retries deliberately.
- Inspect generated SQL for performance-sensitive queries.
- Keep migrations safe for the supported deployment model.

## Performance

- Optimize known hot paths, not ordinary code by instinct.
- Start with algorithmic complexity, I/O count, database access, serialization, and allocation volume.
- Use Span<T>, Memory<T>, ArrayPool<T>, ValueTask, source generation, or unsafe code only with measured justification.
- Avoid LINQ in verified hot loops when a direct loop materially improves behavior; otherwise prioritize readability.
- Cache only with clear invalidation, ownership, size, and expiry rules.
- Benchmark representative inputs before making performance claims.

## Security

- Treat external input as untrusted.
- Use parameterized data access and safe serializers.
- Never log secrets, tokens, passwords, connection strings, or sensitive payloads.
- Use platform cryptography and password-hashing APIs.
- Preserve least privilege and server-side authorization.
- Avoid insecure deserialization, dynamic code loading, and reflection over untrusted data.

## Readability

- Use intention-revealing names.
- Prefer early returns over deep nesting.
- Avoid generic abstractions before a second concrete use case exists.
- Comments explain rationale, constraints, or non-obvious tradeoffs.
- Keep error messages actionable without exposing sensitive details.
- Follow the existing formatter and analyzers.

## Tests and validation

- Test behavior, boundaries, invalid input, cancellation, failure, and regressions.
- Prefer deterministic tests over sleeps and timing assumptions.
- Use integration tests for database, serialization, authentication, and framework boundaries where unit tests are insufficient.
- Never state that a command succeeded unless it was executed.
