# Slash commands

Six commands live in `commands/workflows/`. They are the run loop that sits on top of the context layer: you brainstorm an approach, turn it into a plan, execute the plan, review what came out, and capture what worked so the next run starts further along.

This guide sits at `.claude/commands-guide.md`, outside the commands tree, beside `.claude/skills-guide.md` and `.claude/hooks/setup-guide.md`. Every markdown file under `.claude/commands/` is discovered as a command, so a README in there is a seventh command: the loader would see seven while every count in the store said six. The count that the drift machinery exists to make trustworthy has to match what the loader actually loads, and the cheapest way to get that is to keep the furniture out of the discovered tree rather than to write an exemption into the refresher.

| Command | What it does |
|---|---|
| `/workflows:brainstorm` | Explores a GTM strategy or business approach through dialogue before anything is committed to a plan |
| `/workflows:plan` | Turns a project description or campaign brief into a structured plan file with checkboxes and sources |
| `/workflows:work` | Executes a plan, tracking every task on the task board and shipping the deliverables |
| `/workflows:review` | Reviews a deliverable with several agents in parallel and writes the findings out as todos |
| `/workflows:compound` | Documents a win or a discovery into `docs/wins/` so the knowledge is reusable |
| `/workflows:swarm` | Runs the whole loop end to end with a swarm of parallel agents doing the execution phase |

`brainstorm`, `plan` and `compound` are useful on day one. `work`, `review` and `swarm` assume a plan file exists, so they earn their keep once the loop is running.

## Where they came from

These commands come from **[Compound Engineering](https://github.com/EveryInc/compound-engineering-plugin) by [EveryInc](https://github.com/EveryInc)**, whose plan-work-review-compound loop is the structure this kit runs on. The credit is theirs. We have run these commands for months against real GTM work, and the parts that make them good are theirs, not ours.

## What we changed, and what we did not

Changed, and nothing beyond this:

- **Terminology and examples.** Engineering vocabulary swapped for GTM vocabulary, so a plan is a campaign or an initiative rather than a feature, and a deliverable is a sequence or a brief rather than a pull request.
- **Names in examples.** Every client name and personal name in an example was replaced with a placeholder.
- **One path.** `swarm.md` used to point at agents bundled in a plugin. It now points at `.claude/agents/`, which is where agents live in this layout.
- **One disclosure line** at the top of each of the six, naming the dependencies this kit does not ship, so a run skips a step instead of dead-ending on it. The full list is at the bottom of this file.
- **One deletion.** The screenshot step in `work.md` uploaded deliverables to a public image host, which is not a thing a GTM kit should ship as a REQUIRED step. It writes to the plan's own `docs/` directory now.

Deliberately not changed: the structure. No step was removed, no phase collapsed, no task primitive downgraded. That rule exists because we broke it once. A pass over these exact six files to reword them for business use cut `swarm.md` from 147 lines to 34 and swapped the multi-agent coordination primitive in `work.md` for a single-session one. Both files still looked plausible and neither errored. The parallel execution simply stopped happening, and a manual-only flag on the gutted command kept it out of sight for four days. Terminology and examples are in scope when you adapt these for your own domain. Gates, phases, task boards and agent spawning are not.

## Plain command files, not a plugin

These are six markdown files in `.claude/commands/workflows/`. Your runtime discovers them from the repo. There is no plugin manifest, no marketplace entry and no install step beyond cloning.

We shipped a plugin wrapper once and ran it for 71 days across five direction changes before deleting it for cause: it distributed a strict subset of the skills the repo already contained, byte-identical copies of the agents, and a connector config whose entries were all already in the root config. Every artifact in it was a stale copy of something canonical, and the copies were what people actually loaded. A distribution layer only earns its keep if it distributes something the clone does not already give you, and for a repo of markdown files the clone gives you everything. One warning if you are removing a wrapper of your own: deleting it broke distribution to every downstream repo that referenced its namespace, so delete the layer and then chase the namespace out of every reference, in the same pass.

## What these commands reference and this kit does not ship

Stated so you can decide rather than discover it mid-run. This list is the full set a grep of the six files finds, with the file and step that calls each one, because a stated exclusion that is narrower than the reality it discloses is the failure it was meant to prevent. Every one of the six files carries a one-line skip disclosure at the top saying the same thing: a step whose dependency is absent gets skipped and named in the run summary rather than dead-ending the run.

**Commands from the upstream engineering pack:**

- `/deepen-plan` - `swarm.md` step 2, and `plan.md` offers it as a follow-on option and runs it automatically under ultrathink.
- `/test-browser` - `swarm.md` step 5.
- `/resolve_todo_parallel` - `swarm.md` step 6, and `review.md` offers it after a review.
- `/feature-video` - `swarm.md` step 7.
- `/technical_review` - `plan.md` offers it as a follow-on option.

Install them from the upstream project, or leave the steps skipped.

**Skills:**

- `file-todos`, holding the todo template `review.md` points at three times. Without it, review findings still get written, straight into `todos/` without a shared template. `review.md` says so at its head.
- `setup`, which `review.md` (step 1), `work.md` (phase 3) and `compound.md` offer to invoke when `workflows-engineering.local.md` is missing. That file is a project-root config listing which review agents to run. Create it by hand, or let the review fall back to general-purpose agents.
- `brainstorming` and `document-review`, which `brainstorm.md` loads for question technique and for its self-review pass, and `plan.md` loads for the refine option. Both degrade to the command's own inline instructions.
- `compound-docs`, referenced by `compound.md` for documentation structure.
- `orchestrating-swarms`, referenced by `work.md` for swarm patterns.

**Removed rather than left dangling:** `work.md` used to require `agent-browser` and `imgup` to screenshot a running dev server and upload the images to a public image host. Both were engineering leftovers, and the upload sent deliverables that routinely carry client names and unreleased copy to a third-party host nobody in the loop owns. That step now saves screenshots into the plan's own `docs/` directory and references them by relative path.

**Other:**

- **The `.claude/agents/` directory is empty.** `swarm.md` and `review.md` both prefer specialized agents and fall back to `general-purpose`, which is what will happen until you add your own.
- **A `docs/` working directory.** These commands read and write `docs/plans/`, `docs/brainstorms/`, `docs/solutions/` and `docs/wins/`. That is pipeline output rather than context, which is why it sits outside the five content roots. If you would rather it lived somewhere else, repoint it in all six files at once, because a half-renamed path here fails silently: the command writes the plan to the new location and the next command reads the old one and finds nothing.

## Adapting them for your own team

Swap the vocabulary and the examples freely. Before you cut anything, ask what the block is doing when the run is going badly rather than when it is going well, because that is when phases, gates and task boards are load-bearing. If you cannot name what a block prevents, you have not found the reason it is there yet.
