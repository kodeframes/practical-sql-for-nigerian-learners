#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NAME="practical-sql-pg18-verify"
PORT="${PG_VERIFY_PORT:-55432}"

cleanup() {
  docker rm -f "$NAME" >/dev/null 2>&1 || true
}
trap cleanup EXIT
cleanup

docker run -d --name "$NAME" \
  -e POSTGRES_DB=marketledger \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -p "${PORT}:5432" \
  postgres:18.6 >/dev/null

for _ in $(seq 1 60); do
  if docker exec "$NAME" pg_isready -U postgres -d marketledger >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

docker exec "$NAME" pg_isready -U postgres -d marketledger >/dev/null

run_file() {
  local file="$1"
  echo "==> $(realpath --relative-to="$ROOT" "$file")"
  docker exec -i "$NAME" psql -X -U postgres -d marketledger -v ON_ERROR_STOP=1 < "$file"
}

version="$(docker exec "$NAME" psql -X -U postgres -d marketledger -Atqc 'SHOW server_version;')"
echo "PostgreSQL server_version=${version}"
case "$version" in
  18.*) ;;
  *) echo "ERROR: expected PostgreSQL 18.x" >&2; exit 1 ;;
esac

run_file "$ROOT/database/postgresql/reset/001_reset.sql"
run_file "$ROOT/database/postgresql/schema/001_marketledger_schema.sql"
run_file "$ROOT/database/postgresql/seed/001_marketledger_seed.sql"
run_file "$ROOT/tests/integrity/001_integrity_checks.sql"
for f in "$ROOT"/tests/regression/*.sql; do run_file "$f"; done
for f in "$ROOT"/chapters/ch*.sql; do run_file "$f" >/dev/null; done

echo "PASS: PostgreSQL ${version} verification complete."
