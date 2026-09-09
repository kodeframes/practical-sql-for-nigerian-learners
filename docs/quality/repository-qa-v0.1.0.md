# Companion Repository QA Report v0.1.0

**Book:** Practical SQL for Nigerian Learners  
**Author:** Oladipo Olatunji  
**Publisher:** KodeFrames BuiltApps Enterprises  
**Repository baseline:** v0.1.0  
**Engineering date:** 2026-09-09  
**Canonical DBMS:** PostgreSQL 18.x  
**Pinned container/CI target:** PostgreSQL 18.6  

## Executive status

The companion repository is engineered and locally QA-checked. It contains the canonical MarketLedger schema, deterministic seed dataset, CSV exports, 24 chapter scripts, extracted exercises/solutions, integrity checks, regression assertions, expected-result fixtures, a Mermaid ER source, documentation, and repeatable PostgreSQL 18 verification entry points.

**The actual PostgreSQL 18 runtime gate is not yet marked PASS.** This execution environment has no PostgreSQL server/client or Docker runtime and cannot currently fetch packages because external DNS/network access is unavailable. A live PostgreSQL 18 run must therefore occur through a connected PostgreSQL service, a local machine with PostgreSQL/Docker, or the prepared GitHub Actions workflow after the project repository exists remotely.

## Repository inventory

- total files before local Git metadata: 138 (including this report and checksum manifest)
- canonical chapter SQL files: 24
- PostgreSQL integrity/regression SQL files: 9
- PostgreSQL schema/seed/reset/setup SQL files: 4
- MarketLedger CSV tables: 13
- selected expected-result CSV fixtures: 5
- exercise question files: 24
- exercise solution files: 24
- reconstructed-manuscript SQL blocks inventoried: 296

## Static repository QA

**PASS**

`python scripts/static-qa.py` checks, among other things:

- exactly 24 canonical chapter scripts exist;
- 24 question and 24 solution files exist;
- all 13 MarketLedger tables are represented in CSV and schema form;
- the canonical schema contains the approved stable table names;
- executable SQL does not use a fabricated stored order-total field;
- canonical chapter scripts do not normalise unrestricted `DELETE FROM table;`;
- explicit identity seed IDs are followed by sequence advancement;
- SQL files have final newlines;
- manuscript SQL inventory exists.

Bash syntax checks also pass for `scripts/verify.sh` and `scripts/verify-with-docker.sh`. Both YAML files parse successfully.

## Deterministic semantic smoke test

**PASS, non-canonical**

`python scripts/semantic-smoke.py` loads the CSV teaching dataset into in-memory SQLite and independently cross-checks core relational arithmetic. It confirms:

- completed-order line total before order-level discounts: 618,150.00;
- completed-order net value: 614,600.00;
- deliberately inflated successful-payment JOIN result: 638,750.00;
- one stored customer with no orders;
- one failed payment attempt;
- six delivered records;
- successful-payment amount total: 613,800.00.

This is useful drift detection but **is not PostgreSQL verification**.

## PostgreSQL 18 verification harness

Prepared execution paths:

1. `scripts/verify.sh` — existing PostgreSQL 18.x server;
2. `scripts/verify-with-docker.sh` — isolated `postgres:18.6` container;
3. `scripts/verify-with-docker.ps1` — Windows PowerShell + Docker;
4. `.github/workflows/postgresql18-verify.yml` — GitHub Actions with `postgres:18.6`.

The GitHub workflow captures a verification evidence artifact containing the repository commit, PostgreSQL server version and final success record.

## Regression suite

The PostgreSQL suite protects these claims:

- `001_seed_counts.sql` — deterministic table counts;
- `002_order_value_grain.sql` — line grain and order-level discount placement;
- `003_join_multiplication.sql` — intentional demonstration of payment JOIN multiplication;
- `004_null_and_absence.sql` — NULL and `NOT EXISTS` cases;
- `005_status_and_delivery.sql` — completed orders, failed payments, successful payments, delivered records;
- `006_branch_capstone_totals.sql` — deterministic branch net values;
- `007_identity_sequences.sql` — identity advancement after explicit seed IDs;
- `008_transaction_rollback.sql` — subtransaction/exception rollback behaviour.

## Documentation and reproducibility

**PASS at repository-engineering level**

Added:

- root quick-start `README.md`;
- `docs/setup/postgresql18.md`;
- MarketLedger data dictionary;
- Mermaid ER source;
- SQL dialect policy;
- verification matrix;
- PostgreSQL runtime-status record;
- verification record template;
- manuscript SQL block inventory;
- SHA-256 manifest.

## Licensing boundaries

- repository software/code: MIT License;
- publication content: separate all-rights-reserved boundary;
- synthetic dataset: public licence remains pending final human confirmation, with CC BY 4.0 still the intended direction.

This remains a provisional legal gate until the dataset licence is explicitly confirmed.

## Remote GitHub status

The connected GitHub account does not currently contain `practical-sql-for-nigerian-learners`, and the available GitHub integration does not expose repository creation. No unrelated existing repository was modified.

The local repository package is therefore GitHub-ready but not yet published remotely. Once an empty remote repository exists, this baseline can be pushed and the prepared PostgreSQL 18.6 workflow can perform the actual runtime gate.

## Critical release gate

**OPEN: actual PostgreSQL 18 execution.**

Do not label the canonical SQL “100% PostgreSQL verified” until a real PostgreSQL 18 run records PASS for schema build, seed load, integrity checks, all eight regression scripts and all 24 canonical chapter scripts.
