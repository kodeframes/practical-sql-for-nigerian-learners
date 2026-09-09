# Verification matrix

This matrix separates static checks, cross-engine semantic checks and the release-significant PostgreSQL runtime gate.

| Gate | Evidence | Status | Release significance |
|---|---|---|---|
| Repository structure | expected directories and metadata files | PASS | required |
| 24 canonical chapter scripts | `chapters/ch01.sql` … `ch24.sql` | PASS | required |
| 24 exercise question/solution pairs | `exercises/` | PASS | required |
| Canonical schema table set | `database/postgresql/schema/001_marketledger_schema.sql` | PASS | required |
| Deterministic seed counts | live PostgreSQL + fixtures | PASS | required |
| Expected result fixtures | `tests/expected-results/` | PASS | required |
| NULL/absence semantics | regression 004 | PASS on PostgreSQL 18.6 | required |
| Order-value grain | regression 002 | PASS on PostgreSQL 18.6 | critical |
| JOIN multiplication demonstration | regression 003 | PASS on PostgreSQL 18.6 | critical |
| Branch capstone totals | regression 006 | PASS on PostgreSQL 18.6 | critical |
| Identity sequences | regression 007 | PASS on PostgreSQL 18.6 | required |
| Transaction rollback/subtransaction | regression 008 | PASS on PostgreSQL 18.6 | required |
| PostgreSQL schema execution | live Neon PostgreSQL 18.6 | **PASS** | **critical gate closed** |
| PostgreSQL seed execution | live Neon PostgreSQL 18.6 | **PASS** | **critical gate closed** |
| PostgreSQL regression suite 001–008 | live Neon PostgreSQL 18.6 | **PASS** | **critical gate closed** |
| 24 chapter scripts on PostgreSQL 18 | live Neon PostgreSQL 18.6 | **PASS** | **critical gate closed** |
| Reset/rebuild reproducibility | live drop/recreate/reseed/rerun | **PASS** | required |
| Static repository QA | `python scripts/static-qa.py` | PASS | required |
| SQLite semantic cross-check | `python scripts/semantic-smoke.py` | PASS, non-canonical | supplemental |

## Deterministic expected values

The verified teaching seed produces:

- 6 branches
- 8 employees
- 10 customers
- 4 suppliers
- 4 categories
- 12 products
- 12 orders
- 22 order items
- 13 payments
- 13 inventory movements
- 8 deliveries
- 2 returns
- completed-order line value before order-level discounts: **618,150.00**
- completed-order net value after order-level discounts: **614,600.00**
- deliberately naive successful-payment JOIN value: **638,750.00**
- customers with no orders: **1**
- failed payment attempts: **1**
- delivered delivery records: **6**
- successful payment amount: **613,800.00**

Branch completed-order net values:

| Branch | Net value |
|---|---:|
| ABJ-WUS | 330,000.00 |
| IBA-DUG | 121,700.00 |
| KAN-CEN | 62,200.00 |
| LOS-IKE | 43,000.00 |
| PHC-GRA | 57,700.00 |

The Enugu branch has no completed-order value in this seed because its seeded order is cancelled.

## Runtime evidence

See [`postgresql18-verification-2026-09-09.md`](postgresql18-verification-2026-09-09.md).
