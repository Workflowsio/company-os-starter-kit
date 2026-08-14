---
paths:
  - "raw/**"
---

# Raw input

Everything unprocessed lands here first, bucketed by the SHAPE of the artifact and never by its subject.

## The buckets

- `raw/transcripts/` recordings and call notes, one file per conversation.
- `raw/data-exports/` machine output: CSV, JSON, report dumps.
- `raw/documents/` files a person handed you: decks, PDFs, contracts, briefs.
- `raw/external-sources/` material from outside the company: articles, posts, competitor pages.
- `raw/misc/` the landing zone.

Shape is decidable in a second, subject is not. A bucket named after a client or a project forces a judgment call on every drop, and material that needs a judgment call at drop time ends up unfiled. Do not add a subject bucket, and do not add a shape bucket without a real second example.

One bucket will end up holding almost everything, usually transcripts. The near-empty siblings still earn their place: the moment transcripts are the only visible bucket, the next person files an article there and the shape is gone. Keep each bucket's README for the same reason.

## The landing zone

`raw/misc/` is the guaranteed destination for anything that does not fit. It is expected to be messy and it is triaged on a cadence, not at drop time. It is also what makes the no-new-roots rule in `repo-structure.md` survivable, so do not tidy it out of existence.

## One-way flow

Material moves from here into `company-wiki/` through a distillation step a human owns, and never in the other direction. Nothing in `raw/` is a citable source on its own: quote it in an answer only after saying it is unprocessed input.

## Precedence

Inside `raw/**` this file overrides `repo-structure.md` on bucketing. `wiki-knowledge.md` does not apply here, and takes over the moment content graduates into `company-wiki/**`.
