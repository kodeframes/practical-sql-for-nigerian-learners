# Public Repository Cutover — Book Release

This repository remains **private until the book release cutover**. The executable book baseline is already frozen and verified; changing repository visibility is a distribution action, not a technical validation step.

## Release-day preconditions

All of the following must be true before changing visibility:

- the Kindle EPUB has passed final Kindle Previewer / KDP Online Previewer review;
- title, subtitle, author and publisher metadata match the book files exactly;
- the consolidated release QA has no critical blocker;
- `main` is green under `.github/workflows/postgresql18-verify.yml`;
- the frozen executable baseline remains `838474a415502909c326af5f27b02ed83bee9f2d`;
- `DATA-LICENSE.md` states the final CC BY 4.0 dataset licence;
- `CONTENT-LICENSE.md` and `LICENSE` preserve the content/software rights boundary;
- no secrets, private files, API keys, credentials, personal records or unpublished manuscript source are present in repository history intended for public release.

## Cutover sequence

1. Record the final `main` commit SHA and successful PostgreSQL 18 verification run.
2. Change repository visibility from **Private** to **Public** in GitHub repository settings.
3. Confirm the default branch is `main`.
4. Create the public `v1.0.0` release/tag from the final release commit. In the release notes, identify `838474a415502909c326af5f27b02ed83bee9f2d` as the frozen executable SQL baseline for the first book edition.
5. From a signed-out/private browser session, verify that the repository home page, `README.md`, `BOOK-EDITION.md`, `DATA-LICENSE.md`, schema, seed, chapter scripts, exercises and verification evidence are readable.
6. Verify an unauthenticated clone and run the documented Docker verification path.
7. Verify every repository URL printed in the Kindle and print editions resolves publicly.
8. Only then treat the companion repository as publicly released.

## Rollback rule

If a secret, private artefact, licensing conflict or critical technical defect is discovered during cutover, stop the release. Do not rely on making the repository private again as a substitute for secret rotation or history remediation.
