$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$Name = 'practical-sql-pg18-verify'
$Port = if ($env:PG_VERIFY_PORT) { $env:PG_VERIFY_PORT } else { '55432' }

docker rm -f $Name 2>$null | Out-Null
try {
    docker run -d --name $Name `
      -e POSTGRES_DB=marketledger `
      -e POSTGRES_USER=postgres `
      -e POSTGRES_PASSWORD=postgres `
      -p "${Port}:5432" postgres:18.6 | Out-Null

    $ready = $false
    foreach ($i in 1..60) {
        docker exec $Name pg_isready -U postgres -d marketledger *> $null
        if ($LASTEXITCODE -eq 0) { $ready = $true; break }
        Start-Sleep -Seconds 1
    }
    if (-not $ready) { throw 'PostgreSQL container did not become ready.' }

    $version = docker exec $Name psql -X -U postgres -d marketledger -Atqc 'SHOW server_version;'
    Write-Host "PostgreSQL server_version=$version"
    if (-not $version.StartsWith('18.')) { throw "Expected PostgreSQL 18.x, found $version" }

    $files = @(
      "$Root/database/postgresql/reset/001_reset.sql",
      "$Root/database/postgresql/schema/001_marketledger_schema.sql",
      "$Root/database/postgresql/seed/001_marketledger_seed.sql",
      "$Root/tests/integrity/001_integrity_checks.sql"
    )
    $files += Get-ChildItem "$Root/tests/regression/*.sql" | Sort-Object Name | ForEach-Object FullName
    $files += Get-ChildItem "$Root/chapters/ch*.sql" | Sort-Object Name | ForEach-Object FullName

    foreach ($file in $files) {
        Write-Host "==> $file"
        Get-Content -Raw $file | docker exec -i $Name psql -X -U postgres -d marketledger -v ON_ERROR_STOP=1
        if ($LASTEXITCODE -ne 0) { throw "Failed: $file" }
    }
    Write-Host "PASS: PostgreSQL $version verification complete."
}
finally {
    docker rm -f $Name 2>$null | Out-Null
}
