---
paths:
  - ".claude/skills/**"
---

# Skill development

One folder per skill, one `SKILL.md` inside it, flat at `.claude/skills/<skill-name>/`. No category subfolders, no routers, no second copy anywhere. Nesting by service line reads well and silently stops the skill loading, and the silence is what makes it expensive.

Taxonomy goes in the filename prefix (`outbound-`, `content-`, `abm-`) and in `INDEX.md`, which is the only list of skills in the store.

## Frontmatter

`name` and `description`, and nothing else unless it genuinely differs for this skill. The description is a router, not a summary: what the skill does, the systems and artifacts it touches, the literal phrases that should invoke it, and a negative clause naming the sibling it must not be confused with. Once you have twenty skills, collision is the failure mode, not absence. Descriptions stay resident in every session, so keep them tight.

## Before committing

- Run it on a real scenario, end to end. The first real run is what produces the defect list, and the fixes that hold are structural rather than another instruction.
- Check that every reference file the skill routes to exists. An index pointing at files that were never written dead-ends the model on step one.
- File its catalog entry in `INDEX.md` yourself. The counts refresher rewrites counts and will never invent a category.
- State the skill's own maturity in the body if it has not been run for real yet.

## Never modify a skill during live client work

Change it before the engagement or after it. A skill edited mid-run changes the rules underneath the work already delivered, and nobody can tell afterwards which version produced what.

## Precedence

Inside `.claude/skills/**` this file overrides `repo-structure.md` on everything about a skill's contents. The two must agree on layout; where they read differently, `repo-structure.md` wins, since the flat rule protects the loader and this file only describes it.
