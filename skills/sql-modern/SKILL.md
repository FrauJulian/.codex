---
name: sql-modern
description: Use for Microsoft SQL Server or MariaDB schema design, SQL implementation, query review, migrations, indexes, transactions, execution-plan analysis, correctness, security, and measured performance. Detect and preserve the target dialect.
---

# Modern SQL for SQL Server and MariaDB

Apply this skill only after identifying the target engine and supported version.

## Workflow

1. Inspect schema, constraints, indexes, migrations, data-access code, transaction behavior, and representative data size.
2. Identify the target dialect: Microsoft SQL Server or MariaDB.
3. State assumptions about cardinality, nullability, uniqueness, collation, time, precision, and concurrency.
4. Write the smallest safe query or migration.
5. Validate syntax and inspect execution behavior when tooling is available.
6. Report migration safety, index impact, transaction behavior, and validation.

## Correctness

- Preserve data types, precision, scale, signedness, collation, nullability, defaults, and foreign-key semantics.
- Use explicit column lists for INSERT and production SELECT statements.
- Make ordering deterministic when consumers depend on order.
- Handle NULL using correct three-valued logic.
- Use stable pagination appropriate to the engine and access pattern.
- Keep time-zone and timestamp semantics explicit.
- Ensure aggregates, joins, and grouping preserve intended cardinality.
- Avoid accidental duplicate rows from one-to-many joins.
- Define conflict, upsert, and idempotency behavior explicitly.

## Security

- Parameterize externally influenced values.
- Never concatenate identifiers or SQL fragments from untrusted input.
- Allow-list dynamic identifiers when dynamic SQL is unavoidable.
- Use least-privilege database accounts.
- Do not expose credentials or production data.
- Avoid overly broad grants and insecure definer/execution contexts.
- Never run destructive SQL without explicit authorization.

## Performance

- Start with query shape, cardinality, I/O, sort/hash operations, scans, lookups, and lock duration.
- Keep predicates SARGable.
- Avoid implicit conversions on indexed columns.
- Select only required columns.
- Prefer set-based operations.
- Design indexes for concrete query patterns, accounting for key order, selectivity, covering, storage, writes, and maintenance.
- Do not add duplicate or speculative indexes.
- Inspect actual execution plans for high-impact queries when possible.
- Update statistics or maintenance strategy only when evidence supports it.
- Bound batch sizes for large writes and migrations.

## Transactions and concurrency

- Keep transactions as short as correctness allows.
- Choose isolation from actual consistency requirements.
- Account for deadlocks, lock escalation, gap/range locking, retries, and idempotency.
- Keep application retry behavior consistent with transaction semantics.
- Avoid user interaction or remote calls inside database transactions.
- Preserve deterministic lock ordering where possible.

## Migration safety

- Prefer additive, backward-compatible changes for rolling deployments.
- Separate schema expansion, application rollout, backfill, and cleanup when necessary.
- Backfill in bounded, resumable batches.
- Validate data before adding stricter constraints.
- Plan rollback or forward-fix behavior.
- Account for table locking and online-operation support by engine/version.
- Never assume a migration is safe solely because it is syntactically valid.

## SQL Server notes

Consider:
- Parameter sensitivity and plan reuse.
- Clustered/nonclustered and filtered indexes.
- Included columns.
- Statistics and cardinality estimation.
- Snapshot-based isolation.
- Temp tables versus table variables.
- Lock escalation and online operation availability.

## MariaDB notes

Consider:
- MariaDB version-specific syntax and optimizer behavior.
- EXPLAIN and ANALYZE output.
- Storage engine and transaction semantics.
- Prefix indexes, generated columns, and collations.
- Gap locking and isolation behavior.
- Differences from MySQL; do not assume equivalence.

## Review output

For every material issue include:
- Engine and version assumption.
- Location/query.
- Correctness or performance impact.
- Evidence.
- Concrete replacement or migration approach.
- Validation plan.
