# raw

Everything unprocessed lands here first. Call recordings, exports, decks, saved articles, half-formed dumps.

Enforced by `.claude/rules/raw-input.md`, which loads whenever an agent touches this tree.

## Buckets are typed by shape, not by subject

| Bucket | What goes in it |
|---|---|
| `transcripts/` | Recordings and call notes, one file per conversation |
| `data-exports/` | Machine output: CSV, JSON, report dumps |
| `documents/` | Files a person handed you: decks, PDFs, contracts, briefs |
| `external-sources/` | Material from outside the company: articles, posts, competitor pages |
| `misc/` | The landing zone. Anything that does not fit |

Each bucket has a README stating its test. Shape is decidable in a second and subject is not, which is the whole reason for the split. A bucket named after a client or a campaign forces a judgment call on every single drop, and anything needing a judgment call at drop time is what ends up unfiled on someone's desktop.

One bucket will end up holding almost everything, and it is usually transcripts. The near-empty siblings are not waste. They exist so the concept of typed buckets stays visible, because the moment transcripts are the only bucket anyone sees, the next person files an article in it and the shape is gone for good.

## The landing zone

`misc/` is the guaranteed destination. It is allowed to be messy, it is triaged on a cadence rather than at drop time, and it is what makes the no-new-top-level-folders rule survivable. Without it that rule gets broken the first busy week, and after that the top level grows forever.

## Processing

Material flows one way: `raw/` into `company-wiki/` through a distillation step a human owns. Nothing here is a citable source on its own.

Ask for a pass over a bucket like this:

```
Read everything in raw/transcripts/ added this week.
Tell me which items are worth a wiki page, which are one-line additions
to a page that already exists, and which are neither.
Do not write anything yet.
```

Then approve the list and let the agent write the pages. The originals stay here as the source. Delete from `raw/` only when the file is genuinely worthless, and move it to `archive/` if you are unsure.

## What breaks if you get it wrong

An article filed under transcripts costs nothing on the day and collapses the taxonomy over a year, because the next reader copies what they see. A new subject bucket splits the same shape across two places, so a search for last quarter's calls now needs two searches and finds one. And material that reaches an answer without passing through the distillation step gets quoted as settled knowledge when it is a first draft somebody said out loud on a call.
