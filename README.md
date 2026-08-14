<p align="center">
  <img src="https://img.shields.io/badge/Claude_Code-Ready-blueviolet?style=for-the-badge" alt="Claude Code Ready" />
  <img src="https://img.shields.io/badge/Safety_guard-Tiered-green?style=for-the-badge" alt="Tiered safety guard" />
  <img src="https://img.shields.io/badge/Counts-Script_owned-orange?style=for-the-badge" alt="Counts are script owned" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="MIT License" />
</p>

# Company OS Starter Kit

**Build the context layer your agents read before they do real work.**

A runnable scaffold for the versioned store of company knowledge, rules, account state and playbooks your agents load before they act: five content roots, the agent config, a flat skill library, a tiered safety guard, and the machinery that stops the numbers in your own docs from lying to you.

We build GTM systems for a living and run our own company on a store shaped exactly like this one. What is in here is the structure we kept, including the parts we had to reverse to get to it.

Built by [Dan Rosenthal](https://linkedin.com/in/dan-m-rosenthal) at [workflows.io](https://workflows.io).

---

## What changed in this version

Three things the old kit taught are now wrong, and each one is wrong for a reason we paid for. If you cloned the old version, read this before you merge anything.

**The skill library is flat.** It used to be `gtm-skills/<name>.md` at the repo root, with a guide suggesting you group by service line as the library grew. It is now `.claude/skills/<name>/SKILL.md`: one folder per skill, exactly one level under the skill root, no category folders. We nested a library by service line twice because it reads beautifully both times, and both times the loader silently stopped discovering the nested skills. Nothing errored. The skills were simply not there, and the first time we papered over it by keeping a full duplicate copy of every skill somewhere else. Taxonomy now lives in the filename prefix and in the catalog, which are the two places that do not affect discovery. Before you change this in your own store, measure the depth your runtime discovers at. That constraint is physics and everything else about the tree is preference.

**The bundled plugin is gone and the same six commands ship as plain files.** `plugin/` and `PLUGIN-GUIDE.md` are deleted; the commands live in `.claude/commands/workflows/` and behave identically. A distribution layer that ships copies of what the repo already contains is a stale duplicate by construction. We ran one for 71 days, changed direction on it five times, and removed it for cause after measuring that it carried a strict subset of the canonical skills, byte-identical agent definitions, and a connector config already covered at the root. The commands were never the problem. The wrapper was. Deleting it also bought the follow-up rule: chase the dead namespace out of everything that referenced it in the same pass, because removing the layer and leaving the references is its own outage.

**Counts are owned by a script.** The old kit shipped hand-maintained tables with a `{{date}}` in every row, which is a promise to update something nobody updates. Now `scripts/refresh-counts.mjs` measures each mechanical count from disk and rewrites it in place inside a named anchor, `--check` fails when a count has drifted or a file on disk is missing from the catalog, and a CI job runs it on every pull request and on direct pushes. Every hand-maintained count in our own store drifted at once, including two contradictory numbers about 40 lines apart in one file and three different totals in another. A number with no owner is a lie with a delay fuse.

### Where the old paths went

| Old path | New path |
|---|---|
| `blueprint/company/*.md` | `company-wiki/company/*.md` |
| `blueprint/wiki/outbound-playbook.md` | `company-wiki/services/outbound/outbound-playbook.md` |
| `blueprint/wiki/processes.md`, `blueprint/wiki/onboarding.md` | `company-wiki/company/` |
| `blueprint/company/voice.md`, `design-system.md` | `company-wiki/marketing/` |
| `gtm-skills/<name>.md` | `.claude/skills/<name>/SKILL.md` |
| `gtm-skills/guide.md`, `blueprint/skills/guide.md` | one file, `.claude/skills-guide.md` |
| `plugin/commands/workflows/*.md` | `.claude/commands/workflows/*.md` |
| `plugin/.claude-plugin/plugin.json`, `PLUGIN-GUIDE.md` | deleted, see above |
| `blueprint/hooks/*.sh` | `.claude/hooks/*.sh` |
| `blueprint/hooks/settings.json` | `.claude/settings.json` |
| `blueprint/INDEX.md` | `INDEX.md` |
| `blueprint/raw/guide.md`, `blueprint/archive/guide.md` | `raw/guide.md`, `archive/guide.md` |

New in this version: the `clients/` root, the rules layer in `.claude/rules/`, the refresher in `scripts/` with its CI job in `.github/workflows/`, and two new root files, `AGENTS.md` and `MEMORY.md`.

---

## What is a Company OS?

A Company OS is a set of files, mostly markdown, that gives your agents persistent knowledge about your business. Your tools, your processes, your rules, your voice, your accounts. Instead of re-explaining the business every conversation, the agent starts every session already knowing who you are.

At the center is `CLAUDE.md`, the one file the runtime reads on load. It points at everything else: company context, the skill library, connected systems, the rules layer, the safety guard. It is not a prompt you paste. It is a store that compounds the more you use it, and the reason it compounds is that a change to it is a diff somebody can review.

---

## The five content roots

<!-- counts:roots -->5<!-- /counts:roots --> content roots, four root files, one config area. That is the whole top level, and there is no sixth root. Anything genuinely homeless goes into an existing bucket or into `raw/misc/`, which is the guaranteed landing zone that makes the no-new-roots rule survivable under pressure. Each content root carries a `guide.md` describing what belongs in it, and `.claude/` carries one per moving part: `skills-guide.md`, `commands-guide.md` and `hooks/setup-guide.md`.

That count is anchored to what is on disk rather than to the rule, so a sixth root changes the number and stops it matching the heading above. A cheap loud signal beats a rule nobody re-reads.

| Root | Why it exists | What breaks if you put the wrong thing here |
|---|---|---|
| `.claude/` | Everything the runtime loads or executes: skills, rules, commands, hooks, settings, memory topics and machine-written session logs | The loader stops discovering, silently. A nested skill, a rule with no path glob, or a hook the settings file does not name will each sit there looking correct and never run, and nothing errors |
| `company-wiki/` | Durable, distilled knowledge, split by service line so every playbook has one obvious home | Drop raw or fast-changing material in here and people stop trusting the wiki. Once one section is known to be stale, readers discount all of it and go back to asking each other |
| `clients/` | One folder per account: a machine-written one-pager at `<slug>/<slug>.md` plus hand-maintained operating-state docs beside it | Put account state anywhere else and the session becomes the only place it lives, which does not survive a context clear. The same-named file is also a free drift detector: an account missing it skipped the standard path, and whatever else that path does was skipped too |
| `raw/` | Unprocessed input, bucketed by the shape of the artifact rather than its subject: transcripts, data exports, documents, external sources, misc | File by subject and every drop becomes a judgment call, which is how material ends up unfiled. Let raw material reach an agent's answer without a human-owned distillation step and the wiki stops being distilled |
| `archive/` | Superseded material kept for reference, moved rather than deleted | Delete instead of move and the reference graph breaks invisibly. Before any move, grep for references by name and by path, and check what is nested inside the folder you are about to move |

Then the four root files:

| File | Role |
|---|---|
| `CLAUDE.md` | The root context file. Identity, audience boundary, annotated structure, the dependency table, how skills route, connected systems, working principles, and a closing list of prohibitions |
| `AGENTS.md` | The second-agent contract. Only what differs by runtime: load order as pointers, the role boundary by task type, and an 8-field handoff packet. It restates no structure, because a second copy is a second thing to drift |
| `INDEX.md` | The catalog. The only list in the store: anchored counts a script owns, categories a human owns, one line per item saying what routes to it |
| `MEMORY.md` | The memory index. One line per topic, each line a reason to open the file rather than a summary of it, date-stamped and updated in place |

---

## Quick start

<table>
<tr>
<td width="50%">

**Option A: Terminal**

```bash
# 1. Clone
git clone https://github.com/Workflowsio/company-os-starter-kit.git
cd company-os-starter-kit

# 2. Copy the tree into your project. It is already
#    the shape you want, so this is a copy and not
#    an unpack. The leading slash on the exclude
#    matters: unanchored, it matches README.md at
#    every depth and silently drops the five raw/
#    bucket guides too.
rsync -a --exclude '.git' --exclude '/README.md' \
  ./ /path/to/your-project/

# 3. Give the store its own README. The refresher
#    refuses to run without a README and a .claude/,
#    and says which is missing. No chmod needed:
#    settings.json invokes each hook through bash.
cd /path/to/your-project
printf '# Company OS\n\nStart at CLAUDE.md.\n' > README.md
find . -name README.md | wc -l    # expect 6

# 4. See what the refresher owns and what it
#    refuses to own. Needs Node 18+, no installs.
node scripts/refresh-counts.mjs

# 5. Prove the drift check runs before you write
#    a single count of your own
node scripts/refresh-counts.mjs --check

# 6. Prove the safety gate runs before you trust it
bash .claude/hooks/safety-guard-test.sh

# 7. Open the project in Claude Code and start
#    with CLAUDE.md
```

</td>
<td width="50%">

**Option B: Just ask Claude**

Open your project in Claude Code and say:

```
Read CLAUDE.md, AGENTS.md, INDEX.md and every
file under company-wiki/. Interview me about my
business one question at a time and fill in every
placeholder. Start with the identity block and the
audience boundary, then the five roots. Do not
write a number unless a rewrite anchor owns it.
```

Claude will:
- Walk each section of `CLAUDE.md` in build order
- Ask about your company, tools, team and accounts
- Fill in every `{{placeholder}}` from your answers
- Set up your first account folder and one playbook
- Run the refresher so the counts start out true

No manual markdown editing required. Hour one is three files: the identity block, the catalog stub, and one real account folder.

</td>
</tr>
</table>

---

## What ships in `.claude/`

### The skill library, flat

<!-- counts:skills -->5<!-- /counts:skills --> starter skills, each at `.claude/skills/<name>/SKILL.md`. A skill is a reusable instruction set that tells the agent how to run one play: frameworks, decision points, anti-patterns and a quality bar.

| Skill | What it does | Example prompt |
|---|---|---|
| **outbound-copywriter** | Cold email sequences using the SPARK framework, power patterns and archetypes | `Write a 3-step sequence for VP Sales at mid-market SaaS` |
| **linkedin-post-writer** | Posts in your voice with hook formulas, formatting rules and a scoring rubric | `Write a LinkedIn post about why most outbound fails` |
| **icp-modeller** | Tiered ICP matrix with firmographic, psychographic and behavioral scoring | `Build an ICP for our new product targeting fintech` |
| **gtm-strategist** | GTM motion design, tool selection, channel strategy, budget allocation | `Design a GTM motion for our Series A launch` |
| **discovery-prep** | Pre-call research briefs with pain hypotheses and objection handling | `Prep me for a call with the VP Marketing at Acme` |

These five are GTM starters. The format works for any domain. `.claude/skills-guide.md` covers adding your own, and the one rule to keep is the flat one: taxonomy in the filename prefix and in `INDEX.md`, never in the tree the loader walks.

### The workflow commands

<!-- counts:commands -->6<!-- /counts:commands --> commands in `.claude/commands/workflows/`. Every markdown file under `.claude/commands/` is discovered as a command, subfolders included, so the folder is the namespace and any other file you drop in there becomes a command too.

| Command | What it does |
|---|---|
| `/workflows:brainstorm` | Explores an approach through dialogue before anything is committed to a plan |
| `/workflows:plan` | Turns a brief into a structured plan file with checkboxes and sources |
| `/workflows:work` | Executes the plan, tracking every task and shipping the deliverables |
| `/workflows:review` | Reviews a deliverable with several agents in parallel |
| `/workflows:compound` | Documents a win or a discovery so the next run starts further along |
| `/workflows:swarm` | Runs the whole loop with a swarm of parallel agents on the execution phase |

`.claude/commands-guide.md` covers what was adapted for GTM work, what was deliberately left alone, and every dependency these six files reference that this kit does not ship. It sits outside `commands/` for the reason in the paragraph above: a README inside that tree loads as a seventh command, and then the loader disagrees with every count in the store. Terminology and examples are in scope when you adapt these further. Gates, phases, task boards and agent spawning are not, because a rewording pass that stripped them once cut one command to a fifth of its length, left it looking entirely plausible, and quietly stopped the parallel execution.

### The rules layer

<!-- counts:rules -->5<!-- /counts:rules --> path-scoped rules in `.claude/rules/`, each one a small file with a `paths:` glob in its frontmatter that loads only when the agent touches a matching path. A rule costs nothing when it is not loading, so it is the cheapest rung of the enforcement ladder and the right place for anything ambiguous. `CLAUDE.md` carries the index of which rule narrows which subtree.

Two conventions matter more than the rules themselves. Precedence is declared in both directions: the broad rule names the narrow one, and the narrow one states in its own body that it overrides the broad rule inside its scope. Precedence implied by directory depth is precedence nobody can verify. And a rule earns its tokens only when it names a consequence the filesystem does not reveal on inspection. If the agent would reach the same behavior by reading the directory it is standing in, delete the rule.

### The tiered safety guard

`.claude/hooks/safety-guard.sh` runs before every tool call, reads the whole pending action, and returns its decision as an exit code. Non-zero blocks and the runtime feeds the message back to the model as a blocking error. It exists because permission prompts get switched off, which makes the gate the replacement for the prompt rather than a layer on top of it. The old kit shipped one flat blocklist of tool names. This one is a matrix.

- **Four operation classes, by blast radius rather than by how technical the action feels.** Irreversible and outward facing, production mutation, destructive but internal, and reversible internal. A campaign activation feels routine next to live SQL, and it is the one that reaches every contact on the list and cannot be recalled.
- **Four identity tiers against those classes.** Owner, trusted, team, and unresolved. An owner gets a warning and a logged allow on a destructive internal action and a confirmation on anything outward facing; team and unresolved identities get two-person approval at the top two classes. Unresolved is not a fourth tier, it is a fallback that resolves to the strictest one. The owner-warning cell is load bearing: a gate that blocks its own author on every destructive command is switched off inside a week, and a switched-off gate protects nobody at any tier.
- **The roster lives outside the script**, at `.claude/safety-roster` in the project or `~/.claude/safety-roster` per machine. A key present in the roster replaces the built-in list for that tier, so promoting somebody is a one-line edit rather than an edit in every copy the script is deployed to. Copy `.claude/safety-roster.example` and fill it in before you rely on the tiers, because until that file exists every identity resolves to the strictest tier. The guard says exactly that at session start rather than leaving you to discover it.
- **Three approval classes.** A per-call approval binds to a hash of the full payload, so it authorizes this message to this person rather than messages in general. A batch approval binds to the operation and is gated to the reversible tier by an explicit tier check, because the failure it prevents is a row-by-row run that prompts 200 times and trains the operator to approve without reading. A two-person approval is single-use, and the model is forbidden from creating it.
- **The audit log records allows as well as blocks**, one tab-separated row per decision, with distinct values for a warned owner, a redeemed batch and a confirmed approval, and in-band rotation. The tuning question is which gates fire so often that people approve without reading, and block rows alone cannot answer it. `--synthetic` fires a payload designed to block and tags the row, so silence in the log is provable rather than assumed.
- **The not-guarded list is published with its reasoning**, in the script's own header. Internal team messaging, mail drafts, calendar writes, issues, comments and pull requests, and reads of any kind. All reversible, internal, low blast radius. Over-guarding them produces the approval treadmill that gets the whole gate turned off.
- **A read word in the name does not beat a write word.** The read allowlist is what makes verb matching usable, and it is vetoed whenever the same name also carries a guarded verb. Without that veto, one allowlisted token anywhere in the name won outright: `delete_leads_from_list`, `move_leads_to_campaign_or_list` and `find_and_delete_duplicates` all exited 0, silently, with no audit row, while their near-twins blocked. The harness fires the real connector names now rather than invented ones, because an invented name that happens to dodge a collision reports a pass over a hole.
- **The write family is guarded, scoped to connected systems.** Create, update, edit, patch, set, add, sync and manage on an `mcp__` action are `destructive-internal`, and export, webhook, writeback and forward are outward, because data leaving for a third party is not recallable. Local file edits are untouched: they are reversible and internal by definition, and guarding them is the treadmill. Editing the sequence a live campaign sends sits in the outward class beside activating it, since it reaches the same people.
- **The known gaps are published beside the guarantees**, in the script's own header. An externally shared channel in your team chat is outward facing and the gate treats all team chat as internal. Identity resolves from the committer email, so anything that can write the repository config can change the tier it resolves to. The shell companion patterns are narrow by design and a determined rewrite of a command can miss them. A connector exposing arbitrary SQL under a bare `query` name is indistinguishable from a lookup and passes. And the write family is classed destructive-internal for friction reasons, which is a choice about where the approval budget goes rather than a claim that those writes are recoverable.
- **A payload the gate cannot read is a block, not an allow.** Unparseable JSON, a truncated body, or an action under a key this gate does not know all fail closed with an audit row. Empty stdin is the only clean exit. That distinction matters because a silent allow with no trace is indistinguishable from a gate nobody triggered, which is the exact shape of the prefix-scan defect the script spends ten lines warning against.

Every block message is addressed to the model rather than to the human: it names the effect in one line, surfaces the two or three decision-relevant fields truncated, prints the exact command that mints the approval, and forbids routing around the gate with a raw API call, a different tool or a rewritten command. Prove the matrix by firing payloads at it rather than by reading it. `safety-guard-test.sh` in the same folder does exactly that, and `.claude/hooks/setup-guide.md` covers the wiring.

### The hooks, and the settings that decide whether they run

<!-- counts:hooks -->3<!-- /counts:hooks --> hooks in `.claude/hooks/`: the safety guard, a session logger, and desktop notifications. The logger writes per-session JSONL into `.claude/sessions/`, which it creates on first run and `.gitignore` keeps out of the store. `safety-guard-test.sh` sits in the same folder and is deliberately not one of them, which is why the refresher exempts it by exact path instead of counting every shell file it finds. An exemption you can read off a list is one somebody can argue with later; a pattern that quietly swallows files is not.

`.claude/settings.json` wires the three to lifecycle events, and a hook that exists on disk without being named in that file does not run and nothing tells you, so the audit is a grep of the settings file against the directory.

Two details in that file are load-bearing and both look like formatting. Every hook is invoked as `bash "$CLAUDE_PROJECT_DIR/..."`, quoted and through `bash`. Unquoted, a project path containing a space fails at the first space and the tool call is never gated: both of the stores this kit is modelled on live at a path with a space in it. Invoked directly rather than through `bash`, a copy that lost its executable bit exits 126, and 126 is a non-blocking hook error rather than the exit 2 that blocks, so the gate is off with no signal.

---

## The drift control kit

`scripts/refresh-counts.mjs` measures every mechanical count from disk and rewrites it in place. Node 18 or later, zero dependencies, nothing to install.

```bash
node scripts/refresh-counts.mjs           # print what it owns and what it refuses to own
node scripts/refresh-counts.mjs --write   # rewrite every anchored count
node scripts/refresh-counts.mjs --check   # read only, exits non-zero and names every problem
```

`.github/workflows/check-counts.yml` runs the check on pull requests as prevention, and again on direct pushes to the default branch as coverage. The second trigger is not redundant. Repository admins hold review-gate bypass by design and nobody gives that up, so one direct push with a stale local catalog can revert a rename and drop skills that the pull request check never sees.

**Anchors are the ownership contract.** A number counts as owned only when a named anchor wraps it:

```markdown
<!-- counts:skills -->5<!-- /counts:skills -->
```

Anything outside an anchor rots, and it rots while the check reports that everything is current. In the store this kit is modelled on, the anchored headers were exact while an unanchored tree 50 lines above them, in the same file, was wrong by seven skills, one agent, two rules and several dozen wiki pages, and the freshness check passed the whole time. So the rule for a new number is: name the anchor, or do not write the number. Run the script with no arguments and it prints its own ownership manifest, which is the fastest way to see which anchor names exist.

The script also scans the root markdown files for a bare digit in front of a noun it owns and fails when it finds one outside an anchor, because a check that does not enumerate its own coverage turns an obvious wrong number into an invisible one that a green check endorses. The escape hatch is required and explicit, `<!-- counts:ignore -->`, so the decision to exempt a number is visible in the diff. That coverage scan is also why the badge row at the top of this README carries no counts. A shields.io URL cannot hold a rewrite anchor, so a number in a badge is a number nobody owns.

**Counts are mechanical, categorization is judgment.** The script rewrites counts silently and never assigns a category. When it finds a file that no catalog section mentions it prints the orphan, names the headings it could be filed under, and fails. A script that guessed would file things wrong quietly, and a catalog that is quietly wrong stops being read at all, which costs more than a loud failure.

**`INDEX.md` is the catalog and the only list in the store.** One entry per item: the name, one line on what it does, and the phrases that route to it, under a category heading a human chose. `CLAUDE.md` explains how skills are routed and never lists them, because a second list is a second thing to drift. The same check enforces two invariants that each catch a class of decay early: no knowledge page sits at the root of `company-wiki/`, and every account folder carries its same-named one-pager. The wiki root has exactly one exemption, its own `guide.md`, listed by exact path in the script so the exemption is auditable rather than assumed.

---

## What this kit does not do

Stated exclusions, because an omission reads as an oversight and produces a permission request every time, while a stated exclusion reads as a decision you can argue with.

- **No adoption telemetry.** Nothing here counts who invoked a skill or whether anyone read the wiki, and retrofitting that later is what nobody does. Two metrics you can compute by hand from day one: the share of changes carrying a human author and an intent sentence, and the share of working sessions that end with the account doc updated. Treat week one as your baseline rather than a target and watch the direction.
- **Retrieval indexing is out of scope.** No embeddings, no vector store, no sync job. Grep and the catalog until the wiki is genuinely too large for grep. An index with no scheduled refresher becomes agent discipline, and agent discipline decays into confident citations of paths that no longer exist.
- **The two-person approval is a presence check, not an identity check.** It is a file in a shared temporary directory, so any process that can write that directory can mint it. It proves an owner was at the keyboard, not which owner, and an implementation claiming otherwise is lying to its operators. The tier itself sits on the same boundary, because identity resolves from the committer email. Real second-party identity needs a second machine, a signed token, or an approval channel the model cannot write to.
- **The refresher owns mechanical counts only.** Counts, and nothing else. It will not categorize, it will not fix a stale sentence, and it cannot tell you that a paragraph became false. Every number outside an anchor is yours to maintain, which is the reason there are so few of them in here.
- **The scheduled backstop is not in the box.** `check-counts.yml` is read-only in both of its triggers, so it tells you a count drifted and leaves the correction to you. The full rung 4 is a scheduled run in `--write` mode that opens the correction as a reviewable change and never pushes to the default branch itself, plus one reusable failure issue per job that later runs comment on. It is a dozen lines of workflow and it needs write permissions on your repository, which is a decision only you can make, so it ships as an instruction rather than as a file that asks for a token on day one. Add it once the check has caught something real.
- **No write-time structure gate ships, deliberately.** The kit ships rung 1 of the ladder, the five path-scoped rules, and rung 3, the review-time check. It does not ship rung 2, a deny gate that refuses a write to the wrong path. The layout rules are advisory: nothing stops a sixth top-level folder, a nested skill, or a scheduled check filed outside `.github/workflows/`. A deny gate is the only rung whose failure mode is blocking correct work, and you cannot name the unambiguous cases until three real mis-writes have happened. Add one covering exactly your three, then. The blast-radius gate in `.claude/hooks/` is a different mechanism and does not cover this.
- **The enforcement ladder assumes a repo with review and a scheduled runner.** If your team has neither, drop the review-time check and the scheduled backstop rather than faking them, and say so in your `CLAUDE.md`. The honest substitutes are a daily snapshot export and one named owner per root.
- **The workflow commands reference commands and skills this kit does not ship.** `/workflows:swarm` is the heaviest case, with four sub-commands, and `plan`, `work`, `review`, `brainstorm` and `compound` each reference at least one absent skill. Every one of the six carries a disclosure line at its head saying to skip an unavailable step and name it in the run summary rather than stopping, and `.claude/commands-guide.md` lists the full set with the file and step that calls each.

---

## Philosophy

**Why version control?** Branching, diffs, review, history. Your agent context deserves the same rigor as your code. When something breaks you revert it, and when somebody joins they clone and go. It also gives you attribution for free, which turns out to be the only adoption signal you get without instrumentation.

**Why markdown?** Every tool reads it, every person can edit it, there is no proprietary format and nothing to migrate out of. The runtime-specific parts of this kit are the hooks, the commands and the discovery depth. The content transfers anywhere.

**Why this structure?** `CLAUDE.md` is the hub and the five roots are the spokes. Skills are the plays, rules are the local constraints, the guard is the last point where a mistake is still cheap, and the refresher is what keeps all of it honest a month later. Each piece has one job. Add what you need and delete what you do not, but delete it by reference graph rather than by whether it looks unused.

**Start small.** Hour one is three files: the identity block at the top of `CLAUDE.md`, the catalog as a two-heading stub, and one folder for one real account with a hand-written operating-state doc in it. If an agent reading that one doc before a call is not visibly better than the status quo on the first afternoon, structure is not your problem. A store with five solid files beats one with fifty scattered ones.

**Multiplayer.** Share the repo. Everyone gets the same context, skills compound across sessions, and the wiki stays current through commits rather than through goodwill.

---

## Credits

Built by [Dan Rosenthal](https://linkedin.com/in/dan-m-rosenthal) at [workflows.io](https://workflows.io).

The six workflow commands in `.claude/commands/workflows/` are built on [Compound Engineering](https://github.com/EveryInc/compound-engineering-plugin) by [EveryInc](https://github.com/EveryInc). `plan`, `work`, `review`, `swarm`, `brainstorm` and `compound` all come from their open-source foundation, adapted here for GTM work. Removing the plugin wrapper changed how they are distributed and nothing about where they came from.

---

**[Follow me on LinkedIn](https://linkedin.com/in/dan-m-rosenthal)** for more on building with AI, GTM systems and context engineering. I post about what we are building at workflows.io and the frameworks behind it.

**Star this repo** if it saved you a restructure.
