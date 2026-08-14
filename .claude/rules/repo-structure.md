---
paths:
  - "**"
---

# Repo structure

The broad rule. It owns the top level, plus the two layout invariants whose violation is invisible on inspection.

## Five content roots, and nothing else at the top

`.claude/` agent config, `company-wiki/` distilled knowledge, `clients/` one folder per account, `raw/` unprocessed input, `archive/` superseded material. Four root files beside them: `CLAUDE.md`, the catalog `INDEX.md`, the memory index `MEMORY.md`, the second-agent contract `AGENTS.md`. Then the furniture: `.github/`, `scripts/`, `.gitignore`, this repo's own `README.md` and `LICENSE`, and a connector config file if your runtime reads one from the root.

Do not add a sixth root. Anything with no obvious home goes in an existing bucket or in the landing zone at `raw/misc/`, which exists so this rule survives the week someone is in a hurry.

## A scheduled check lives where the scheduler looks

`.github/workflows/` is the only place a scheduled job is discovered. Keep the workflow file a thin stub and put its logic in `scripts/`, so a later tidy-up moves the half that is safe to move. Relocating a scheduled check produces no error, no failing check and no notification: one team ran a dead check for over three months and found it through an unrelated audit.

## Skills stay flat

`.claude/skills/<skill-name>/SKILL.md`, one level deep. A category subfolder stops the loader discovering the skill and nothing reports it. Taxonomy belongs in the filename prefix and in `INDEX.md`.

## Precedence

Inside their globs, `client-data.md`, `wiki-knowledge.md`, `skill-development.md` and `raw-input.md` override this file on what a file must contain and how it is written.

This file still decides where a file may live. None of those four can authorize a new root, a nested skill, or a scheduled check outside `.github/workflows/`.
