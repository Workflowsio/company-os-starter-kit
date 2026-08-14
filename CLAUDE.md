# CLAUDE.md - {{company_name}} Company OS

<!-- ============================================================================
     THE ROOT CONTEXT FILE (master template)

     The one file the runtime loads on every session, in every subtree, for
     every task. The most expensive real estate you own, so every section has
     to earn its share of the budget.

     BUDGET: about 3,000 words of filled-in content. Roughly 200 lines is a
     working target that nothing enforces, so do not treat it as a limit and
     then blow it in one section. Each of the 14 sections states its share in
     its own comment. The connected-systems inventory is a quarter of the file
     on purpose. The discipline that matters is that every section is present
     and none of them has quietly turned into an inventory.

     HOW TO USE: replace every {{placeholder}} with a real value or delete the
     row; keep the HTML comments until your team knows why each section exists;
     keep the section ORDER, which runs cheapest-to-decide first and closes on
     the prohibitions because that is the highest-recall position in context.
     Sections 2, 6, 7 and 14 are the four that cost the most when missing.

     Built by Dan Rosenthal (workflows.io). MIT.
============================================================================ -->

<!-- ============================================================================
     SETUP MODE - INSTRUCTIONS FOR THE AGENT, NOT FOR THE READER

     When this file is still full of {{placeholders}}, do not wait for the user
     to fill them in by hand. Interview them.

     1. On "help me set this up", go section by section in order. Research
        before you ask: read the repo, the connector config and anything
        already filled in, then ask ONE question at a time and pre-fill
        everything you can already see. Never ask for a value you can detect.
        State what you detected and let them correct it.
     2. Adapt the shape to their business. A product company's section 4 is not
        a services company's section 4. Rename rows, drop rows, add rows.
     3. Read each finished section back and get a yes before moving on.
     4. Skip what they are not ready for and leave "TODO: fill in later" in
        place, so the gap is visible rather than silently missing.
     5. Sections 6, 7 and 10 are the ones people skip and then regret. If they
        want to skip one, say what breaks and let them decide.
     6. When setup is done, run `node scripts/refresh-counts.mjs --check`, fix
        what it reports, then write their first skill from their most repeated
        task.
     7. Delete this SETUP MODE block afterwards. It is scaffolding.
============================================================================ -->


## 1. Identity

<!-- BUDGET ~2%. The agent needs an address, not a positioning line.
     ANTI-PATTERN: a mission statement. -->

This store is the context layer for **{{company_name}}**: the versioned knowledge, rules, account state and playbooks every agent reads before it acts.

- **Owner:** {{owner_name}} ({{owner_email}}) is the approval owner for anything this file says needs one.
- **Store:** {{git_host}}/{{org}}/{{repo}}, {{public_or_private}}.
- **Local path:** {{local_path}}
- **Backups:** {{backup_mechanism}} <!-- e.g. a mirror clone plus the host's own history -->
- **What the company does:** `company-wiki/company/overview.md`. Read it before writing anything a customer will see.

---
## 2. Audience boundary

<!-- BUDGET ~2%. Under a twentieth of the file, and it is what makes the other
     nineteen twentieths decidable without asking a human.
     ANTI-PATTERN: "use good judgment about sensitive content", which produces
     a permission request every session. -->

**Who reads this store:** {{who_can_read}} <!-- e.g. every employee, plus contractors on request -->

**Never written here, in any file, for any reason:**

- Credentials, tokens, keys or password hints. Keys appear only as `${VAR}` references.
- Personal opinions about a named individual.
- Personal life context of anyone on the team.
- {{extra_boundary_item}} <!-- e.g. anything under a client NDA; pre-announcement material -->
- Anything you would not hand a new hire on their first day.

Private material belongs in a separate store, not in a private subtree of this one. One boundary is enforceable; two are not.

<!-- WHY THIS IS ALSO IN AGENTS.md AND IN YOUR PRIVATE STORE: a boundary only
     one side knows about is not a boundary. This is the one deliberate
     triplication in the whole design. Counts get stated once; this gets stated
     three times, in full, on purpose. -->

---
## 3. Annotated structure

<!-- BUDGET ~14%. Largest prose block after the connector inventory, and it
     earns that only if every line carries a constraint instead of a filename.
     TEST PER LINE: if you cannot say what breaks when someone touches it, the
     line is inventory and belongs in the catalog.
     ANTI-PATTERN: a tree with per-directory counts. That is inventory in the
     costume of structure, and it drifts within weeks while the freshness check
     passes. There is not one count in the tree below, deliberately. Counts
     live in INDEX.md inside script-owned anchors. -->

Five content roots, four root files, one config area. There is no sixth root.

```
{{repo}}/
├── CLAUDE.md          # this file. Loaded on every session, in every subtree.
├── AGENTS.md          # only what differs by runtime. Points here, never restates.
├── INDEX.md           # the catalog. The only list of items anywhere in the store.
├── MEMORY.md          # the memory index. One line per topic file, each a hook.
├── .claude/           # agent config: skills, rules, commands, hooks, memory topics.
│   ├── skills/        # FLAT. One folder per skill, one level. See section 5.
│   ├── rules/         # path-scoped rules, each with a paths: glob. See section 8.
│   ├── commands/      # slash commands. Every .md in here loads as one.
│   ├── agents/        # subagent definitions, resolved by name rather than by
│   │                  # depth, so nesting is allowed here and not in skills/.
│   ├── hooks/         # the pre-action gate and session hooks. See section 9.
│   ├── memory/        # topic files that MEMORY.md routes to.
│   ├── sessions/      # machine-written session logs. Gitignored. Never hand-edit.
│   ├── settings.json  # wires hooks to lifecycle events. A hook not named here
│   │                  # never runs, and nothing tells you.
│   ├── skills-guide.md
│   ├── commands-guide.md      # outside commands/ so it is not an extra command.
│   └── safety-roster.example  # copy to safety-roster, which is gitignored.
├── company-wiki/      # distilled durable knowledge. Zero files at its root.
├── clients/           # one folder per account. Invariant in section 4.
├── raw/               # inputs bucketed by SHAPE, never by subject.
│   └── misc/          # the landing zone. Anything with no home goes here.
├── archive/           # superseded but kept. Move here, never delete.
├── scripts/           # refresh-counts.mjs and anything else a machine runs.
└── .github/workflows/ # the ONLY location the scheduler discovers. See section 7.
```

**Rules that make the tree survivable:**

- Do not create a new top-level folder. If something has no home it goes in an existing bucket or in `raw/misc/`. That rule only holds because the landing zone exists.
- `company-wiki/` splits by rate of change and owner, then by service line, so a new playbook's destination is never a discussion. A file at the wiki root means the taxonomy has a hole: name the hole, do not leave the orphan.
- `raw/` is where material enters and `company-wiki/` is where distilled material lives. Nothing goes from raw input into an answer without a distillation step a human owned.
- Before any delete, rename or move: grep every reference **by name and by path**, and check what is nested inside the folder. Classify by reference graph, never by observed usage. A composition layer's dependency is invisible to usage stats while the dependent is the thing people run.

**Deliberately not in this store:** {{exclusion_1}}, {{exclusion_2}} <!-- e.g. source code; anything private to the founder; anything a customer signs. Name the system that does hold each one. --> An omission reads as an oversight and produces a permission request every time it comes up. A stated exclusion reads as a decision and is free thereafter.

---
## 4. Account data model

<!-- BUDGET ~3%. State the invariant every folder satisfies, not what is in one
     account's folder today. -->

Every account gets `clients/<slug>/<slug>.md`, written once by the sync from {{ACCOUNT_SYSTEM_OF_RECORD}} <!-- the system your account list comes from: your CRM, or the ops database that holds per-account config --> and never overwritten after that, so a second sync run cannot clobber the human edits that accumulated beside it. Everything else in the folder is hand-maintained and no automation may write it.

Beside it, each active account keeps `clients/<slug>/operating-state.md`. It **replaces session memory for anything that must survive a context clear**. Read it first and trust it rather than re-auditing the account, and update it *before* finishing an operational change, not after.

The redundant-looking naming buys a checkable invariant: a missing same-named file is a signal, not noise. Audit for the artifact, not for the permission. Anything provisioned outside the standard path is identifiable by the standard path's leavings being absent.

---
## 5. How skills are routed

<!-- BUDGET ~7%. When the agent reaches for a skill, where they live, what the
     filenames carry.
     ANTI-PATTERN: listing the skills here. That is the catalog's job, and a
     second list is a second thing to drift. -->

Skills live at `.claude/skills/<skill-name>/SKILL.md`, **flat, one level deep**. Taxonomy is carried in the filename prefix (`outbound-`, `content-`, `revops-`) and in the catalog, never in the directory tree.

**Measure your loader's discovery depth before you design any tree.** In the store this kit came from, the library was nested by service line twice because it read beautifully, and both times it silently stopped loading. The second break was papered over by keeping a full duplicate copy of every skill somewhere else, which cost more than the original mistake.

**The catalog:** `INDEX.md`. Read it before writing anything new, because the skill you are about to write usually already exists under a name you did not guess.

**Token budget, three tiers.** Skill descriptions are always resident, so keep them short. Bodies load on match. Account-specific data loads at execution time only. **Do not preload:** `clients/**`, `raw/**`, `archive/**`, or any generated inventory. Large machine-generated context belongs behind a subtree-scoped import in a nested context file, never inline here.

---
## 6. Machine-written paths

<!-- BUDGET ~3%. Small in words, and the row that matters most during a cleanup.
     This is the table that stops a well-meant tidy-up from causing an invisible
     failure.
     ANTI-PATTERN: prose. "The index is auto-generated" is not a dependency
     table and nobody can act on it during a cleanup. -->

| Path | Written by | Cadence |
|---|---|---|
| Counts inside `<!-- counts:* -->` anchors in `INDEX.md` and `README.md` | `scripts/refresh-counts.mjs` | every PR and every push (`--check`), by hand on demand (`--write`) |
| `clients/<slug>/<slug>.md` | the account sync from {{ACCOUNT_SYSTEM_OF_RECORD}} | once, at account creation |
| `.claude/sessions/*.jsonl` | `.claude/hooks/session-logger.sh` | every session. Gitignored |
| `{{guard_audit_log_path}}` | `.claude/hooks/safety-guard.sh` | every guarded action |
| {{your_generated_inventory_path}} | {{your_exporter}} | {{cadence}} |

- **Do not rename or move a row above without updating its writer in the same change.** No error fires when you get this wrong.
- Every generated file opens with a banner naming its writer, its source, and the date its content last changed, and a change touching one of these paths carries `{{GENERATED_MARKER}}` <!-- default: [generated-refresh] --> in its message. Without the banner the file gets hand-edited within the quarter; without the marker a human hand-fixes a derived file and either the generator reverts the fix or the fix survives as something nobody can regenerate.
- **Never let a file claim it is auto-generated unless a named writer generates it.** A false banner orphans a file: the gate blocks humans and the generator never touches it.
- Every generator ships a delete path in the same change as its write path. Machine-written artifacts accumulate forever otherwise, and an inventory that disagrees with reality is worse than no inventory.

---
## 7. Scheduled checks

<!-- BUDGET ~9%. What runs unattended and, more importantly, the one location
     the scheduler discovers.
     ANTI-PATTERN: documenting the jobs and not the discovery location. That is
     the exact gap that lets a reorganization kill a job with no error. -->

**`.github/workflows/` is the only directory the scheduler enumerates. A job filed anywhere else does not run and nothing tells you.**

| Job | Trigger | What it does |
|---|---|---|
| `check-counts.yml` | on PR | read-only `--check`. The author sees the orphan before the change lands, which is the cheapest moment. |
| `check-counts.yml` | on direct push to the default branch | the same read-only `--check`. Not redundant: admin bypass of the review gate is real, and this is the trigger that covers it. |
| `check-counts.yml` | on PR and push | a second job clones the committed tree into a scratch directory and runs the check and the gate harness from the clone, so a file that exists only in somebody's working copy fails here rather than shipping. |
| `safety-guard.yml` | on PR touching the gate, its harness, `settings.json` or the workflow, and on push to the default branch | fires every cell of the tier matrix at the gate, asserts the exit code and the message, and prints the gate's sha256 so a reviewer can compare deployed copies. |
| {{your_sync_job}} | {{trigger}} | {{what_it_does}} |

**The write-and-propose backstop is not in the box, deliberately.** Both shipped jobs are read-only on every trigger: they tell you a count drifted and leave the correction to you. The full version is a scheduled run in `--write` mode that opens the correction as a reviewable change and never pushes to the default branch itself, plus one reusable failure issue per job. That needs write permissions on this store, which is a decision only its owner can make, so it ships as an instruction rather than as a file that asks for a token on day one. Add it once the check has caught something real.

**The incident that bought the location rule.** A tidy-up moved a scheduled check into a config folder. Nothing errored, no check failed, nobody was notified, and the job was dead for over three months. More than a dozen accounts were provisioned in that window with no team access, and it surfaced through an unrelated audit.

Two conventions came out of it:

- For anything discovered by location, keep a thin stub at the mandated path and put the logic in `scripts/`, so a tidy-up moves only the half that is safe to move.
- The push trigger exists because admin bypass of the review gate is a real feature nobody will give up. One direct push carried a stale local catalog and silently dropped skills that the PR check never saw. Do not remove the bypass. Cover it.

**Every scheduled job opens one reusable failure issue and comments on it thereafter.** One issue per job, reused, so the failure channel does not become noise people mute.

**Watch the output, not the job's own success flag.** An error handler cannot fire when a job dies hard. A separate job reads {{REPORTING_CHANNEL}} <!-- the channel where humans actually read job output, so silence is noticed -->, looks for the expected report string inside a time cutoff, and alerts by naming the missing job when the string is absent.

---
## 8. Path-scoped rule index

<!-- BUDGET ~4%. One line per rule file: its glob and what it narrows. Rules
     cost nothing when they are not loading, so use them for everything
     ambiguous.
     ANTI-PATTERN: precedence implied by directory depth. Nobody can verify it. -->

| Rule file | `paths:` glob | What it narrows |
|---|---|---|
| `.claude/rules/repo-structure.md` | `**` | the broad rule. Five content roots and no sixth, the landing zone, the one location a scheduled check is discovered, and the flat skill library. The four below override it inside their own globs. |
| `.claude/rules/client-data.md` | `clients/**` | the account invariant in section 4, why the synced one-pager is never hand-edited, and the operating-state update ordering. |
| `.claude/rules/wiki-knowledge.md` | `company-wiki/**` | what graduates out of raw input, the authoring bar, the zero-files-at-the-root invariant, and one obvious home per service line. |
| `.claude/rules/skill-development.md` | `.claude/skills/**` | flat library, filename taxonomy, no category subfolders, and never modify a skill during live work. |
| `.claude/rules/raw-input.md` | `raw/**` | bucket by shape, landing zone, no new buckets. |

**Both sides declare precedence.** The broad rule names the narrow one; the narrow one states in its own body that it overrides the broad rule inside its scope. Every rule on disk appears in this table and in the catalog, and `node scripts/refresh-counts.mjs --check` fails on a row pointing at a file that is not there and on a rule on disk that no root file names. This table drifted from disk by five filenames out of six in an earlier version of this kit, which is why the check now covers it.

**Write a rule only when you can name the consequence the filesystem does not reveal.** If the agent would reach the same behavior by reading the directory it is standing in, delete the rule.

---
## 9. Guardrail summary and blocked-action protocol

<!-- BUDGET ~9%. Summarize the classes, point at the gate, and spend most of
     the words on what happens when an action is denied.
     ANTI-PATTERN: listing every guarded operation by name here. The gate owns
     that list. No count of guarded operations appears in this file, because a
     number with no anchor is a lie with a delay fuse. -->

`.claude/hooks/safety-guard.sh` runs before every tool call and decides on **identity tier by blast radius**.

- **Four operation classes, by blast radius rather than by how technical the action feels.** `irreversible-outward` reaches a person outside the company or moves money. `production-mutation` changes a running system other people's work depends on. `destructive-internal` deletes or bulk-mutates internal records. `reversible-internal` is everything else and is not guarded. A campaign activation feels routine next to live SQL, and it is the one that cannot be recalled.
- **Four identity tiers:** owner, trusted, team, unresolved. Read from the committer identity and overridable per machine in a roster file outside the script, so a promotion is never an edit in three places. Unresolved is not a fourth population, it is a fallback that resolves to the strictest tier.

| | reversible-internal | destructive-internal | production-mutation | irreversible-outward |
|---|---|---|---|---|
| owner | allow, silent | **allow, with a warning** | confirm | confirm |
| trusted | allow, silent | confirm | confirm | confirm |
| team | allow, silent | confirm | two-person | two-person |
| unresolved | allow, silent | confirm | two-person | two-person |

- **The owner-warning cell is load-bearing.** A gate that blocks its own author on every destructive command is switched off within a week, and then it protects nothing.
- **Approval classes:** per-call, bound to a hash of the exact payload and single use, available on any class. Batch, bound to the operation name and reusable inside its TTL, available on `destructive-internal` only and enforced by an explicit class check in the script rather than by convention. Two-person, single use, on `production-mutation` and `irreversible-outward` at the team and unresolved tiers, and the model is forbidden from creating it.
- **The audit log records allows as well as blocks.** The tuning question is which gates fire so often that people are approving without reading, and blocks alone cannot answer it.
- **Deliberately not guarded, and published as a decision:** internal team messaging, mail drafts, calendar writes, code-host issues and comments, and reads of any kind. Internal, reversible, low blast radius. Over-guarding reversible internal work is what produces the approval treadmill that gets the whole gate switched off.
- **The matrix is proved by execution, not by reading.** `.claude/hooks/safety-guard-test.sh` fires a payload at every cell and asserts the exit code and the message, and `.github/workflows/safety-guard.yml` runs it on every proposed change to the gate and on every direct push.
- **Not covered, published as a gap:** {{uncovered_write_paths}} <!-- enumerate every write path the gate is NOT registered on: a second edit tool, shell moves, direct pushes, another agent identity --> A gate on one of four write paths reads as enforcement and functions as decoration. The gate's own header carries its known gaps beside its guarantees; read them before you rely on it.
- **No write-time structure gate ships, deliberately.** The layout rules in `.claude/rules/` are advisory: nothing stops a sixth top-level folder, a nested skill, or a scheduled check filed outside `.github/workflows/`. A deny gate is the only rung whose failure mode is blocking correct work, and you cannot name the unambiguous cases until three real mis-writes have happened. Add one covering exactly your three, then.

**When an action is denied:**

1. Stop. Do not retry with a different tool, a raw API call, or a rewritten command.
2. Tell the human in one line: what the action does, to whom or to what system, and whether it is reversible.
3. Get an explicit yes for **this payload**. A general go-ahead earlier in the session is not approval.
4. Complete the unblock step exactly as the deny message names it.
5. Retry once. Still denied, emit the handoff packet in AGENTS.md and stop. Never escalate your own permissions.
6. **Never create a two-person approval file yourself, under any circumstances.**
7. Record the outcome in the account's operating-state doc, including a denial you did not override.

---
## 10. Connected systems inventory

<!-- BUDGET ~25%. The single largest block, and worth it. This is where the
     agent learns which system is authoritative for which question, which is
     the thing it cannot work out by trying. The table below is under a tenth
     of this template because the rows are empty. Once they carry real
     limitations it lands near a quarter of your file, and if it does not, the
     limitation column is not filled in.
     ANTI-PATTERN: pasting configuration. Every credential is a ${VAR}
     reference, never a literal, and never in this file. -->

| System | What it is for | Authoritative for | Known limitation | Credential |
|---|---|---|---|---|
| {{crm}} | pipeline and account records | deal stage, owner, close date | {{limitation}} <!-- e.g. custom properties lag the UI by a sync cycle --> | `${CRM_API_KEY}` |
| {{email_sequencer}} | outbound email | send state, replies, bounces | reporting lags live sends | `${SEQUENCER_API_KEY}` |
| {{social_outreach_platform}} | social outreach | connection and message state | per-seat rate limits | `${SOCIAL_API_KEY}` |
| {{enrichment_provider}} | company and contact data | nothing. It is a source, never a source of truth | coverage varies by segment; verify before spend | `${ENRICH_API_KEY}` |
| {{ops_database}} | per-account config, keys, channels | which credential and channel an account uses | {{limitation}} | `${OPS_DB_TOKEN}` |
| {{automation_platform}} | scheduled and triggered automations | what is live right now | its own inventory can disagree with the live API. Trust the API | `${AUTOMATION_API_KEY}` |
| {{team_chat}} | internal comms and job reporting | nothing durable. Decisions move to the wiki | history is not a record of decisions | OAuth, no manual key |
| {{code_host}} | this store, review gate, scheduled checks | the store itself | admin bypass exists by design. See section 7 | OAuth, no manual key |
| {{retrieval_index}} | semantic search over the store | nothing. It is a cache of what the store already says | refreshed by {{refresher}}. Stale between runs | `${INDEX_API_KEY}` |
| {{billing}} | invoices and subscriptions | amounts owed and paid | irreversible-outward. Never fires unattended | `${BILLING_API_KEY}` |

<!-- ROW TEST: if you cannot fill the "authoritative for" column, you do not
     need the row yet. Two systems claiming the same answer is the most
     expensive ambiguity in a GTM stack, so name the winner in the row rather
     than leaving it to the agent.
     Credentials live in your environment, your secrets manager, or the
     connector's own OAuth. Never here, and never as a literal in the connector
     config: a store with keys in it can never be shared, and the whole point
     of this store is that it is shared.
     CLIENT WORK: when you operate on behalf of an account, its keys come from
     {{ACCOUNT_SYSTEM_OF_RECORD}}, never from your own workspace. -->

---
## 11. Operational data model

<!-- BUDGET ~3%. Where state lives, and who wins when two copies disagree. -->

- **Account state:** `clients/<slug>/operating-state.md`. It outranks session memory and your own re-audit.
- **Account config** (owner, channel, credential reference, service line): {{ACCOUNT_SYSTEM_OF_RECORD}}. It outranks anything written in a wiki page.
- **Pipeline state:** {{crm}}. It outranks a spreadsheet, a channel message, and this file.
- **When two disagree:** the row in section 10 marked authoritative wins. If neither is marked, stop and ask rather than picking. Then mark one.

---
## 12. Working principles

<!-- BUDGET ~9%. How to behave when no rule covers the case. Behavioral, not
     procedural. A principle true in every store you open can move up to your
     machine-level file with a pointer here, but only if every reader of this
     file is guaranteed to load that file. A store outside teammates clone
     keeps its principles stated in full, which is why these are in full. -->

- **Research before acting.** Find the real prior artifact before acting on any "same as last time" reference. If you cannot find it, stop and ask rather than rebuilding from memory.
- **Never ship a guess.** Anything you cannot verify gets flagged and chased down, not papered over. A stated unknown is cheap; a confident wrong number is not.
- **Date every hand-verified number, or leave it out.** An undated number cannot be triaged and it lies silently.
- **Say what you did not check.** A skipped check is not a passing check, and claiming coverage you did not have is worse than reporting a blocker.
- **Take initiative inside the guardrails**, and ask when the action is irreversible, outward-facing, or spends money. Test one before you run a hundred.
- **Collaborate on the plan, then run it to completion.** Challenge the approach before it is set; once it is set, do not hand back a list of manual steps.
- **After two failed attempts at the same fix, stop and diagnose the root cause** instead of shipping the same thing a third time.
- **Prefer a pointer with a promise.** "Full rules: X" gets skipped. "Full rules: X, read it before changing the retrieval schema" gets opened.

---
## 13. Self-maintenance rules

<!-- BUDGET ~7%. This is the section that makes the store self-healing instead
     of a snapshot. -->

- New durable knowledge goes to `company-wiki/`, distilled. New account facts go to that account's folder. Unprocessed material goes to `raw/`, never straight into the wiki.
- Adding a skill: create `.claude/skills/<name>/SKILL.md`, add its catalog entry under an existing category, then run `node scripts/refresh-counts.mjs --write`. The script owns the counts and rewrites them silently; it will never invent a category, and it fails loudly on an item missing from the catalog.
- **Counts are mechanical, categorization is judgment.** A script that guessed a category would file things wrong quietly, and a catalog that is quietly wrong stops being read at all.
- **Any new number in any context file gets a rewrite anchor in the same change, or does not get written.** Retrofitting anchors onto a file already carrying a dozen unowned numbers costs far more. The anchor is a matched pair of HTML comments named `counts:<key>`, with the digit between them and the noun outside, and the exact syntax is at the bottom of `INDEX.md`. The plural is not optional: the singular form is not matched, so a number written that way is never rewritten and never reported, and `--check` now fails on it by name.
- Commit after every meaningful change, with a message a teammate can act on. {{commit_and_push_convention}}
- After changing `company-wiki/`, refresh the retrieval index for the affected pages, or accept that search is stale until {{refresher}} runs.
- Run a one-time cleanup only alongside the mechanism that holds it. Cleanups without machinery regrow, and the only reductions that hold are the ones a machine enforces.

**Known broken (live list, {{KNOWN_BROKEN_LINES}} lines maximum, default 6 to 10).** Keep it dated, and strike resolved lines through rather than deleting them, so nobody re-diagnoses a known issue every session and nobody loses the fact that it was checked. Past the line limit something gets fixed rather than logged. Pretending the store is clean costs more than admitting what is broken.

- {{known_issue_1}} [{{date}}] <!-- e.g. the counts refresher does not cover the tree in README.md; numbers there are hand-checked -->
- ~~{{resolved_issue}} [{{date}}] resolved {{date}}~~

---
## 14. Do NOT

<!-- BUDGET ~4%. Around ten unconditional prohibitions, each with its
     consequence attached. Ending on the negative list is deliberate: it is the
     last thing in context and the highest-recall position for the rules that
     cost the most when broken. Nothing here is conditional. If a line needs a
     "usually", it belongs in section 12. -->

- **Do NOT nest the skill library.** The loader walks one level, so a subfolder stops loading and nothing errors.
- **Do NOT write a number that no script rewrites.** It goes wrong within weeks while the freshness check reports the file current.
- **Do NOT move anything discovered by location.** A move is a delete for the scheduler, and it fails silently.
- **Do NOT create a new top-level folder.** Use an existing bucket or `raw/misc/`. The top level grows forever after the first exception.
- **Do NOT hand-edit a machine-owned path.** The generator either reverts your fix or inherits an edit nobody can reproduce.
- **Do NOT delete, rename or archive before grepping every reference by name and by path**, and checking what is nested inside. Usage stats hide composition dependencies.
- **Do NOT commit a secret, and do NOT leave secret removal as a review step.** One leaked key costs a history rewrite and a re-clone for everyone.
- **Do NOT work around a blocked action** with a raw API call, another tool, or a rewritten command. The gate is a handshake you can complete.
- **Do NOT create a two-person approval file.** It exists to prove a second human was there.
- **Do NOT build a distribution layer that copies this store.** The clone is the distribution mechanism, and a copy goes stale while its namespace outlives it in every repo that referenced it.
- **Do NOT send anything to a person outside the company without an explicit yes for that exact payload.** Build approval is not send approval.
