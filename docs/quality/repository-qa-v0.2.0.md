# Companion Repository QA Report v0.2.0

**Book:** Practical SQL for Nigerian Learners  
**Author:** Oladipo Olatunji  
**Publisher:** KodeFrames BuiltApps Enterprises  
**Repository baseline:** v0.2.0 live-verification baseline  
**Engineering date:** 2026-09-09  
**Canonical DBMS:** PostgreSQL 18.x  
**Verified runtime:** PostgreSQL 18.6

## Executive status

**PASS for companion-repository engineering and canonical PostgreSQL runtime verification.**

The repository contains the canonical MarketLedger schema, deterministic seed dataset, CSV exports, 24 chapter scripts, extracted exercises/solutions, integrity checks, eight regression assertions, expected-result fixtures, Mermaid ER source, documentation, and repeatable PostgreSQL 18 verification entry points.

A live PostgreSQL 18.6 run was completed on a dedicated isolated Neon project. Schema build, seed load, integrity checks, all eight regression scripts, all 24 canonical chapter scripts, PostgreSQL-specific planner examples, parameterised-query examples, write/transaction labs, and a full reset/rebuild/rerun cycle passed.

## Repository inventory

- canonical chapter SQL files: 24
- exercise question files: 24
- exercise solution files: 24
- canonical MarketLedger tables: 13
- PostgreSQL integrity scripts: 1
- PostgreSQL regression scripts: 8
- PostgreSQL schema/seed/reset/setup scripts: 4
- MarketLedger CSV tables: 13
- selected expected-result CSV fixtures: 5
- reconstructed-manuscript SQL blocks inventoried: 296

## Static repository QA

**PASS**

`python scripts/static-qa.py` confirms the required chapter/exercise/table inventory, naming policy, absence of fabricated stored order totals, safe destructive-SQL conventions, identity-sequence handling, final newlines, and manuscript SQL inventory.

## Supplemental semantic smoke test

**PASS, non-canonical**

`python scripts/semantic-smoke.py` independently cross-checks the deterministic dataset in SQLite and confirms the same core arithmetic used by the PostgreSQL regression suite. This remains supplemental evidence only; the canonical runtime gate is PostgreSQL.

## PostgreSQL 18 live gate

**PASS**

Verified on `PostgreSQL 18.6 (c5250a2)` using a dedicated Neon database.

Completed successfully:

1. canonical schema creation;
2. canonical seed loading;
3. integrity checks;
4. regression 001 seed counts;
5. regression 002 order-value grain;
6. regression 003 JOIN multiplication;
7. regression 004 NULL/absence;
8. regression 005 status/delivery;
9. regression 006 branch capstone totals;
10. regression 007 identity sequence advancement and cleanup;
11. regression 008 rollback behaviour;
12. chapter scripts 01–24;
13. Chapter 20 `EXPLAIN` and `EXPLAIN ANALYZE`;
14. Chapter 21 prepared/parameterised query flow;
15. disposable write/transaction exercises;
16. reset → rebuild → reseed → integrity → regression rerun;
17. final deterministic-state cleanup check.

Detailed record: `docs/quality/postgresql18-verification-2026-09-09.md`.

## Deterministic claims protected by regression tests

- completed-order line value: 618,150.00;
- completed-order net value: 614,600.00;
- deliberately inflated payment-JOIN result: 638,750.00;
- successful-payment total: 613,800.00;
- expected NULL and absence cases;
- expected delivery/payment status counts;
- deterministic branch capstone totals;
- identity sequences remain usable after explicit seed IDs;
- rollback behaviour leaves no persisted test row.

## Licensing boundaries

- repository software/code: MIT License;
- synthetic datasets: intended CC BY 4.0, still subject to final human confirmation;
- publication prose/editorial content/diagrams/cover/branding: separate all-rights-reserved boundary.

The dataset licensing wording remains a human/legal confirmation item; it is not a database-runtime blocker.

## Remote GitHub status

A remote repository named `kodeframes/practical-sql-for-nigerian-learners` does not yet exist in the connected GitHub account. The available GitHub integration can populate an existing repository but does not expose repository creation. No unrelated repository has been modified.

The local repository is GitHub-ready. Once the empty remote exists, it can be populated and the prepared GitHub Actions workflow can provide repeatable public/private CI evidence on subsequent commits.

## Release interpretation

The previous critical blocker, **actual PostgreSQL 18 runtime execution**, is closed for the canonical repository baseline. Remaining publication tasks are editorial/legal/production tasks rather than database-execution blockers.
