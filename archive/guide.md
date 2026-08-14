# archive

Superseded material that is still worth keeping. Old playbooks, finished projects, churned accounts, skills you retired.

Archive is a content root rather than a habit for one reason: a delete is invisible and a move is auditable. Agents do not load this tree unless you point them at it.

## Move, never delete

Two checks before anything comes in here, and both of them have been paid for.

**Check the reference graph, not the usage stats.** The instinct on a cleanup is to classify items as unused by observation: never invoked, no recent edits, looks generated. That is backwards for a skill library, because a composition skill calls other skills as its execution layer, so the dependency looks idle while the dependent is the thing people actually run. One cleanup removed a batch of skills as unused, one of which was the execution layer a live skill was a thin wrapper over, and it stayed broken for over a month.

**Check what is nested inside the folder you are about to move.** The same reorganization archived a scaffold folder with a first-class skill buried inside it, left stale path references behind, and pointed a cross-store link at a target that had moved. Three incidents, one pass.

So: grep for every reference by name **and** by path before the move. Names and paths break independently, and a rename fans out further than anyone expects. The catalog entry, a script path, prose that mentions the old name, a stale build that vendored the old copy, and any link from another store all break separately.

## After the move

1. Update `INDEX.md` in the same change. The catalog is the only list, so a move that skips it creates an orphan the freshness check will flag.
2. Leave a one-line pointer where the thing used to be if anything still refers to it.
3. Say in the commit why it was archived. Six months later that sentence is the only thing that distinguishes retired from broken.

## What belongs here and what does not

Retired material belongs here. Secrets never do, because archiving is not deleting and everything here still ships to everyone who clones the repo. Anything you might need next quarter belongs in the tree it came from, since content nobody loads is content nobody notices going stale.

## Restoring

Move it back and update `INDEX.md`. Version history is the safety net for anything you archived and then wanted verbatim, which is the argument for archiving in a commit of its own rather than inside a large reorganization.
