# Changelog

## Unreleased

- Created canonical MarketLedger PostgreSQL schema and deterministic seed dataset.
- Added 24 chapter-aligned SQL practice scripts.
- Added integrity and regression tests for grain, joins, NULL handling, transactions, identity sequences, and capstone totals.
- Added PostgreSQL 18.6 Docker/CI verification workflow.
- Added expected-result fixtures, data dictionary, ER source, SQL inventory, and reproducibility scripts.
- Completed live PostgreSQL 18.6 verification on 2026-09-09.
- Verified schema build, seed load, integrity checks, regressions 001–008, and all 24 canonical chapter scripts.
- Completed a destructive reset/rebuild/reseed cycle on the isolated verification database and reran integrity/regression checks successfully.
- Closed the critical canonical PostgreSQL runtime verification gate.
