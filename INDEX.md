# Catalog

<!-- THIS IS THE ONLY LIST IN THE STORE.
     CLAUDE.md explains how skills get routed and never lists them, because a
     second list is a second thing to drift.

     OWNERSHIP. Every number on this page sits inside a counts: anchor and is
     measured from disk by scripts/refresh-counts.mjs. Everything outside an
     anchor is yours: the categories, the one-line descriptions, the routing
     phrases, the ordering. The script will never invent a category, and it fails
     the build when it finds a file on disk that this page does not mention.

     ADDING A NUMBER. Name the anchor or do not write the number. A number outside
     an anchor rots while the check reports everything current, which is worse than
     no check at all. The literal syntax is at the bottom of this page, under "How
     the numbers on this page stay true", and it is down there rather than up here
     because an HTML comment cannot contain another one: the first closing marker
     ends the block, and everything after it renders as body text.

     THERE IS NO LAST-UPDATED COLUMN, ON PURPOSE. The previous version of this
     file carried a hand-typed date on every row. That column is the exact drift
     generator this kit argues against: nobody can verify it, it always reads
     plausible, and a stale row wearing a fresh date is worse than a stale row
     wearing nothing. The dates that matter live in the commit history, where they
     are true by construction. -->

<!-- counts:roots -->5<!-- /counts:roots --> content roots holding
<!-- counts:skills -->5<!-- /counts:skills --> skills,
<!-- counts:commands -->6<!-- /counts:commands --> commands,
<!-- counts:rules -->5<!-- /counts:rules --> rules,
<!-- counts:agents -->0<!-- /counts:agents --> agents,
<!-- counts:hooks -->3<!-- /counts:hooks --> hooks and
<!-- counts:wiki -->9<!-- /counts:wiki --> wiki pages.

Run `node scripts/refresh-counts.mjs` to see exactly which of those numbers a
script owns and which parts of this page it will never touch.

---

## Content roots

Five roots, and there is no sixth. When something has no obvious home it goes into
an existing bucket or into `raw/misc/`, which exists so that the no-new-roots rule
survives contact with a busy week.

| Root | Holds | Written by |
|---|---|---|
| `.claude/` | Skills, rules, commands, agents, hooks, settings | Humans, plus the refresher script |
| `company-wiki/` | Durable knowledge and playbooks, split by service line | Humans, distilled from `raw/` |
| `clients/` | One folder per account: a one-pager plus operating docs | Split ownership |
| `raw/` | Transcripts, exports, clippings, unprocessed dumps, bucketed by shape | Ingestion, plus anyone dropping something in |
| `archive/` | Anything superseded but worth keeping | Humans, on a deliberate move |

---

## Skills

<!-- counts:skills -->5<!-- /counts:skills --> skills, flat, one folder each.

Flat is not a style preference. The loader auto-discovers skills at one directory
depth only, so a library nested by service line reads beautifully and quietly
stops loading. Taxonomy goes in the filename prefix and in this catalog, never in
the tree the loader walks. See `.claude/skills-guide.md` before adding one.

- **outbound-copywriter** (`.claude/skills/outbound-copywriter/SKILL.md`) - writes cold email sequences using the SPARK framework, seven copy archetypes, subject-line formulas and a QA checklist. Routes on "write a cold email", "draft a sequence for this segment".
- **linkedin-post-writer** (`.claude/skills/linkedin-post-writer/SKILL.md`) - drafts LinkedIn posts in your voice using hook patterns, formatting rules and a scoring rubric. Routes on "write a LinkedIn post", "turn this into a post".
- **icp-modeller** (`.claude/skills/icp-modeller/SKILL.md`) - builds a tiered ICP matrix across firmographic, psychographic and behavioural dimensions, then maps tiers to campaigns. Routes on "build an ICP", "who should we target".
- **gtm-strategist** (`.claude/skills/gtm-strategist/SKILL.md`) - designs or audits a go-to-market motion: channel strategy, stack, budget allocation, the metrics worth tracking. Routes on "design our GTM motion", "audit our stack".
- **discovery-prep** (`.claude/skills/discovery-prep/SKILL.md`) - assembles a pre-call brief: company and prospect research, recent signals, pain hypotheses, objection handling. Routes on "prep me for a call", "brief me before this meeting".

---

## Commands

<!-- counts:commands -->6<!-- /counts:commands --> commands under
`.claude/commands/workflows/`, invoked as `/workflows:name`.

- **brainstorm** (`.claude/commands/workflows/brainstorm.md`) - explores a strategy through dialogue before anyone commits to executing it. Routes on "/workflows:brainstorm".
- **plan** (`.claude/commands/workflows/plan.md`) - turns a description into a structured plan that follows your conventions. Routes on "/workflows:plan".
- **work** (`.claude/commands/workflows/work.md`) - executes a plan step by step and ships the deliverable. Routes on "/workflows:work".
- **review** (`.claude/commands/workflows/review.md`) - runs a multi-agent review of a deliverable in an isolated workspace. Routes on "/workflows:review".
- **swarm** (`.claude/commands/workflows/swarm.md`) - the full pipeline with parallel agents: plan, execute, review, deliver, without stopping between steps. Routes on "/workflows:swarm".
- **compound** (`.claude/commands/workflows/compound.md`) - writes up a solved problem so the team inherits it instead of re-solving it. Routes on "/workflows:compound".

These are built on [Compound Engineering](https://github.com/EveryInc/compound-engineering-plugin)
by [EveryInc](https://github.com/EveryInc). Adapting the wording for a GTM team is
in scope; removing structural machinery is not. One adaptation pass in the source
store cut a command from 147 lines to 34 and downgraded another's coordination
primitive, and the gutted files stayed plausible enough that nobody noticed for
four days.

`.claude/commands-guide.md` carries what was adapted, what was left alone, and every
command and skill these six files reference that this kit does not ship. It sits
outside `.claude/commands/` because every markdown file in that tree loads as a
command, and furniture inside the discovered tree makes the count above disagree
with what the loader loads.

---

## Rules

<!-- counts:rules -->5<!-- /counts:rules --> rules in `.claude/rules/`.

A rule file carries a `paths:` glob in its frontmatter and loads only when the agent
touches a matching path, so it costs nothing when it is not loading and it is the
right home for anything ambiguous.

- **repo-structure** (`.claude/rules/repo-structure.md`) - globs `**`. The five content roots and no sixth, the landing zone, the one location a scheduled check is discovered, and the flat skill library. The broad rule that the other four override inside their own globs.
- **client-data** (`.claude/rules/client-data.md`) - globs `clients/**`. The machine-owned one-pager against the human-owned docs beside it, why the synced file is never hand-edited, and the operating-state doc that replaces session memory.
- **wiki-knowledge** (`.claude/rules/wiki-knowledge.md`) - globs `company-wiki/**`. What graduates out of raw input into the wiki, the authoring bar, and the zero-files-at-the-root invariant.
- **skill-development** (`.claude/rules/skill-development.md`) - globs `.claude/skills/**`. Flat layout only, the frontmatter router, test on a real scenario before committing, never modify a skill mid-engagement.
- **raw-input** (`.claude/rules/raw-input.md`) - globs `raw/**`. Bucket by the shape of the artifact rather than its subject, and the misc landing zone that keeps the no-new-roots rule survivable.

Write a rule only when you can name the consequence the filesystem does not reveal
on inspection. If the model would reach the same behaviour by reading the directory
it is standing in, the rule is tokens with no job. Both sides declare precedence:
the broad rule names the narrow one, and the narrow one states in its own body that
it overrides the broad rule inside its scope. Precedence implied by directory depth
is precedence nobody can verify.

---

## Agents

<!-- counts:agents -->0<!-- /counts:agents --> agents in `.claude/agents/`.

Empty on purpose. Add subagent definitions here when a task is worth isolating from
the main session. Each one gets a catalog entry with its routing phrases, same as a
skill.

---

## Hooks

<!-- counts:hooks -->3<!-- /counts:hooks --> hooks, wired to lifecycle events in
`.claude/settings.json`. Full documentation in `.claude/hooks/setup-guide.md`.

A fourth shell file sits in the folder and is not a hook. `safety-guard-test.sh`
fires payloads at the guard to prove the matrix rather than reading it, it is never
wired to a lifecycle event, and the refresher exempts it by exact path so the count
above stays a count of things that actually run.

- **safety-guard** (`.claude/hooks/safety-guard.sh`) - a PreToolUse gate that scores an action by identity tier and blast radius, then allows, warns, or holds it for approval. Logs allows as well as blocks, because a gate with an empty audit log is indistinguishable from a gate that never fires.
- **session-logger** (`.claude/hooks/session-logger.sh`) - appends every lifecycle event to a per-session JSONL file, which is what makes "did the gate actually fire" a question with an answer.
- **notify** (`.claude/hooks/notify.sh`) - desktop notification on the events you care about, so a session waiting on you does not sit waiting silently.

---

## Company wiki

<!-- counts:wiki -->9<!-- /counts:wiki --> pages, split by service line so that a
new page's destination is never a discussion.

Zero knowledge pages sit at the wiki root, and that is a checked invariant rather
than a convention. A page at the root means the taxonomy has a hole, and naming the
hole beats leaving the orphan. The one named exemption is `company-wiki/guide.md`,
which describes the root itself, is not counted as a page, and is listed by exact
path in the refresher so the exemption stays auditable.

### Company (<!-- counts:wiki:company -->6<!-- /counts:wiki:company --> pages)

- `company-wiki/company/overview.md` - what you sell, who you sell it to, positioning, the metrics that matter.
- `company-wiki/company/team.md` - roster, structure, who decides what, communication norms.
- `company-wiki/company/accounts.md` - the account roster and how it connects to your CRM.
- `company-wiki/company/gtm-stack.md` - the tools, how data moves between them, what is working and what is broken.
- `company-wiki/company/processes.md` - the recurring processes anyone might need to run.
- `company-wiki/company/onboarding.md` - the ramp plan for a new hire and the resources it points at.

### Marketing (<!-- counts:wiki:marketing -->2<!-- /counts:wiki:marketing --> pages)

- `company-wiki/marketing/voice.md` - tone, sentence shape, the words you use and the words you never use.
- `company-wiki/marketing/design-system.md` - colours, type, spacing, the visual rules a generated asset has to obey.

### Services (<!-- counts:wiki:services -->1<!-- /counts:wiki:services --> page)

- `company-wiki/services/outbound/outbound-playbook.md` - outbound strategy, channels, campaign types, what a good sequence looks like.

---

## Accounts

<!-- counts:clients -->1<!-- /counts:clients --> folders in `clients/`.

Each account folder is `clients/<slug>/<slug>.md` plus whatever the humans need
beside it. The same-named file is the one-pager; everything else in the folder is
hand-maintained and no automation is entitled to write into it. That redundant
naming buys a machine-checkable invariant, and the refresher enforces it: an
account folder missing its one-pager is a signal rather than noise.

Individual account folders are deliberately not itemised on this page. They turn
over weekly, and forcing a catalog edit per account is how a catalog stops being
maintained at all. The count is owned; the contents are not.

`clients/EXAMPLE-CLIENT/` is a worked example of the split, and `clients/guide.md`
explains what breaks when the two halves get mixed. Copy the folder or delete it.

---

## Raw input and archive

- `raw/` - bucketed by the shape of the artifact, never by subject: `raw/transcripts/`, `raw/data-exports/`, `raw/documents/`, `raw/external-sources/`, and `raw/misc/` as the guaranteed landing zone. Subject buckets need a judgment call on every drop, and judgment calls at ingestion time are how material ends up unfiled. See `raw/guide.md`.
- `archive/` - superseded material, moved rather than deleted, because a delete is invisible and a move is auditable. Grep every reference by name and by path before you move anything, and check what is nested inside the folder. See `archive/guide.md`.

---

## Orphans

Empty in the healthy state. This section is not a list anyone maintains by hand:
the orphan report is stdout from the refresher.

A file on disk that this page does not mention is an orphan. The script reports it
by path, names the headings above that it could be filed under, and exits non-zero.
It never picks the heading for you. A script that guessed would file things wrong
quietly, and a catalog that is quietly wrong stops being read at all, which costs
more than a failing check.

```
node scripts/refresh-counts.mjs --check
```

---

## How the numbers on this page stay true

`scripts/refresh-counts.mjs` measures every count above from disk and rewrites it
inside its anchor. `.github/workflows/check-counts.yml` runs the same script in
`--check` mode on every pull request and on every push to the default branch. The
push trigger is the one that matters most and the one most likely to be deleted as
redundant: admins hold review-gate bypass by design, and a direct push carrying a
stale local copy is exactly the change the review-time check never sees.

An anchor is a matched pair of HTML comments named for what they count, with the
digit between them and the noun outside:

```markdown
<!-- counts:skills -->5<!-- /counts:skills --> skills
```

Two rules follow from the syntax. The noun stays outside, because the body between
the markers is replaced wholesale on every run. And an anchor never goes inside
another HTML comment, because comments do not nest: the first closing marker ends
the outer block and the rest of it renders as visible text. The refresher fails on
both mistakes rather than leaving you to find them in a rendered page.

Run the script with no arguments to see every anchor name that exists, its current
value, and the list of things it will never write.

The README has the full ladder, what each rung cannot catch, and what this kit
does not ship.
