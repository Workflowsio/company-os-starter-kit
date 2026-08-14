# Changelog

Written for someone who cloned the earlier kit and is deciding what to merge. It is grouped by what moved, what was removed, what is new, and what was broken and is now fixed. Every reversal names the failure that caused it, because a structure change with no failure attached is a preference and you should feel free to ignore it.

Read this before you merge anything. Three of the things the old kit taught are now wrong.

---

## Moved

**The blueprint wrapper is gone and its contents are the top level.** The old kit put everything under `blueprint/`, which had to be unpacked before it was usable. The roots are the taxonomy, so they are the top level now. Old path on the left, new path on the right:

```
blueprint/company/overview.md, team.md, accounts.md, gtm-stack.md
    -> company-wiki/company/
blueprint/wiki/processes.md, onboarding.md
    -> company-wiki/company/
blueprint/company/voice.md, design-system.md
    -> company-wiki/marketing/
blueprint/wiki/outbound-playbook.md
    -> company-wiki/services/outbound/
blueprint/hooks/*.sh          -> .claude/hooks/
blueprint/hooks/settings.json -> .claude/settings.json
blueprint/skills/guide.md     -> .claude/skills-guide.md
blueprint/INDEX.md            -> INDEX.md
blueprint/raw/guide.md        -> raw/guide.md
blueprint/archive/guide.md    -> archive/guide.md
gtm-skills/<name>.md          -> .claude/skills/<name>/SKILL.md
gtm-skills/guide.md           -> .claude/skills-guide.md   (one file now, not two)
plugin/commands/workflows/*.md -> .claude/commands/workflows/
```

**The skill library is flat, one folder per skill, exactly one level under the skill root.** The old layout was one markdown file per skill at the repo root, with a guide suggesting you group by service line as the library grew. Do not group by service line. The loader auto-discovers at one depth only, a nested library reads beautifully and silently stops loading, and nothing errors. That was done twice in the store this kit comes from, and the first time it was papered over by keeping a full duplicate copy of every skill somewhere else, which cost more than the original mistake. Taxonomy now lives in the filename prefix and in the catalog, which are the two places that do not affect discovery. Measure your own runtime's discovery depth before you design any tree: that constraint is physics and everything else about the layout is preference.

**The commands guide moved out of the commands tree**, to `.claude/commands-guide.md`, beside the skills guide and the hooks guide. Every markdown file under the commands directory loads as a command, so a README in there was a seventh command while every count in the store said six. The refresher used to paper over that with a named exemption. An exemption that makes the count disagree with what the loader loads is buying the wrong thing.

---

## Removed

**The plugin wrapper and its guide are deleted. The same six commands ship as plain files** in `.claude/commands/workflows/` and behave identically. A distribution layer that ships copies of what the repo already contains is a stale duplicate by construction. One was run for seventy-one days across five direction changes and removed for cause after measuring that it carried a strict subset of the canonical skills, byte-identical copies of the agents, and a connector config already covered at the root. Every artifact in it was a stale copy of something canonical, and the copies were what people actually loaded. The commands were never the problem, the wrapper was, and the credit for the commands is unchanged and still prominent.

If you are removing a wrapper of your own: deleting it broke distribution to every downstream repo that referenced its namespace. Delete the layer and chase the dead namespace out of every reference in the same pass.

**Hand-maintained count tables are gone, and so is the last-updated column.** Every row in the old kit carried a date placeholder, which is a promise to update something nobody updates. A hand-typed date is the drift generator this kit now argues against: nobody can verify it, it always reads plausible, and a stale row wearing a fresh date is worse than a stale row wearing nothing. The dates that matter live in the commit history, where they are true by construction.

**A required screenshot upload to a public image host is gone** from the work command. It was an engineering leftover. In a GTM store the deliverables it screenshots routinely render account names, contact data and unreleased campaign copy, and a host chosen because it works without an API key works without an access control too. Screenshots now go into the plan's own working directory and are referenced by relative path.

**Vendor brand names are gone from the strategist's tool reference and from the stack examples.** The categories, the selection criteria and the shortlist profiles stayed, because the shape of the requirement is the part that survives. A named shortlist reads as a recommendation however it is captioned, it goes stale as vendors get acquired and repositioned, and a comparison naming a competitor is a different kind of document from a category description.

---

## Added

**Five content roots, four root files, one config area, and no sixth root.** `.claude/` for anything the runtime loads or executes, `company-wiki/` for distilled knowledge, `clients/` for account state, `raw/` for unprocessed input bucketed by shape, `archive/` for superseded material. `raw/misc/` is the guaranteed landing zone, which is the thing that makes the no-new-roots rule survive a busy week.

**`clients/`, which the old kit had no home for.** One folder per account, holding a machine-written one-pager at `clients/<slug>/<slug>.md` plus hand-maintained operating docs beside it. The operating-state doc replaces session memory for anything that has to survive a context clear. The redundant-looking same-name is a free drift detector: an account folder missing its one-pager skipped the standard path, and whatever else that path does was skipped too.

**A rules layer at `.claude/rules/`.** Small files, each with a `paths:` glob in its frontmatter, loading only when the agent touches a matching path. A rule costs nothing while it is not loading, which makes it the cheapest rung of the enforcement ladder and the right home for anything ambiguous. Precedence is declared in both directions: the broad rule names the narrow one, and the narrow one says in its own body that it overrides the broad rule inside its scope. Precedence implied by directory depth is precedence nobody can verify.

**A counts refresher that owns every mechanical count**, at `scripts/refresh-counts.mjs`, with `--write`, `--check`, and a manifest mode that prints what it owns and what it refuses to own. Node 18 or later, zero dependencies. Every hand-maintained count in the source store drifted at once, including two contradictory numbers about forty lines apart in one file and three different totals in another. A number with no owner is a lie with a delay fuse.

The ownership line is deliberate. Counts are mechanical, so the script rewrites them silently. Categorisation is judgment, so it never guesses one: it reports the orphan, names the headings it could be filed under, and fails. A script that guessed would file things wrong quietly, and a catalog that is quietly wrong stops being read at all.

**Two CI jobs in `.github/workflows/`**, both read-only. One runs the drift check on pull requests and again on direct pushes to the default branch, and a second job in the same file clones the committed tree and runs the check from the clone. The other fires every cell of the safety matrix at the gate and prints the gate's hash. The push trigger is the one most likely to be deleted as redundant: admins hold review-gate bypass by design and nobody gives that up, so a direct push carrying a stale local copy is exactly the change the review-time check never sees.

**A tiered safety guard**, replacing the flat blocklist of tool names. Four operation classes by blast radius, four identity tiers against them, a roster file outside the script so a promotion is a one-line edit rather than an edit in every deployed copy, three approval classes with different bindings, an audit log that records allows as well as blocks, and a published not-guarded list with its reasoning. A flat blocklist is a snapshot: connectors get renamed, versioned and replaced by a successor with the same capability, and none of that produces an error. The gate keeps passing its own tests while exiting clean on the actions it was built to stop.

**A test harness for the gate**, at `.claude/hooks/safety-guard-test.sh`, which fires a payload at every cell and asserts the exit code and the message. Reading a gate proves the author's intent. Firing payloads proves the behavior, and those two diverge more often than anyone expects.

**`AGENTS.md`**, carrying only what differs by runtime: load order as pointers, the role boundary split by task type rather than by tool name, and an eight-field handoff packet. It restates no structure, because a second copy is a second thing to drift.

**`MEMORY.md`**, a memory index where each line is a reason to open a file rather than a summary of it. A line that summarizes gets read instead of the file, and the summary is the copy that goes stale.

---

## Fixed

Everything below was found by running the kit rather than by reading it. Each one shipped in a tree that looked correct.

**The gate's read allowlist could be beaten by one word.** It ran first and matched any read token anywhere in the action name, so `delete_leads_from_list` and `move_leads_to_campaign_or_list` and `find_and_delete_duplicates` all exited zero, silently, with no audit row, while their near-twins blocked. The allowlist is now vetoed whenever the same name also carries a guarded verb. The test harness fired invented names that happened to dodge the collision and reported a pass over the hole, so it fires real connector operations now.

**Most GTM writes were not guarded at all.** Create, update, edit, patch, set, add, sync and manage were missing from the verb matcher, so updating the sequence a live campaign sends, updating CRM records in bulk, and exporting contacts to an arbitrary webhook all passed unlogged. They are guarded now, scoped to connected systems so local file edits stay silent. Editing a running campaign sits in the outward class beside activating it, because it reaches the same people.

**The explicit guarded list matched the full action name only**, so the same payments write under a repackaged namespace was unguarded. It matches the operation segment as well now. The namespace is the half that rots.

**A payload the gate could not parse was treated as no action at all.** Truncated JSON, a body that is not JSON, and a payload carrying the action under a different key each produced an empty action name and an exit-zero pass with no row. All of those block now. Empty stdin is the only clean exit. That is the same failure as the prefix-scan defect the script spends ten lines warning against, wearing different clothes.

**The session modes blocked on stdin.** The gate read stdin unconditionally, so the session-start, session-end and probe modes waited for an EOF that never came. The documented verification step hung at the probe case for anyone running it at a terminal. The read is gated on the mode now.

**Every hook wiring was unquoted and invoked the script directly.** With the project at a path containing a space, the command failed at the first space and the tool call was never gated, and both stores this kit is modelled on live at a path with a space. With the executable bit dropped, by a downloaded archive or a copy step that did not preserve the mode, the command exited 126, which is a non-blocking hook error rather than the exit that blocks: the gate was off with no signal. Every hook is invoked as `bash "$CLAUDE_PROJECT_DIR/..."` now, quoted, and the executable bit is no longer load-bearing.

**The quick start deleted six files.** The rsync exclude was unanchored, so it matched every README at every depth: the root one it meant to skip, the commands guide, and all five raw bucket guides. It is anchored now, and the step that follows counts the READMEs so the class of failure is caught rather than the instance.

**The session log stopped parsing above a kilobyte.** The tool input was byte-truncated after being encoded and then interpolated raw, so most Write and Edit records were invalid JSON, and one bad line takes the whole file down because the parser aborts rather than skipping. Truncation happens inside the encoder now, and a harness case writes an oversized payload and asserts every line parses. The evidence trail is only evidence if it can be read.

**The notification hook interpolated payload text into AppleScript.** A message carrying a double quote closed the string, and everything after it ran as AppleScript in the user's own session. Values are passed as arguments now, stripped of control characters and capped. A safety kit does not ship a notifier whose input reaches an interpreter.

**The root context file named a refresher under the wrong extension in four places**, including the closing instruction of the guided setup and the rule everyone follows after adding a skill. None of those commands existed.

**The root context file taught the anchor syntax with the wrong spelling.** It gave the canonical form as `count:` singular in two places, which the script has never matched, so a number written to that spec was never rewritten and never reported. That is precisely the unowned number the whole mechanism exists to prevent. The check fails on the misspelling by name now.

**The rule index named six rules and five of the filenames did not exist.** It also invented a rule the kit does not ship and omitted the broad rule the other four declare precedence against. That is the drift the kit's own headline failure describes, reproduced inside its flagship template.

**The scheduled-checks section described a job the repo does not ship**, on a trigger that rewrites counts and opens a correction, and the README said in its exclusion list that exactly that job is deliberately absent. It now lists the two jobs that exist, on their real triggers, with the absent rung named as a decision underneath.

**The safety section was written in a retired vocabulary** that contradicted the gate shipping beside it: two blast-radius buckets where the gate implements four named classes, batch approval on the wrong tier, and two-person on the wrong cells. The section-nine matrix is now the sixteen cells the gate enforces, verified by firing a payload at each one.

**The drift check only looked at the catalog.** Every failure in the four paragraphs above sat in the root context file, and the check passed over all of them. It now runs the path-integrity scan across every root file, fails on a rule cited that is not on disk and on a rule on disk that no root file cites, and flags the misspelled anchor form. Examples that point nowhere belong inside a fenced code block, which the scan skips.

**The memory index shipped four dead links** in the same breath as saying a dead link is the one failure the index cannot survive. The examples are inside a code block now.

**The commands' stated exclusion list was narrower than the reality it discloses**, which is the failure a stated exclusion exists to prevent. It named four missing sub-commands called by one file, and a grep finds five commands and five skills across five files. The list is complete now, with the file and step that calls each, and every one of the six commands carries a skip disclosure at its head.

**The credit link in the commands guide was dead**, while the same credit in two other files pointed at the live repository. All three match now.

**A skill wrote per-author data into its own shipped reference files.** The post writer stored one author's voice profile in the universal extraction reference and one author's prohibited phrases in the shared rubric as automatic violations for everybody, which a team with three writers overwrites on the second run. Profiles go to a per-author path outside the skill now, and every customization interview is labelled as a one-time setup step run outside live work, because a skill editing itself mid-engagement is a run half-following two versions of its own instructions.

**Thirty-nine of the files were untracked.** The tree was ready to publish while the README, the catalog and the root context file all described machinery a fresh clone would not contain, and every check passed because every check ran against the working copy. Everything is committed, and the clone job in CI now runs the checks against what a cloner actually gets.
