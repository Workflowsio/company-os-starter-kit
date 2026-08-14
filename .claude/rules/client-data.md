---
paths:
  - "clients/**"
---

# Client data

Every account folder is `clients/<slug>/`, and it always contains `<slug>.md`. That one file is machine-owned. Everything else in the folder is human-owned.

## The machine-owned one-pager

`clients/<slug>/<slug>.md` is written by the sync from your account system of record, and it opens with a banner naming that writer, its source record and the date its content last changed. Never hand-edit it. The sync creates it once and does not overwrite it afterwards, so a hand edit is never corrected either: the file quietly becomes a second version of the truth that nothing repairs.

Fix the record in the source system instead. If your team has not built the sync yet, delete the banner and treat the file as an ordinary human doc, because a file claiming a writer that does not exist gets skipped by humans and refused by tooling.

## The human-owned docs beside it

Everything else in the folder is yours and no automation writes to it. The operating-state doc is the important one. It replaces volatile session memory for anything that must survive a context clear: read it first, trust it rather than re-auditing the account, and update it before finishing an operational change rather than after. A doc updated when there is time describes the account as it was a month ago.

No credentials here, per-account keys included. Keys live in the store only as variable references.

## Precedence

Inside `clients/**` this file overrides `repo-structure.md` on what a file contains and who writes it. `repo-structure.md` still owns the layout: no new root, and every account folder keeps its same-named file, because a single missing one is the cheapest drift signal in the store.
