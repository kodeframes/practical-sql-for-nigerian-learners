# Practical SQL for Nigerian Learners — Companion Repository

This repository is the reproducible technical companion for **Practical SQL for Nigerian Learners** by **Oladipo Olatunji**, published under **KodeFrames BuiltApps Enterprises**.

The book teaches SQL from zero prerequisite to professional intermediate level using PostgreSQL 18.x and a fictional Nigerian multi-branch trading and distribution dataset called **MarketLedger**.

## Verification status

**PASS on PostgreSQL 18.6.** The canonical schema, deterministic seed data, integrity suite, regression scripts 001–008, and all 24 canonical chapter scripts have been executed successfully against a live PostgreSQL 18.6 instance. A full reset → rebuild → reseed → regression rerun also passed.

See [`docs/quality/postgresql18-verification-2026-09-09.md`](docs/quality/postgresql18-verification-2026-09-09.md) for the live verification record and [`docs/quality/verification-matrix.md`](docs/quality/verification-matrix.md) for gate definitions.

The Docker and GitHub Actions paths remain pinned to PostgreSQL 18.6 so future changes can reproduce the same gate.

## Quick start

### Option A — Docker (Linux/macOS/Git Bash)

Requirements: Docker with permission to run containers.

```bash
./scripts/verify-with-docker.sh
```

The script starts an isolated `postgres:18.6` container, verifies that the server is PostgreSQL 18.x, rebuilds MarketLedger from scratch, runs the test suite and all 24 canonical chapter scripts, then removes the container.

### Option B — Docker on Windows PowerShell

```powershell
./scripts/verify-with-docker.ps1
```

### Option C — an existing PostgreSQL 18.x server

Set the standard PostgreSQL connection variables, then run the verifier:

```bash
export PGHOST=127.0.0.1
export PGPORT=5432
export PGDATABASE=marketledger
export PGUSER=postgres
export PGPASSWORD='your-local-development-password'
./scripts/verify.sh
```

The verifier checks the server major version before changing the database. Use a disposable learning database, not a production database.

### Manual setup with `psql`

From the repository root:

```bash
psql -X -v ON_ERROR_STOP=1 -d marketledger -f database/postgresql/reset/001_reset.sql
psql -X -v ON_ERROR_STOP=1 -d marketledger -f database/postgresql/schema/001_marketledger_schema.sql
psql -X -v ON_ERROR_STOP=1 -d marketledger -f database/postgresql/seed/001_marketledger_seed.sql
```

Or, from inside `database/postgresql/`, use the convenience script:

```bash
psql -X -v ON_ERROR_STOP=1 -d marketledger -f setup.sql
```

## Repository map

```text
practical-sql-for-nigerian-learners/
├── database/
│   ├── postgresql/
│   │   ├── schema/
│   │   ├── seed/
│   │   └── reset/
│   ├── sqlite/
│   └── dialect-samples/
├── datasets/
│   ├── marketledger/
│   └── supplementary/
├── chapters/
├── exercises/
│   ├── questions/
│   └── solutions/
├── tests/
│   ├── expected-results/
│   ├── integrity/
│   └── regression/
├── docs/
│   ├── setup/
│   ├── data-dictionary/
│   ├── diagrams/
│   ├── dialect-notes/
│   └── quality/
├── scripts/
├── .github/workflows/
├── BOOK-EDITION.md
├── CHANGELOG.md
├── CONTENT-LICENSE.md
├── DATA-LICENSE.md
└── LICENSE
```

## Canonical database

The canonical teaching database is MarketLedger. Its stable tables are:

- `branches`
- `employees`
- `customers`
- `suppliers`
- `categories`
- `products`
- `supplier_products`
- `orders`
- `order_items`
- `payments`
- `inventory_movements`
- `deliveries`
- `returns`

There is intentionally **no stored order-total column** in `orders`. Historical sale value is calculated from `order_items.quantity`, the transaction-time `order_items.unit_price`, line discounts, and the order-level discount at the correct grain.

## Canonical chapter scripts

`chapters/ch01.sql` through `chapters/ch24.sql` are the canonical runnable companions to the book. They are intentionally curated: not every SQL-looking fragment in the prose is an executable example. The manuscript also contains deliberately incorrect snippets, fragments used to explain syntax, setup commands, and temporary teaching examples.

The inventory in [`docs/quality/manuscript-sql-inventory.csv`](docs/quality/manuscript-sql-inventory.csv) records the SQL blocks in the reconstructed manuscript and their role. The release gate is based on the curated chapter scripts plus the regression suite.

## Tests

The test suite protects the teaching claims most likely to be damaged by careless SQL changes:

- deterministic row counts;
- correct line/order grain for completed order value;
- deliberate demonstration of JOIN multiplication;
- NULL and `NOT EXISTS` cases;
- payment and delivery status totals;
- branch capstone totals;
- identity sequence advancement after explicit seed IDs;
- transaction rollback behaviour.

Expected-result CSV files under `tests/expected-results/` provide inspectable fixtures for selected analyses.

## Synthetic data

Every identity and transaction in MarketLedger is fictional or synthetic. Email addresses use reserved `.invalid` domains. The CSV files in `datasets/marketledger/` are exports of the deterministic teaching dataset.

## SQL portability

PostgreSQL 18.x is the executable reference platform. SQLite, MySQL 8.4 LTS, and SQL Server 2025 are used only for selected comparison notes where a difference matters. See [`docs/dialect-notes/README.md`](docs/dialect-notes/README.md).

## Licensing boundaries

Different repository materials have different rights boundaries:

- **software and repository code:** MIT License — see [`LICENSE`](LICENSE);
- **synthetic dataset:** Creative Commons Attribution 4.0 International (CC BY 4.0) — see [`DATA-LICENSE.md`](DATA-LICENSE.md);
- **book prose, substantial editorial content, diagrams, cover material and branding:** not granted by the MIT software licence — see [`CONTENT-LICENSE.md`](CONTENT-LICENSE.md).

Do not infer rights for one category from a licence that applies to another.

## Book/repository edition alignment

The first publication-aligned executable baseline is frozen at commit `838474a415502909c326af5f27b02ed83bee9f2d`. The corresponding reference branch is `release/book-v1.0.0-sql-baseline`. See [`BOOK-EDITION.md`](BOOK-EDITION.md) for the book/subtitle mapping, PostgreSQL 18.6 verification record, and publication targets.

## Quality policy

The project does not treat AI-generated output as authoritative. SQL is accepted only after review and, for canonical runnable material, PostgreSQL execution. Current gate status is documented in `docs/quality/` and in the reconstruction QA report distributed with the publication working files.
