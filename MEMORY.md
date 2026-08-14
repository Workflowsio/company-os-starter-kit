# MEMORY.md - the memory index

This is an index, not a store. One line per topic file in `.claude/memory/`, and **each line is a reason to open that file**, never a summary of what is in it. A line that summarizes gets read instead of the file, and the summary is the copy that goes stale.

**Line format:**

```
- [Title](.claude/memory/topic-file.md) - when to open it, and what it carries that you cannot guess. [YYYY-MM-DD]
```

**Four conventions that keep this file small:**

- **Update in place. Do not append.** A second line on the same topic is how an index doubles in a month and starts contradicting itself. Edit the existing line and re-stamp the date.
- **Date-stamp every line** in `[YYYY-MM-DD]`, no other format. An undated line cannot be triaged, and telling old routing from current routing at a glance is the whole point of the ceiling below.
- **Hard ceiling: {{MEMORY_INDEX_CEILING}} lines** (default 120). Past it, move a whole topic into `company-wiki/` and leave a single pointer line here carrying its when-to-open hook. A ceiling with no escape route is a ceiling people write past.
- **De-identify unless the content is already public, and keep credentials out entirely.** This is the file most likely to be read aloud in a session transcript.

**What earns a line:** something an agent would otherwise re-derive, re-ask, or get wrong twice. A correction the operator made. A tool that behaves differently from its docs. A decision and the reason behind it. Not a status update, not a task, not a log entry.

---

## Index

The index is empty in a fresh clone, and the first real line arrives the first time an agent gets something wrong twice.

Four worked examples of the form, kept inside a code block rather than rendered as live entries. A line pointing at a missing file is the one failure this index cannot survive: once a reader hits one dead link they stop trusting the rest, and the check that fails a dangling path in any root file would fail on these too if they were live.

```
- [Account escalation](.claude/memory/account-escalation.md) - read before replying to an at-risk account; carries who signs off and the two things never to promise. [2026-01-15]
- [Enrichment provider quirks](.claude/memory/enrichment-quirks.md) - read before building any list query; carries the parameters that silently return a fraction of the real matches, per provider. [2026-01-22]
- [Sequencer rate limits](.claude/memory/sequencer-limits.md) - read before scheduling a send above the usual daily volume; carries the per-mailbox ceiling and what the platform does when you cross it. [2026-02-03]
- [Why we killed the nested skill tree](.claude/memory/skill-tree-decision.md) - read before proposing folders inside `.claude/skills/`; carries what broke both times and how long it stayed broken. [2026-02-10]
```

Write each real line beneath this block, in the same form, pointing at a file that exists.
