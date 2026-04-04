<p align="center">
  <img src="https://img.shields.io/badge/Claude_Code-Ready-blueviolet?style=for-the-badge" alt="Claude Code Ready" />
  <img src="https://img.shields.io/badge/Skills-5_Included-orange?style=for-the-badge" alt="5 Skills" />
  <img src="https://img.shields.io/badge/Plugin-6_Commands-blueviolet?style=for-the-badge" alt="6 Plugin Commands" />
  <img src="https://img.shields.io/badge/Hooks-3_Production_Ready-green?style=for-the-badge" alt="3 Hooks" />
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="MIT License" />
</p>

# Company OS Starter Kit

**Build your own Company OS with Claude Code.**

We're building an AI-native GTM services company. We scaled to 20 people in under 9 months. Bootstrapped. Claude Code has become a huge part of how we operate.

This is the starter kit for building the same kind of system. The folder structure, the skills, the safety hooks, and the setup guide we wish we had when we started.

Built by [Dan Rosenthal](https://linkedin.com/in/dan-m-rosenthal) at [workflows.io](https://workflows.io). Full setup guide on [Notion](https://workflowsio.notion.site/Company-OS-Starter-Kit-33a6a857e59281a4884bd9638a991c05).

---

## What is a Company OS?

A Company OS is a set of files (primarily markdown) that gives your AI persistent knowledge about your business. Your tools, your processes, your rules, your voice, your team. Instead of re-explaining your business every conversation, Claude starts every session already knowing who you are.

At the center is `CLAUDE.md`, the one file Claude reads on load. It points to everything else: company context, skills, tool connections, safety rules. Not a prompt you paste. An operating system that compounds the more you use it.

---

## What's in the Kit

### Root

| File | What it does |
|------|-------------|
| `CLAUDE.md` | The master template. Your AI's operating system. Fill this in first. |
| `PLUGIN-GUIDE.md` | How to install the Workflows Engineering Plugin (bundled in plugin/, not an external marketplace install) |
| `LICENSE` | MIT |
| `.gitignore` | Ignores session logs, credentials, OS files, editor files |

### `blueprint/` - Your Company OS folder structure

Copy this into your project and fill it in. Claude will interview you.

| File | What it does |
|------|-------------|
| `blueprint/INDEX.md` | Content catalog template. Maps every file in your OS. |
| `blueprint/company/overview.md` | What you sell, ICP, positioning, metrics |
| `blueprint/company/team.md` | Roster, org structure, communication norms |
| `blueprint/company/accounts.md` | Key accounts + CRM connection guide |
| `blueprint/company/gtm-stack.md` | Your tools, data flow, what's working and broken |
| `blueprint/company/voice.md` | Brand voice, tone, word swaps, writing rules |
| `blueprint/company/design-system.md` | Colors, typography, visual style |
| `blueprint/wiki/outbound-playbook.md` | Outbound strategy, channels, campaign types |
| `blueprint/wiki/onboarding.md` | New hire ramp plan and resources |
| `blueprint/wiki/processes.md` | Recurring SOPs and workflows |
| `blueprint/hooks/safety-guard.sh` | Blocks dangerous tool calls (PreToolUse) |
| `blueprint/hooks/session-logger.sh` | Logs every event to per-session JSONL files |
| `blueprint/hooks/notify.sh` | macOS/Linux desktop notifications |
| `blueprint/hooks/settings.json` | Wires all hooks to lifecycle events |
| `blueprint/hooks/setup-guide.md` | Full hook documentation, customization guide |
| `blueprint/skills/guide.md` | How to add and structure skill files |
| `blueprint/archive/guide.md` | What goes in the archive folder |
| `blueprint/raw/guide.md` | How to dump and process raw inputs |

### `gtm-skills/` - 5 starter skills

| File | What it does |
|------|-------------|
| `gtm-skills/outbound-copywriter.md` | Cold email sequences using the SPARK framework |
| `gtm-skills/linkedin-post-writer.md` | LinkedIn posts in your voice with scoring rubric |
| `gtm-skills/icp-modeller.md` | Tiered ICP matrix with firmographic/psychographic/behavioral scoring |
| `gtm-skills/gtm-strategist.md` | GTM motion design, stack planning, budget allocation |
| `gtm-skills/discovery-prep.md` | Pre-call research briefs and conversation prep |
| `gtm-skills/guide.md` | How to add, customize, and create new skills |

### `plugin/` - Workflows Engineering Plugin

Bundled locally in this repo (not an external install). Copy to your project to get structured workflow commands.

| File | What it does |
|------|-------------|
| `plugin/.claude-plugin/plugin.json` | Plugin manifest |
| `plugin/commands/workflows/plan.md` | Structured implementation planning |
| `plugin/commands/workflows/work.md` | Step-by-step plan execution with QA |
| `plugin/commands/workflows/review.md` | Multi-agent code and work review |
| `plugin/commands/workflows/swarm.md` | Full pipeline with parallel agents |
| `plugin/commands/workflows/brainstorm.md` | Requirement exploration before planning |
| `plugin/commands/workflows/compound.md` | Document solved problems for team knowledge |

---

## Quick Start

<table>
<tr>
<td width="50%">

**Option A: Terminal**

```bash
# 1. Clone
git clone https://github.com/Workflowsio/company-os-starter-kit.git
cd company-os-starter-kit

# 2. Copy blueprint to your project
cp -r blueprint/ /path/to/your-project/
cp CLAUDE.md /path/to/your-project/CLAUDE.md

# 3. Copy skills
cp -r gtm-skills/ /path/to/your-project/gtm-skills/

# 4. Copy plugin (optional - adds /workflows commands)
cp -r plugin/ /path/to/your-project/.claude/plugins/company-os/

# 5. Install hooks
mkdir -p /path/to/your-project/.claude/hooks
cp blueprint/hooks/*.sh /path/to/your-project/.claude/hooks/
cp blueprint/hooks/settings.json /path/to/your-project/.claude/settings.json
chmod +x /path/to/your-project/.claude/hooks/*.sh

# 6. Open your project in Claude Code and go
```

</td>
<td width="50%">

**Option B: Just ask Claude**

Open your project in Claude Code and say:

```
Read the CLAUDE.md and all the files in this repo.
Interview me about my business and help me
fill everything in. Go section by section.
```

Claude will:
- Walk through each section of CLAUDE.md
- Ask about your company, tools, team, and processes
- Fill in every `{{placeholder}}` based on your answers
- Adapt the structure to your business type
- Suggest your first custom skill when done

No manual markdown editing required.

</td>
</tr>
</table>

---

## The 5 Skills

Skills are reusable instruction sets that tell Claude HOW to do specific tasks. Each includes frameworks, step-by-step instructions, anti-patterns, and quality checks.

| Skill | What it does | Example prompt |
|-------|-------------|----------------|
| **Outbound Copywriter** | Cold email sequences using the SPARK framework, 7 power patterns, 6 archetypes | `Write a 3-step sequence for VP Sales at mid-market SaaS` |
| **LinkedIn Post Writer** | LinkedIn posts in your voice with hook formulas, formatting rules, scoring rubric | `Write a LinkedIn post about why most outbound fails` |
| **ICP Modeller** | Tiered ICP matrix with firmographic, psychographic, and behavioral scoring | `Build an ICP for our new product targeting fintech` |
| **GTM Strategist** | GTM motion design, tool selection, channel strategy, budget allocation | `Design a GTM motion for our Series A launch` |
| **Discovery Prep** | Pre-call research briefs with pain hypotheses, talking points, objection handling | `Prep me for a call with the VP Marketing at Acme Corp` |

These five are GTM-focused starters. The skill format works for any domain. Create skills for engineering, support, finance, HR, product - whatever your team does.

---

## The Blueprint

The `blueprint/` folder is the recommended structure for your Company OS. Copy it to your project and fill it in.

| Folder | Purpose |
|--------|---------|
| `company/` | Core context that rarely changes. Identity, team, brand, stack. Start here. |
| `wiki/` | Reference docs, playbooks, SOPs. Things your team looks up. Grows over time. |
| `hooks/` | Safety guard, session logger, notifications. Set up once, forget about it. |
| `skills/` | Skill file templates. Copy starter skills from gtm-skills/ and add your own. |
| `archive/` | Completed projects, old docs. Kept for reference but not loaded by default. |
| `raw/` | Unprocessed inputs. Call transcripts, data exports, articles. Let Claude organize them into wiki/ pages. |

Start with `CLAUDE.md` + `company/overview.md`. Add more as you go. A Company OS with 5 solid files beats one with 50 scattered files.

---

## Philosophy

**Why GitHub?** Version control. Branching. Diffs. Pull requests. Your AI context should be managed with the same rigor as your code. When something breaks, you can revert. When someone joins, they clone and go.

**Why markdown?** It is the universal format. Every AI tool reads it. Every developer knows it. No vendor lock-in. No proprietary format. Move it to any system at any time.

**Why this structure?** CLAUDE.md is the hub. Brain files are the spokes. Skills are the playbooks. Hooks are the guardrails. Each piece has one job. Add what you need, skip what you don't.

**AI-agnostic.** The architecture works with Claude Code today. The files are plain markdown. If you switch tools tomorrow, the context transfers. The skills transfer. Only the hooks are Claude Code-specific.

**Multiplayer.** Share the repo with your team. Everyone gets the same context. Skills compound across sessions. Brain files stay current through commits. This is how AI context scales past one person.

---

## Credits

Built by [Dan Rosenthal](https://linkedin.com/in/dan-m-rosenthal) at [workflows.io](https://workflows.io).

The Workflows Engineering Plugin is built on top of [Compound Engineering](https://github.com/EveryInc/compound-engineering-plugin) by [EveryInc](https://github.com/EveryInc). The core workflow commands (plan, work, review, swarm, brainstorm) come from their excellent open-source foundation.

---

**[Follow me on LinkedIn](https://linkedin.com/in/dan-m-rosenthal)** for more on building with AI, GTM systems, and context engineering. I post about what we're building at workflows.io and share the frameworks behind it.

**Star this repo** if you found it useful.
