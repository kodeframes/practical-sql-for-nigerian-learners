# PostgreSQL 18 Live Verification Record — 2026-09-09

**Book:** Practical SQL for Nigerian Learners  
**Author:** Oladipo Olatunji  
**Publisher:** KodeFrames BuiltApps Enterprises  
**Repository baseline:** development verification baseline 1.0  
**Execution provider:** Neon, dedicated isolated verification project  
**Database:** `marketledger`  
**Server:** `PostgreSQL 18.6 (c5250a2) on aarch64-unknown-linux-gnu`  
**Result:** **PASS**

No database password or connection string is stored in this repository.

## Gate results

| Gate | Result | Evidence summary |
|---|---|---|
| PostgreSQL major/minor runtime | PASS | live server reported PostgreSQL 18.6 |
| Schema build | PASS | all 13 canonical tables and 6 indexes created |
| Seed load | PASS | deterministic rows inserted and identity sequences advanced |
| Integrity suite | PASS | all violation queries returned zero rows; order count = 12 |
| Regression 001 — seed counts | PASS | every canonical table count matched |
| Regression 002 — order-value grain | PASS | 618,150.00 line total; 614,600.00 net order value |
| Regression 003 — JOIN multiplication | PASS | naive 638,750.00 vs correct 618,150.00 |
| Regression 004 — NULL/absence | PASS | expected NULL and NOT EXISTS cases confirmed |
| Regression 005 — status/delivery | PASS | completed, failed, successful-payment and delivered counts/totals matched |
| Regression 006 — branch capstone totals | PASS | all expected branch net values matched |
| Regression 007 — identity sequences | PASS | generated category identity value advanced beyond seeded IDs and temporary row was deleted |
| Regression 008 — rollback | PASS | forced subtransaction rollback left customer count unchanged |
| Canonical chapter scripts 01–24 | PASS | all curated chapter scripts executed successfully |
| Chapter 20 EXPLAIN | PASS | planner output returned successfully |
| Chapter 20 EXPLAIN ANALYZE | PASS | statement executed and returned runtime plan safely on SELECT |
| Chapter 21 parameterisation | PASS | PREPARE/EXECUTE/DEALLOCATE path succeeded |
| Disposable write labs | PASS | Chapters 16–19 and 23 executed against temporary tables/transactions |
| Reset/rebuild reproducibility | PASS | canonical tables dropped, recreated, reseeded, then integrity + regressions 001–008 passed again |
| Final cleanup/state | PASS | deterministic counts restored; zero temporary verification rows remained |

## Deterministic values confirmed on PostgreSQL 18.6

- completed-order line value before order-level discounts: **618,150.00**
- completed-order net value after order-level discounts: **614,600.00**
- deliberately naive successful-payment JOIN value: **638,750.00**
- successful payment amount: **613,800.00**
- customers with no orders: **1**
- products never ordered: **1**
- failed payment attempts: **1**
- delivered delivery records: **6**

Completed-order net values by branch:

| Branch | Net value |
|---|---:|
| ABJ-WUS | 330,000.00 |
| IBA-DUG | 121,700.00 |
| KAN-CEN | 62,200.00 |
| LOS-IKE | 43,000.00 |
| PHC-GRA | 57,700.00 |

The Enugu branch has no completed-order net value in the deterministic seed because its seeded order is cancelled.

## Safety note

The reset and write-oriented verification operations were approved explicitly for the dedicated test database. No production or unrelated database was used.

## Conclusion

The critical **actual PostgreSQL 18 execution/regression blocker is closed** for the repository's canonical runnable SQL baseline.
