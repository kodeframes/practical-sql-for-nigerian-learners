#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
: "${PGHOST:=127.0.0.1}"
: "${PGPORT:=5432}"
: "${PGDATABASE:=marketledger}"
: "${PGUSER:=postgres}"
: "${PGPASSWORD:=postgres}"
export PGHOST PGPORT PGDATABASE PGUSER PGPASSWORD

PSQL=(psql -X -v ON_ERROR_STOP=1)

server_version="$(${PSQL[@]} -Atqc 'SHOW server_version;')"
server_major="$(${PSQL[@]} -Atqc "SELECT current_setting('server_version_num')::int / 10000;")"
echo "PostgreSQL server_version=${server_version}"
if [[ "$server_major" != "18" ]]; then
  echo "ERROR: PostgreSQL 18.x required; found ${server_version}" >&2
  exit 1
fi

"${PSQL[@]}" -f "$ROOT/database/postgresql/reset/001_reset.sql"
"${PSQL[@]}" -f "$ROOT/database/postgresql/schema/001_marketledger_schema.sql"
"${PSQL[@]}" -f "$ROOT/database/postgresql/seed/001_marketledger_seed.sql"

"${PSQL[@]}" -f "$ROOT/tests/integrity/001_integrity_checks.sql"
for f in "$ROOT"/tests/regression/*.sql; do
  echo "==> regression: $(basename "$f")"
  "${PSQL[@]}" -f "$f"
done
for f in "$ROOT"/chapters/ch*.sql; do
  echo "==> chapter: $(basename "$f")"
  "${PSQL[@]}" -f "$f" >/dev/null
done

echo "PASS: schema, seed, integrity, regression, and 24 canonical chapter scripts executed on PostgreSQL ${server_version}."
