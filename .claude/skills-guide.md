# Skills

A skill is a playbook the agent loads when the work matches it. It turns an SOP you would otherwise re-explain into something the agent executes the same way every time.

This guide covers `.claude/skills/`. The rest of the agent config: `.claude/rules/` path-scoped rules, `.claude/commands/workflows/` slash commands, `.claude/hooks/` gates and logging (see `hooks/setup-guide.md`), `.claude/agents/` subagent definitions, `.claude/memory/` the topic files that `MEMORY.md` indexes, `.claude/settings.json` wiring.

## Layout: flat, one folder per skill

```
.claude/skills/
  outbound-copywriter/SKILL.md
  linkedin-post-writer/SKILL.md
  icp-modeller/SKILL.md
  gtm-strategist/SKILL.md
  discovery-prep/SKILL.md
```

The loader discovers skills one level under `.claude/skills/` and no deeper. Group them into `outbound/` and `content/` folders and they stop loading, with no error and no warning: the agent simply behaves as though the skill was never written, and you find out weeks later from output that ignored a playbook you thought was live. This is the single most re-litigated rule in the kit, because a nested tree reads better than a flat one right up until it silently costs you the library.

Taxonomy still exists. It lives in the filename prefix (`outbound-copywriter`, `content-linkedin-drafter`, `abm-signal-router`) and in `INDEX.md`, which is the only list of skills in the store. One list, so there is only one thing to keep true.

A skill folder can hold more than `SKILL.md`. Reference files, templates and scripts belong beside it and get routed to from the body.

## Anatomy of a SKILL.md

```markdown
---
name: outbound-copywriter
description: Write cold email sequences and campaign copy [...] Fires on
  "write a cold email", "draft a sequence for". NOT LinkedIn or social copy,
  that is linkedin-post-writer.
---

# Outbound Copywriter

[the playbook itself]
```

Frontmatter is `name` and `description`, and nothing else unless it genuinely differs for this skill.

The description is a router, not a summary. Four things belong in it: what the skill does, the systems and artifacts it touches, the literal phrases that should invoke it, and a negative clause naming the sibling it must not be confused with. Once you have twenty skills, collision is the failure mode rather than absence, and the negative clause is what resolves it. Descriptions stay resident in every session, so they are the one place to be brief.

The body is where length is allowed, but density beats length. A short skill with one governing rule, a decision tree with a named default, a table of traps and a list of things never to do outperforms a long linear procedure. Route to reference files with a three-column table: file, what it contains, when to read it. The third column is the one novices leave out, and without it the model reads everything or nothing.

## Adding a skill

1. Create `.claude/skills/<skill-name>/SKILL.md`. Flat, no category folder.
2. Write the frontmatter router first. If you cannot state what it is NOT, you probably have two skills or a duplicate of one you already have.
3. Write the body. Every "never" in it should trace to something that actually went wrong once.
4. Run it on a real scenario, end to end, before committing. The first real run is what produces the defect list, and the fixes that hold are structural rather than another paragraph of instruction.
5. Check that every reference file the body points to exists.
6. Add the row to `INDEX.md` yourself. The counts refresher rewrites counts and will never invent a category, so an uncatalogued skill fails the check instead of being filed wrong quietly.

Or ask the agent:

```
Read .claude/skills/outbound-copywriter/SKILL.md for the house pattern,
then help me write a new skill for [the workflow you repeat].
Interview me first. Do not write the file until we agree on the router line.
```

## Rules that are not negotiable

- **Never modify a skill during live client work.** Change it before the engagement or after it. A skill edited mid-run changes the rules underneath work already delivered.
- **Never keep a second copy of a skill.** If two places need it, symlink or generate it. Two hand-maintained copies diverge, and then neither one is authoritative.
- **State the skill's maturity in the body** if it has not been run for real yet. An honest "not yet run end to end, expect edge cases" is worth more than polish.

Full rule: `.claude/rules/skill-development.md`, which loads automatically whenever an agent touches this tree.

## The five that ship with the kit

They are templates, not finished skills. Each one opens with a customization interview: point the agent at it and say "read this skill and adapt it to my business". They cover cold email copy, LinkedIn posts, ICP modelling, GTM motion design and pre-call prep. The format works for any domain, so the fastest path to your sixth skill is your most repeated task, not another GTM one.
