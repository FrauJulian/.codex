---
name: reviewer-performance-security-readability
description: Use for code or pull-request reviews where performance, security, correctness, and especially readability/maintainability must be assessed. Produces evidence-based findings, not cosmetic style commentary.
---

# Performance, security, and readability review

Review code as an owner. Prioritize real defects and future defect risk over personal style preference.

## Workflow

1. Identify the requested behavior and comparison base.
2. Inspect the diff plus surrounding execution paths, call sites, tests, configuration, data models, and migrations.
3. Separate regressions introduced by the change from existing issues.
4. Report findings in severity order.
5. Include only actionable findings with evidence.
6. Summarize validation gaps and overall risk.

## Correctness

Check:
- Success, failure, invalid-input, null, empty, boundary, and partial-result paths.
- State transitions and invariants.
- API, schema, serialization, and persistence compatibility.
- Transactions, concurrency, retries, cancellation, cleanup, and idempotency.
- Time, culture, precision, ordering, and pagination semantics.
- Error handling and recoverability.
- Test determinism and meaningful assertions.

## Security

Check:
- Authentication and authorization at every trust boundary.
- Object-level and tenant-level access control.
- Injection, unsafe rendering, path handling, SSRF, deserialization, and file handling.
- Secret and sensitive-data exposure.
- Cryptography and token validation.
- Browser security controls when applicable.
- Dependency and configuration risk.
- Resource exhaustion and abuse paths.

Do not inflate severity. State exploit preconditions.

## Performance

Check:
- Algorithmic complexity.
- Unbounded collections, loops, recursion, concurrency, and payloads.
- N+1 database or network operations.
- Query shape, indexes, transactions, lock duration, and pagination.
- Excessive allocation, serialization, copying, reflection, or parsing.
- Blocking I/O, sync-over-async, missing cancellation, and resource leaks.
- Frontend rendering, subscriptions, DOM/visual-tree size, and bundle impact.
- Cache correctness, invalidation, size, and stampede behavior.

Do not report speculative micro-optimizations. Require measurement or a clear complexity/resource argument.

## Readability and maintainability

Readability is a correctness multiplier. Report readability problems only when they materially increase defect risk.

Check:
- Names that conceal behavior or units.
- Functions with multiple unrelated responsibilities.
- Deep nesting and non-local control flow.
- Hidden mutation and unclear ownership.
- Boolean parameters, magic values, duplicated domain rules, and implicit contracts.
- Overly generic abstractions and premature frameworks.
- Comments that contradict code or explain syntax instead of rationale.
- Error paths that are harder to follow than success paths.
- Tests that obscure intent.

Prefer simplification over new abstraction unless repeated variation proves an abstraction is needed.

## Finding format

For each finding:
- Severity: critical, high, medium, or low.
- Category: correctness, security, performance, readability, test, or operations.
- Location.
- Evidence and reachable path.
- Impact.
- Concrete minimal fix.
- Suggested verification.
- Confidence.

Do not include praise, generic summaries, or cosmetic nits in the findings list.
