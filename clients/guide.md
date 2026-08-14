# clients

One folder per account. Machine-written facts and human-written judgment live side by side in it, and neither is allowed to overwrite the other.

Enforced by `.claude/rules/client-data.md`. Worked example in `EXAMPLE-CLIENT/`.

## The shape

```
clients/
  acme-industrial/
    acme-industrial.md      # machine-owned one-pager, banner names its writer
    operating-state.md      # hand-written, the account's working memory
    q3-expansion-plan.md    # anything else the humans need, never synced
```

The folder and its one-pager share a name on purpose. It buys a machine-checkable invariant, every account folder contains its same-named file, so one missing file is a signal instead of noise. It also leaves the rest of the folder as free-form human space that no automation is entitled to write into.

That invariant is the cheapest drift detector you will build. When a batch of accounts turns out to have skipped a standard step, the affected accounts are usually exactly the ones missing the artifact the standard path always leaves behind. Audit for the missing artifact, not for the thing you think went wrong.

## The machine-owned half

`<slug>/<slug>.md` is written once by your sync from whatever system holds account records, and it opens with a banner naming that writer, the source record and the date its content last changed. Do not hand-edit it. Because the sync creates it and then leaves it alone, a hand edit is never corrected by the next run either: the file becomes a second version of the truth that nothing repairs, disagreeing silently with the CRM.

**The kit does not ship the sync.** It cannot, since it does not know your system of record. Until you write one, either delete the banner and keep the file as an ordinary human doc, or leave the folder with only human docs in it. A file that claims a writer which does not exist is worse than an unclaimed file: humans skip it because it looks generated, and tooling refuses it because it looks owned.

## The human-owned half

`operating-state.md` is the one that changes how sessions feel. It **replaces volatile session memory for anything that must survive a context clear**. The contract has three parts and all three are load-bearing:

1. **Read it first** at the start of any work on the account.
2. **Trust it.** Do not re-audit the account from scratch to reconstruct what it already says.
3. **Update it before finishing an operational change**, not afterwards. A doc updated when there is time describes the account as it was a month ago, and the agent then trusts a month-old picture.

Everything else in the folder is normal working material: plans, briefs, retros, drafts. No automation touches it.

## What breaks if you get it wrong

Skip the operating-state doc and the context window becomes the only place the account's state exists, which means it survives until the next clear and then the next session starts by asking questions the last one already answered. Hand-edit the synced one-pager and two systems now disagree with no way to tell which is right. Put credentials in the folder and you have distributed them to everyone who clones the repo, including whoever clones it after they leave.

## Naming

Lowercase slug, hyphens, no spaces, matching whatever you call the account in your CRM. `EXAMPLE-CLIENT/` is uppercase so it is obvious it is a template. Delete it or copy it, do not leave it as a live account.
