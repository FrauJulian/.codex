---
name: typescript-modern
description: Use for implementing or reviewing strict modern TypeScript in Node.js, browser, frontend, API, or utility projects, with focus on type safety, runtime validation, readability, security, performance, testing, and module compatibility.
---

# Modern TypeScript engineering

Apply this skill when creating, modifying, or reviewing TypeScript.

## Workflow

1. Inspect tsconfig, runtime targets, module system, package manager, framework, linting, formatting, tests, and package versions.
2. Trace runtime behavior and external boundaries.
3. Preserve public types, serialized shapes, and compatibility requirements.
4. Implement the smallest coherent change.
5. Run type checking, linting, and relevant tests.
6. Report validation and remaining risks.

## Type system

- Keep strict mode enabled.
- Avoid any. Use unknown for untrusted values, then validate and narrow.
- Prefer discriminated unions, exhaustive switches, branded/domain types, and precise generics.
- Avoid broad type assertions, double casts, and non-null assertions.
- Do not encode runtime assumptions only in compile-time types.
- Keep inferred types where obvious; add annotations at public boundaries and where inference hides intent.
- Use satisfies when it validates shape without widening.
- Prefer readonly semantics when ownership is not transferred.

## Runtime boundaries

Validate values from:
- HTTP requests and responses.
- Environment variables.
- Files, storage, databases, queues, and browser persistence.
- postMessage, workers, plugins, and third-party libraries.
- JSON.parse and other deserialization.

Return actionable validation errors without exposing secrets or internal details.

## Async and resource handling

- Handle every Promise intentionally.
- Avoid floating promises and swallowed rejections.
- Use AbortSignal when the platform or framework supports cancellation.
- Run independent work concurrently only when ordering and rate limits allow it.
- Avoid unbounded Promise.all over large or attacker-controlled collections.
- Clean up listeners, timers, subscriptions, streams, and observers.
- Define timeout, retry, backoff, and idempotency semantics together.

## Modules and dependencies

- Preserve the project's ESM/CJS strategy.
- Respect package exports, browser targets, Node versions, and bundler constraints.
- Avoid default-import interop assumptions not supported by configuration.
- Prefer existing dependencies and platform APIs.
- Consider bundle size, tree shaking, side effects, and transitive dependency risk.
- Do not add a dependency for trivial functionality.

## Security

- Never expose server secrets to browser code.
- Avoid eval, Function, unsafe HTML injection, and dynamic code execution.
- Encode or render text safely at output boundaries.
- Validate URLs, paths, redirects, origins, and uploaded files.
- Enforce authorization server-side.
- Avoid prototype-pollution patterns and unsafe object merging.
- Redact sensitive data from logs and telemetry.

## Performance

- Fix algorithmic and I/O problems before micro-optimizing.
- Avoid repeated parsing, serialization, DOM querying, and unnecessary object churn in hot paths.
- Bound concurrency and collection sizes.
- Prefer streaming for large payloads when the runtime supports it.
- Measure frontend rendering and Node.js hot paths before claiming improvement.
- Keep caching explicit about key, ownership, invalidation, size, and expiry.

## Readability

- Use direct control flow and intention-revealing names.
- Keep functions cohesive.
- Prefer explicit domain logic over clever type tricks.
- Use comments for rationale and constraints.
- Avoid premature framework abstractions and generic utility layers.
- Follow the repository formatter and lint rules.

## Tests

- Cover valid behavior, invalid input, async rejection, cancellation, boundary values, serialization, and regression cases.
- Keep tests deterministic.
- Test runtime validation; compile-time assertions alone are insufficient.
- Never report commands as successful unless executed.
