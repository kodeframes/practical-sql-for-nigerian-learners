# PostgreSQL 18 setup and verification

## Supported reference platform

The book targets **PostgreSQL 18.x**. At the time this repository baseline was engineered (9 September 2026), PostgreSQL **18.6** was the current PostgreSQL 18 maintenance release. PostgreSQL 18.6 was released on 13 August 2026; PostgreSQL 18.5 was not released because a regression was discovered before shipment.

Official release notes:

- https://www.postgresql.org/docs/18/release-18-6.html

The automated container paths in this repository pin `postgres:18.6` to make verification reproducible. The `scripts/verify.sh` path accepts any PostgreSQL 18.x server after checking the actual server major version.

## Windows learners

Use the current official PostgreSQL Windows guidance rather than copying an old installer screenshot from the book or repository:

- https://www.postgresql.org/download/windows/

Installer user interfaces, download sizes and optional components can change. Verify current details before relying on them.

## Debian/Ubuntu-style systems

The PostgreSQL project maintains an Apt repository that provides supported PostgreSQL versions. The official Debian page documents Debian 13 (`trixie`) support and shows the version-specific package naming pattern, including `postgresql-18`:

- https://www.postgresql.org/download/linux/debian/

Do not substitute an unverified package command for the instructions published for your operating-system release.

## Verify the server you are actually using

In `psql`:

```sql
SHOW server_version;
SHOW server_version_num;
```

The repository verifier additionally checks that the major version resolves to `18` before rebuilding MarketLedger.

## Create a disposable learning database

Examples in this repository may create temporary objects and the reset script drops the canonical MarketLedger tables. Use a disposable local/CI database.

For a newly created `marketledger` database:

```bash
psql -X -v ON_ERROR_STOP=1 -d marketledger -f database/postgresql/schema/001_marketledger_schema.sql
psql -X -v ON_ERROR_STOP=1 -d marketledger -f database/postgresql/seed/001_marketledger_seed.sql
```

To rebuild an existing learning database:

```bash
psql -X -v ON_ERROR_STOP=1 -d marketledger -f database/postgresql/reset/001_reset.sql
psql -X -v ON_ERROR_STOP=1 -d marketledger -f database/postgresql/schema/001_marketledger_schema.sql
psql -X -v ON_ERROR_STOP=1 -d marketledger -f database/postgresql/seed/001_marketledger_seed.sql
```

## Run the complete gate

Existing PostgreSQL 18.x server:

```bash
./scripts/verify.sh
```

Isolated Docker verification:

```bash
./scripts/verify-with-docker.sh
```

Windows PowerShell with Docker:

```powershell
./scripts/verify-with-docker.ps1
```

## What a successful run proves

A successful verifier run proves, for the checked repository revision, that:

1. the server is PostgreSQL 18.x;
2. the canonical schema builds from a clean state;
3. the deterministic seed loads;
4. integrity and regression assertions pass;
5. all 24 canonical chapter scripts execute without PostgreSQL errors;
6. the final dataset invariant still holds after chapter demonstrations.

It does **not** prove that every intentionally incorrect or partial SQL fragment printed in the prose should execute. Those blocks have different pedagogical roles and are inventoried separately.
