# CLAUDE.md -- {{company_name}} Company OS

<!-- THE CLAUDE.MD BLUEPRINT TEMPLATE
     This is the master instruction file for Claude Code. When Claude
     opens your project, this is the first thing it reads. Think of it
     as the "operating system" for your AI assistant.

     Keep this file under 200 lines. Move detailed reference material
     to .claude/rules/ or skills.

     HOW TO USE:
     1. Replace every {{placeholder}} with your real values
     2. Delete sections you don't need yet (add them later)
     3. Save as CLAUDE.md in your project root
     4. Open in Claude Code -- it loads automatically
     5. Or run /init in Claude Code to auto-generate a starter, then
        merge in sections from this template

     Created by Dan Rosenthal (workflows.io) -->


## Setup Mode (READ THIS FIRST)

<!-- INSTRUCTIONS FOR CLAUDE:
     When a user first opens this project, this file will be full of
     {{placeholders}}. DO NOT wait for them to fill these in manually.
     Instead, be interactive:

     1. When the user says "help me set up" or "walk me through this,"
        interview them section by section. Ask about their company,
        tools, team, and processes. Fill in the placeholders based on
        their answers.
     2. Adapt the structure to their business. If they are a SaaS company,
        the "Products / Services" section looks different than for a
        services company. Rename sections, add/remove rows, adjust
        examples to fit.
     3. After filling a section, read it back and ask if it looks right
        before moving on.
     4. Skip sections they aren't ready for. Mark them with
        "TODO: fill in later" so they can come back.
     5. When setup is done, suggest creating their first custom skill
        based on their most repeated task.

     The goal: the user should be able to go from clone to working
     Company OS in a single conversation, without manually editing
     any markdown. -->


## What This Is

This is the Company OS for **{{company_name}}**. It gives Claude full business context: who we are, how we operate, our tools, our processes, and our rules.

**Owner:** {{your_name}} ({{your_email}})
**Repo:** {{github_org}}/{{repo_name}} (private)
**Local path:** {{local_project_path}}

<!-- WHY: Without this, every session starts from zero.
     With it, Claude has persistent identity. -->

---


## Company Identity

**Company:** {{company_name}}
**What we do:** {{one_line_description}}
**Industry:** {{industry}}
**Stage:** {{company_stage}} <!-- e.g. Pre-revenue, Seed, Series A, $2M ARR, etc. -->
**Team size:** {{team_size}}

### Mission
{{company_mission}}

### Core Values
<!-- These shape HOW Claude communicates and makes decisions on your behalf -->
- {{value_1}}
- {{value_2}}
- {{value_3}}

### Key People
<!-- Claude uses this to understand org context, route decisions, and personalize communication -->

| Name | Role | Notes |
|------|------|-------|
| {{your_name}} | {{your_role}} | Primary operator. All Claude actions serve this person. |
| {{person_2_name}} | {{person_2_role}} | {{person_2_notes}} |
| {{person_3_name}} | {{person_3_role}} | {{person_3_notes}} |

<!-- WHY: A 5-person SaaS startup gets different outputs than a 200-person
     services company. Team context prevents Claude from suggesting you
     "ask your marketing team" when you ARE the marketing team. -->

---


## Products / Services / What We Do

<!-- List your core offerings, products, or business functions.
     Claude uses this to understand scope and generate relevant work. -->

### {{product_or_service_1}}
{{brief_description_1}}

### {{product_or_service_2}}
{{brief_description_2}}

### {{product_or_service_3}}
{{brief_description_3}}

<!-- EXAMPLES:
     SaaS: "Core Platform", "Enterprise Add-on", "API / Integrations"
     Services: "Strategy Consulting", "Implementation", "Managed Services"
     Marketplace: "Buyer Experience", "Seller Tools", "Payments" -->

---


## Behavior Rules

<!-- This is the personality layer. It controls Claude's tone,
     initiative level, and communication style across every interaction. -->

- **Tone:** {{communication_style}}
  <!-- e.g. "Direct, concise, no filler. Professional but not corporate." -->
- **Initiative:** Take action within safe boundaries. Ask only when genuinely stuck or when the action is irreversible.
- **No sycophantic filler.** Skip "Great question!" and "Absolutely!" -- just do the work.
- **Session startup:** At the start of every session, mentally load context from brain files before taking action.
- **Writing rules:**
  - {{writing_rule_1}} <!-- e.g. "No em dashes. Use commas, periods, or parentheses." -->
  - {{writing_rule_2}} <!-- e.g. "Avoid: leverage, utilize, streamline, comprehensive, robust" -->
  - {{writing_rule_3}} <!-- e.g. "Short sentences. Active voice. Write like a human." -->
- **When updating context:** Always evaluate whether a change should update brain files, and commit changes after updating.

<!-- WHY: Without these, Claude defaults to generic assistant mode.
     These rules make it YOUR assistant, not a random chatbot. -->

---


## Safety Guard (CRITICAL)

<!-- Actions Claude must NEVER take without explicit approval.
     IMPLEMENTATION: Claude Code supports PreToolUse hooks that block
     tool calls before they execute. See /hooks in this starter kit. -->

**When a tool call would be blocked:**
1. Tell {{your_name}} exactly what you were about to do (recipient, content, target system)
2. Ask for explicit approval
3. Only retry after confirmation
4. NEVER circumvent the guard (e.g., using Bash to call an API directly instead of the blocked MCP tool)

### Blocked Categories

<!-- Uncomment and customize the categories that apply to your business.
     Add new categories as you connect new tools. -->

1. **External messaging** -- Never send emails, Slack messages, or DMs without approval
   <!-- Covers: Gmail drafts/sends, Slack post/reply, LinkedIn messages, etc. -->

2. **Financial operations** -- Never create invoices, process payments, or modify billing
   <!-- Covers: Stripe, QuickBooks, payment links, subscription changes -->

3. **Destructive deletes** -- Never delete records, campaigns, contacts, or accounts
   <!-- Covers: CRM record deletion, campaign deletion, list deletion -->

4. **Database mutations** -- Never run raw SQL, apply migrations, or modify schemas
   <!-- Covers: Supabase, Postgres, any direct DB access -->

5. **Git push / deploy** -- Never push to remote, merge PRs, or trigger deployments
   <!-- Covers: git push, gh pr merge, deploy commands -->

6. **Calendar mutations** -- Never create, delete, or modify calendar events
   <!-- Covers: Google Calendar, Calendly, any scheduling tool -->

<!-- WHY: Claude can take real actions -- send emails, post to Slack,
     modify databases, push code. Without guardrails, a misunderstood
     instruction could message a client or delete production data. -->

---


## Tool Ecosystem

<!-- Declare every tool Claude has access to and how they connect.
     This is the "wiring diagram" of your business.
     Claude uses this to understand what's possible and route actions correctly. -->

### Core Tools

| Tool | Purpose | How We Use It |
|------|---------|---------------|
| {{tool_1}} | {{purpose_1}} | {{usage_1}} |
| {{tool_2}} | {{purpose_2}} | {{usage_2}} |
| {{tool_3}} | {{purpose_3}} | {{usage_3}} |
| {{tool_4}} | {{purpose_4}} | {{usage_4}} |

<!-- EXAMPLES:
     SaaS: GitHub (code), Linear (PM), Vercel (hosting), PostHog (analytics), Stripe (billing)
     Sales-led: HubSpot (CRM), Outreach (sequences), Gong (calls), Slack (comms)
     Ops-heavy: Notion (docs), n8n (automation), Airtable (data), Zapier (integrations) -->

### How Tools Connect (Data Flow)

<!-- Describe the key data flows between your tools.
     This helps Claude understand cause and effect across systems. -->

```
{{source_tool}} -> {{middle_tool}} -> {{destination_tool}}
```

<!-- EXAMPLE:
     Clay (enrich) -> Instantly (send campaigns) -> HubSpot (track replies)
     Tally (form submission) -> n8n (automation) -> Slack (notification) + Airtable (record)
     GitHub (PR merged) -> Vercel (deploy) -> Slack (notification) -->

---


## MCP Server Registry

<!-- MCP (Model Context Protocol) servers give Claude direct access to your tools.
     This registry tells Claude what's connected and what each server does.

     TYPE GUIDE:
     - stdio: Runs locally on your machine (e.g., GitHub CLI, local tools)
     - HTTP: Connects to a remote API endpoint
     - HTTP/OAuth: Remote API with OAuth authentication

     SETUP: MCP servers are configured in your Claude Code settings.
     See https://docs.anthropic.com/en/docs/claude-code for setup instructions. -->

| MCP Server | Type | Purpose |
|------------|------|---------|
| github | stdio | Repository management, PRs, issues, code search |
| {{mcp_server_2}} | {{type_2}} | {{purpose_2}} |
| {{mcp_server_3}} | {{type_3}} | {{purpose_3}} |
| {{mcp_server_4}} | {{type_4}} | {{purpose_4}} |

<!-- COMMON SERVERS: slack, notion, airtable, n8n, firecrawl, exa,
     supabase, stripe, browserbase, apollo, pinecone.
     Full list: https://github.com/modelcontextprotocol/servers -->

<!-- WHY: Claude can only use tools it knows about. This registry acts
     as a capability menu. Without it, Claude guesses or asks. -->

---


## Skill Routing Table

<!-- Skills are reusable instruction sets that tell Claude HOW to do
     specific tasks. Each skill is a SKILL.md file that contains
     step-by-step instructions, quality criteria, and examples.

     This table maps user intents to the right skill file.
     When you say "write a cold email," Claude looks up the skill
     and follows its specific playbook instead of winging it. -->

| User Intent | Skill File | Description |
|-------------|-----------|-------------|
| "Write a cold email" | skills/outbound-copywriter.md | Cold email sequences using the SPARK framework |
| "Draft a LinkedIn post" | skills/linkedin-post-writer.md | LinkedIn content in your brand voice |
| "Build an ICP" | skills/icp-modeller.md | Ideal Customer Profile with scoring criteria |
| "Design our GTM motion" | skills/gtm-strategist.md | Go-to-market strategy and channel planning |
| "Prep me for a call" | skills/discovery-prep.md | Pre-call research briefs and conversation starters |
| {{intent_6}} | {{skill_path_6}} | {{skill_description_6}} |

<!-- HOW TO CREATE A SKILL:
     1. Create a .md file in skills/ (e.g., skills/my-new-skill.md)
     2. Include: trigger conditions, steps, quality criteria, examples
     3. Add it to this routing table so Claude knows when to use it
     4. Or just ask Claude: "Help me create a skill for [your task]"

     WHY: Without skills, Claude reinvents its approach every session.
     With skills, it follows your proven playbooks consistently. -->

---


## Brain File Structure

<!-- This is the map of all context files in your Company OS.
     Claude reads this to know WHERE information lives.

     PRINCIPLE: Claude's context window is large but not infinite.
     Instead of putting everything in CLAUDE.md, spread context
     across focused files. CLAUDE.md points to them. Claude reads
     what it needs, when it needs it. -->

Keep it simple. Start with CLAUDE.md and company/overview.md. Add more as you go. You can always create new folders, but we recommend this structure as a starting point.

```
company-os/
├── CLAUDE.md              # This file (the hub)
├── INDEX.md               # Content catalog
├── company/               # Core context + brand + guides
│   ├── overview.md
│   ├── team.md
│   ├── accounts.md
│   ├── gtm-stack.md
│   ├── voice.md
│   └── design-system.md
├── wiki/                  # Reference, playbooks, SOPs, deep-dives
├── skills/                # AI skill definitions
├── archive/               # Completed projects, historical docs
└── raw/                   # Input sources (transcripts, exports)
```

<!-- TIPS: One topic per file. Use ## headings for scannability.
     Keep files under 500 lines.
     WHY: Claude uses this as a directory to find context on demand. -->

### Importing Other Files

You can reference other files directly in CLAUDE.md using the `@path/to/file` syntax. Claude will read the referenced file when it loads this one. Example:

```
@company/overview.md
@company/voice.md
```

This keeps CLAUDE.md lean while still pulling in key context at load time.

### Path-Specific Rules

Use `.claude/rules/` for rules that only apply to certain file types or directories. For example, a rule that only fires when editing Python files or working inside a specific folder. Each rule file can include a frontmatter `globs` field to scope it.

```
.claude/rules/
├── python-style.md       # globs: "*.py" -- Python coding standards
├── frontend.md           # globs: "src/components/**" -- React conventions
└── testing.md            # globs: "tests/**" -- Test patterns
```

---


## Update Routing Rules

<!-- If you maintain multiple context repos (e.g., personal + company),
     these rules tell Claude where to save new information.

     SINGLE REPO: If you only have one repo, simplify this to:
     "All updates go in this repo. Commit after every meaningful change." -->

### What Goes Where

**Update this repo when:**
- Company processes, SOPs, or workflows change
- Tool configurations or integrations are added/modified
- Customer or account changes (new customer, churn, status shift)
- Team structure changes
- Brand guidelines evolve
- New skills or playbooks are created

**Never put in this repo:**
- Personal credentials or API keys (use environment variables or a secrets manager)
- Personal opinions about specific people
- Anything you wouldn't want a team member to see

<!-- ADVANCED: Dual-Brain Architecture
     Some founders maintain two repos:
     1. Personal Brain - private context, credentials index, relationship notes,
        personal goals, daily routines
     2. Company OS (this repo) - team-safe company context, shared playbooks,
        brand guidelines, skills

     This separation lets you share Company OS with your team while
     keeping personal context private. Claude routes updates to the
     right repo based on these rules. -->

---


## Credentials and Secrets

<!-- NEVER put actual API keys, passwords, or tokens in this file.
     This section is an INDEX that tells Claude where to find credentials
     when it needs them. -->

| Service | Where Stored | Notes |
|---------|-------------|-------|
| {{service_1}} | Environment variable: `{{ENV_VAR_1}}` | {{notes_1}} |
| {{service_2}} | {{secrets_manager}} | {{notes_2}} |
| {{service_3}} | MCP server handles auth | No manual credential needed |

<!-- OPTIONS: env vars (~/.zshrc), external creds file (~/.company-creds),
     secrets manager (1Password CLI, Doppler), or let MCP handle auth. -->

---


## Optional: RAG / Vector Search

<!-- For 50+ files, index your .md files in a vector database (Pinecone,
     Weaviate, Chroma) for semantic search. Chunk by ## headings.
     Claude can then search the index when it needs context that isn't
     in immediately loaded files. Delete this section if not using RAG. -->

---


## Quick Start Checklist

<!-- Use this to track your Company OS setup progress.
     Delete this section once you're fully operational. -->

- [ ] Run interactive setup: "Help me set up my Company OS. Walk me through each section."
- [ ] Create company/overview.md with your company background
- [ ] Create company/voice.md with your writing style guidelines
- [ ] Set up at least one MCP server (GitHub is the easiest starting point)
- [ ] Create your first custom skill in skills/ (pick your most repeated task)
- [ ] Add your safety guard rules for any connected tools
- [ ] Test: ask Claude "What do you know about us?" and verify it answers correctly
- [ ] Iterate: add more context files as you notice gaps

<!-- Every skill, process, and connection you add makes Claude more
     capable. Ship v1 today. Improve it every week. -->
