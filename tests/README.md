# Tests

`integrity/` contains inspection queries for structural/data-integrity expectations. `regression/` contains PostgreSQL assertions that fail with `RAISE EXCEPTION` if a protected teaching result changes. `expected-results/` stores human-inspectable fixtures for selected outputs.

Run the complete PostgreSQL 18 gate with one of the scripts in `scripts/`. Run `python scripts/semantic-smoke.py` for a fast cross-engine dataset arithmetic check when PostgreSQL is unavailable; that smoke test does not replace the PostgreSQL gate.
