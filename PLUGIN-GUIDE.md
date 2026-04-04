# Workflows Engineering Plugin

Structured workflow commands for Claude Code. Included in this starter kit.

---

## What is it?

A plugin that adds structured commands for planning, building, and reviewing work. Instead of ad-hoc prompting, you get a repeatable pipeline: plan, execute, review.

Built on top of [**Compound Engineering**](https://github.com/EveryInc/compound-engineering-plugin) by EveryInc. We took their excellent foundation and made improvements:

**What we changed:**
- Updated tool references to match current Claude Code capabilities (subagents, hooks, skills)
- Added the `/workflows:swarm` command for parallel multi-agent execution
- Improved plan deepening with parallel research agents
- Removed deprecated tool calls and outdated patterns
- Adapted prompts for non-engineering use cases (GTM, content, ops)

The core workflow (plan, work, review, brainstorm, compound) is inherited from Compound Engineering. Credit to that team for building something genuinely useful.

---

## What You Get

| Command | What it does |
|---------|-------------|
| `/workflows:plan` | Turns a description into a structured implementation plan |
| `/workflows:work` | Executes a plan step by step with QA checks |
| `/workflows:review` | Multi-agent review (architecture, security, performance, simplicity) |
| `/workflows:swarm` | Full pipeline in one command with 5-20 parallel agents |
| `/workflows:brainstorm` | Explore requirements before committing to a plan |
| `/workflows:compound` | Document a solved problem for team knowledge |

---

## Installation

The plugin is included in this starter kit under `plugin/`. To install it:

**Option 1: Copy to your project**
```bash
cp -r plugin/ your-company-os/.claude/plugins/company-os/
```

**Option 2: Ask Claude**
```
Copy the plugin from the starter kit into my project
and set it up so the /workflows commands work.
```

Agent swarms (`/workflows:swarm`) work best on the **Claude Max plan** due to parallel token usage. On lower plans, use `/workflows:plan` then `/workflows:work` sequentially.

---

## Your First Workflow

**Plan:**
```
/workflows:plan "Build a cold email campaign targeting VP Sales at Series B SaaS"
```

**Execute:**
```
/workflows:work
```

**Review (optional):**
```
/workflows:review
```

**Or do it all at once:**
```
/workflows:swarm "Build a cold email campaign targeting VP Sales at Series B SaaS"
```

---

## Quick Reference

| I want to... | Run this |
|--------------|----------|
| Plan a feature | `/workflows:plan "description"` |
| Execute a plan | `/workflows:work` |
| Review code | `/workflows:review` |
| Do everything at once | `/workflows:swarm "description"` |
| Think before planning | `/workflows:brainstorm "topic"` |
| Document a solution | `/workflows:compound` |
