# PostgreSQL runtime status

**Status: PASS — ACTUAL POSTGRESQL 18 EXECUTION COMPLETED**

A live verification run was completed on **2026-09-09** against a dedicated, isolated Neon PostgreSQL project running:

`PostgreSQL 18.6 (c5250a2) on aarch64-unknown-linux-gnu`

The runtime gate covered the repository baseline itself, not a simplified translation.

## Verified runtime scope

- canonical MarketLedger schema creation: **PASS**
- deterministic seed load: **PASS**
- integrity checks: **PASS**
- regression scripts `001` through `008`: **PASS**
- canonical chapter scripts `ch01.sql` through `ch24.sql`: **PASS**
- Chapter 20 `EXPLAIN`: **PASS**
- Chapter 20 `EXPLAIN ANALYZE`: **PASS**
- Chapter 21 prepared/parameterised query example: **PASS**
- Chapters 16–19 and 23 disposable write/transaction labs: **PASS**
- reset → rebuild → seed → integrity → full regression rerun: **PASS**
- post-test row-count/cleanup check: **PASS**

The destructive/write-oriented checks were executed only after explicit approval and only against the dedicated verification database. Temporary teaching tables were isolated to their sessions/transactions. Regression 007 inserted and deleted its temporary category row. Regression 008 confirmed rollback semantics. Final checks found no leftover verification rows.

## Final deterministic row counts

- branches: 6
- employees: 8
- customers: 10
- suppliers: 4
- categories: 4
- products: 12
- orders: 12
- order_items: 22
- payments: 13
- inventory_movements: 13
- deliveries: 8
- returns: 2

## Release interpretation

The repository's **canonical runnable SQL gate is now PASS on PostgreSQL 18.6**.

This does not imply that every SQL-looking fragment in the prose is an executable listing. The publication gate applies to the curated canonical chapter scripts plus the schema, seed, integrity checks and regression suite. Deliberately incorrect examples, explanatory fragments and pseudo-code remain classified separately in the manuscript SQL inventory.

See `postgresql18-verification-2026-09-09.md` for the verification record and `verification-matrix.md` for gate status.
