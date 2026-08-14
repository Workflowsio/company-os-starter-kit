---
paths:
  - "company-wiki/**"
---

# Wiki knowledge

The wiki holds distilled knowledge that a human owns. Material graduates into it from `raw/`, and the graduation step is the whole point: nothing reaches an agent's answer straight out of an unprocessed dump.

## What graduates

A page earns a place here when the same question has been answered twice from memory, when a play has run enough times to have a shape, or when a decision will still be true next quarter. Transcripts, exports and clippings do not graduate; the page written from them does, and it names the source it came from.

## Authoring bar

- Every page lives in a subfolder. Zero knowledge pages at the wiki root, and the one named exemption is `guide.md`, which describes the root itself. A page with no folder means the taxonomy has a hole worth naming.
- Split by rate of change and owner before you split by topic. A volatile status line inside a durable page is what teaches people to distrust the whole file.
- One topic per page. State what the page is for in its first two lines.
- Numbers carry a verification date, or sit inside an anchor the counts refresher in `scripts/` owns, or do not get written. A dated number decays visibly; an undated one lies quietly.
- Machine-generated files may live beside the docs that describe them, and each one opens with a banner naming its writer and source.
- Distill from what is already in `raw/`. If the answer needs a live lookup, do the lookup first, land the result in `raw/`, then write the page from it.

## Precedence

Inside `company-wiki/**` this file overrides `repo-structure.md` on what a page must contain. `repo-structure.md` still owns the top level.

`raw-input.md` governs material before it graduates and this rule does not reach into `raw/**`. The moment content lands here it is held to the bar above, whoever moved it.
