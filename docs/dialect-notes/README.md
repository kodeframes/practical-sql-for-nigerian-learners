# SQL dialect notes

PostgreSQL 18.x is the canonical executable platform for the book and repository.

Comparison notes are limited to:

- SQLite
- MySQL 8.4 LTS
- SQL Server 2025

Use a dialect note only when a difference materially affects understanding, portability or safe execution. The teaching order is:

1. relational concept;
2. SQL idea;
3. PostgreSQL implementation;
4. concise portability note when justified.

Do not imply that identical-looking SQL necessarily has identical semantics, data types, NULL behaviour, date/time behaviour, DDL syntax, identity/autoincrement behaviour or query-planning behaviour across engines.

The SQLite material in this repository is a semantic teaching aid, not the canonical runtime target and not evidence that PostgreSQL-specific SQL has been verified.
