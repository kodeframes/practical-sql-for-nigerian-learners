# Manuscript SQL inventory

The reconstructed manuscript contains **296** fenced `sql` blocks across the 24 chapters. `manuscript-sql-inventory.csv` records each block's chapter, source line, section, first line, pedagogical role and canonical runtime companion.

The classification is an editorial inventory, not an assertion that every prose block should execute. The release-time executable gate uses the curated `chapters/chXX.sql` files plus integrity/regression tests.

Role counts:

- `deliberately-incorrect-or-warning`: 3
- `setup-or-environment`: 3
- `supplementary-mini-domain`: 14
- `syntax-fragment`: 8
- `transactional-teaching-lab`: 10
- `worked-or-practice-sql`: 258

Every chapter with SQL teaching has a canonical runtime companion. Chapters that are primarily conceptual may intentionally have a minimal companion script.
