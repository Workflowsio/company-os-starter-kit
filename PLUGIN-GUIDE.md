# Workflows Engineering Plugin

How to install and use the structured workflow commands for Claude Code.

---

## What is it?

A plugin that adds structured commands for planning, building, and reviewing work. Instead of ad-hoc prompting, you get a repeatable pipeline: plan, execute, review.

Built on top of [**Compound Engineering**](https://github.com/EveryInc/compound-engineering-plugin) by EveryInc. Huge credit to that team for the foundation. We adapted it for GTM use cases and added the swarm command for parallel execution.

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

```
/install-marketplace Workflowsio/company-os
```

That's it. The commands are available immediately.

Agent swarms (`/workflows:swarm`) work best on the **Claude Max plan** due to parallel token usage. On lower plans, use `/workflows:plan` then `/workflows:work` sequentially.

---

## Your First Workflow

**Plan:**
```
/workflows:plan "Build a cold email campaign targeting VP Sales at Series B SaaS"
```

Claude researches your project, designs a plan, and presents it for approval.

**Execute:**
```
/workflows:work
```

Picks up the plan and builds it phase by phase.

**Review (optional):**
```
/workflows:review
```

Spawns review agents for architecture, security, performance, and simplicity.

**Or do it all at once:**
```
/workflows:swarm "Build a cold email campaign targeting VP Sales at Series B SaaS"
```

Runs plan, deepen, work, review in sequence. Parallelizes where possible.

---

## When to Use Swarms

Use `/workflows:swarm` for complex tasks that touch multiple files or systems. Campaign launches, content batches, large refactors, multi-step builds.

Don't use swarms for small changes (single file fix, config update) or tasks that are inherently sequential. Just use `/workflows:plan` + `/workflows:work` instead.

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
