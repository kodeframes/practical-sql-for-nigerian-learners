# Book Edition Mapping

- Book: *Practical SQL for Nigerian Learners*
- Subtitle: *Learn Modern SQL with PostgreSQL, Real Business Data, Database Design, Data Analysis, and Job-Ready Portfolio Projects*
- Author: Oladipo Olatunji
- Publisher: KodeFrames BuiltApps Enterprises
- Companion repository: https://github.com/kodeframes/practical-sql-for-nigerian-learners
- Publication mapping status: frozen for book/repository release alignment on 2026-09-09
- Frozen executable baseline commit: `838474a415502909c326af5f27b02ed83bee9f2d`
- Frozen reference branch: `release/book-v1.0.0-sql-baseline`
- Canonical DBMS: PostgreSQL 18.x
- Verified runtime: PostgreSQL 18.6
- GitHub Actions verification run: `34383303837`
- Live verification date: 2026-09-09
- Manuscript baseline: reconstructed v1.1
- Publication-aligned manuscript: v1.2
- Print target: 7 x 10 in, no-bleed technical interior
- Kindle target: reflowable eBook
- Canonical chapter scripts: `chapters/ch01.sql` through `chapters/ch24.sql`
- Regression suite: `tests/regression/001_seed_counts.sql` through `tests/regression/008_transaction_rollback.sql`
- Canonical runnable SQL status: PASS on PostgreSQL 18.6

## Reproducibility rule

The commit SHA above is the executable source of truth for the first publication-aligned edition. Page numbers may change during print composition, but the SQL baseline does not. Readers and reviewers who need the exact publication code should use the frozen commit or the frozen reference branch rather than assuming that a later `main` branch still represents the book edition.

## Rights boundary

Repository software is distributed under the MIT License. Publication prose and substantial editorial material remain subject to `CONTENT-LICENSE.md`. Synthetic dataset licensing remains governed by `DATA-LICENSE.md`; its current status must not be overstated in the book or repository metadata.
