# company-wiki

Distilled knowledge and playbooks. This is the root your agents answer from, so everything in it has to be something a human decided was true.

Enforced by `.claude/rules/wiki-knowledge.md`, which loads whenever an agent touches this tree.

## What belongs here

| Folder | Holds | Split by |
|---|---|---|
| `company/` | Who you are, the team, the accounts overview, the stack, recurring processes | Rate of change |
| `marketing/` | Voice, design system, positioning, messaging | Owner |
| `services/<line>/` | One folder per line of business, one playbook or SOP per file | Service line |

Add a folder when a new line of business appears, not when a new topic does. The test of a good split is that nobody has to discuss where a new SOP goes.

## What does not belong here

- **Raw material.** Transcripts, exports, articles and dumps live in `raw/`. The page you write from them belongs here; the source does not.
- **Account state.** Anything true of one account only belongs in `clients/<slug>/`. A client name inside a playbook is a sign the playbook is really an account doc.
- **Volatile status.** Campaign counts, current headcount, this month's pipeline. Put them where something owns them, or date them, or leave them out.
- **Credentials.** Keys enter the store as variable references and nothing else.

## What breaks if you get it wrong

A transcript filed here becomes a source the agent quotes as settled knowledge, and nobody reviewed it. A status line inside a durable page goes stale faster than the page around it, and once a reader has caught one stale section they discount the whole file, which costs you the pages that were fine. A page sitting at the wiki root means the taxonomy has a hole nobody named, so the next page lands at the root too.

That last one is a checked invariant, not a convention: `node scripts/refresh-counts.mjs --check` fails on any file at this root. This guide is the single exemption and it is listed by exact path in the script, so the exemption is visible rather than assumed.

The counts refresher in `scripts/` will rewrite the numbers it owns and report anything it finds that is not in `INDEX.md`. It does not guess a category, so a new page with no catalog entry fails the check rather than getting filed wrong quietly.

## The authoring bar

Write a page when the same question has been answered twice from memory, when a play has run enough times to have a shape, or when a decision will still hold next quarter. Then:

1. First two lines say what the page is for and who owns it.
2. Name the source it was distilled from, so a reader can go back to `raw/`.
3. Numbers get a verification date or they get cut.
4. One topic per page. If the page needs two titles it is two pages.
5. Add the row to `INDEX.md` yourself.

## What the kit does not ship

There is no scheduled job that keeps these pages current, and no retrieval index behind them. Freshness here is a human habit backed by the review gate. If you add a retrieval index later, feed its partitions from this root boundary rather than inventing a second permission model on top of the index.
