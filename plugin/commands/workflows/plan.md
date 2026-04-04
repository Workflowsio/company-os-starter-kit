---
name: workflows:plan
description: Transform project descriptions into well-structured project plans following conventions
argument-hint: "[project description, campaign brief, or initiative idea]"
---

# Create a plan for a new project or initiative

## Introduction

**Note: The current year is 2026.** Use this when dating plans and searching for recent documentation.

Transform project descriptions, campaign briefs, or initiative ideas into well-structured markdown plans that follow project conventions and best practices. This command provides flexible detail levels to match your needs.

## Project Description

<feature_description> #$ARGUMENTS </feature_description>

**If the project description above is empty, ask the user:** "What would you like to plan? Please describe the project, campaign, initiative, or improvement you have in mind."

Do not proceed until you have a clear project description from the user.

### 0. Idea Refinement

**Check for brainstorm output first:**

Before asking questions, look for recent brainstorm documents in `docs/brainstorms/` that match this project:

```bash
ls -la docs/brainstorms/*.md 2>/dev/null | head -10
```

**Relevance criteria:** A brainstorm is relevant if:
- The topic (from filename or YAML frontmatter) semantically matches the project description
- Created within the last 14 days
- If multiple candidates match, use the most recent one

**If a relevant brainstorm exists:**
1. Read the brainstorm document **thoroughly** - every section matters
2. Announce: "Found brainstorm from [date]: [topic]. Using as foundation for planning."
3. Extract and carry forward **ALL** of the following into the plan:
   - Key decisions and their rationale
   - Chosen approach and why alternatives were rejected
   - Constraints and requirements discovered during brainstorming
   - Open questions (flag these for resolution during planning)
   - Success criteria and scope boundaries
   - Any specific tool choices, targeting decisions, or channel strategies discussed
4. **Skip the idea refinement questions below** - the brainstorm already answered WHAT to build
5. Use brainstorm content as the **primary input** to research and planning phases
6. **Critical: The brainstorm is the origin document.** Throughout the plan, reference specific decisions with `(see brainstorm: docs/brainstorms/<filename>)` when carrying forward conclusions. Do not paraphrase decisions in a way that loses their original context - link back to the source.
7. **Do not omit brainstorm content** - if the brainstorm discussed it, the plan must address it (even if briefly). Scan each brainstorm section before finalizing the plan to verify nothing was dropped.

**If multiple brainstorms could match:**
Use **AskUserQuestion tool** to ask which brainstorm to use, or whether to proceed without one.

**If no brainstorm found (or not relevant), run idea refinement:**

Refine the idea through collaborative dialogue using the **AskUserQuestion tool**:

- Ask questions one at a time to understand the idea fully
- Prefer multiple choice questions when natural options exist
- Focus on understanding: purpose, target audience, constraints, timeline, and success criteria
- Continue until the idea is clear OR user says "proceed"

**Gather signals for research decision.** During refinement, note:

- **User's familiarity**: Do they know the domain well? Are they pointing to examples or prior campaigns?
- **User's intent**: Speed vs thoroughness? Exploration vs execution?
- **Topic risk**: High-spend campaigns, client-facing deliverables, or external outreach warrant more caution
- **Uncertainty level**: Is the approach clear or open-ended?

**Skip option:** If the project description is already detailed, offer:
"Your description is clear. Should I proceed with research, or would you like to refine it further?"

## Main Tasks

### 1. Local Research (Always Runs - Parallel)

<thinking>
First, I need to understand the project's conventions, existing patterns, and any documented learnings. This is fast and local - it informs whether external research is needed.
</thinking>

Run these agents **in parallel** to gather local context:

- Task repo-research-analyst(project_description)
- Task learnings-researcher(project_description)

**What to look for:**
- **Repo research:** existing playbooks, CLAUDE.md guidance, past campaign structures, tool preferences, channel strategies
- **Learnings:** documented solutions in `docs/solutions/` that might apply (gotchas, patterns, lessons learned)

These findings inform the next step.

### 1.5. Research Decision

Based on signals from Step 0 and findings from Step 1, decide on external research.

**High-risk topics - always research.** Client-facing campaigns, high-budget programs, new market entry, unfamiliar verticals. The cost of missing something is too high. This takes precedence over speed signals.

**Strong local context - skip external research.** Playbooks cover this pattern, CLAUDE.md has guidance, user knows what they want. External research adds little value.

**Uncertainty or unfamiliar territory - research.** User is exploring, no prior examples exist, new tool or channel. External perspective is valuable.

**Announce the decision and proceed.** Brief explanation, then continue. User can redirect if needed.

Examples:
- "Your playbooks have solid templates for this campaign type. Proceeding without external research."
- "This involves a new vertical we haven't targeted before, so I'll research ICP patterns and messaging first."

### 1.5b. External Research (Conditional)

**Only run if Step 1.5 indicates external research is valuable.**

Run these agents in parallel:

- Task best-practices-researcher(project_description)
- Task market-context-researcher(project_description)

### 1.6. Consolidate Research

After all research steps complete, consolidate findings:

- Document relevant file paths from repo research (e.g., `playbooks/outbound-sop.md`, `skills/campaign-ops/`)
- **Include relevant institutional learnings** from `docs/solutions/` (key insights, gotchas to avoid)
- Note external documentation URLs and best practices (if external research was done)
- List related past projects or campaigns discovered
- Capture CLAUDE.md conventions

**Optional validation:** Briefly summarize findings and ask if anything looks off or missing before proceeding to planning.

### 2. Project Planning & Structure

<thinking>
Think like a project lead - what would make this plan clear and actionable? Consider multiple perspectives: execution team, client stakeholders, leadership.
</thinking>

**Title & Categorization:**

- [ ] Draft clear, searchable plan title using conventional format (e.g., `campaign: Q2 Outbound for FinTech`, `initiative: Content Calendar Redesign`)
- [ ] Determine project type: campaign, initiative, research, onboarding, automation, content
- [ ] Convert title to filename: add today's date prefix, strip prefix colon, kebab-case, add `-plan` suffix
  - Example: `campaign: Q2 Outbound for FinTech` - `2026-01-21-campaign-q2-outbound-fintech-plan.md`
  - Keep it descriptive (3-5 words after prefix) so plans are findable by context

**Stakeholder Analysis:**

- [ ] Identify who will be affected by this project (clients, team members, prospects, partners)
- [ ] Consider execution complexity and required expertise

**Content Planning:**

- [ ] Choose appropriate detail level based on project complexity and audience
- [ ] List all necessary sections for the chosen template
- [ ] Gather supporting materials (campaign data, audience research, benchmarks, prior results)
- [ ] Prepare examples or reference materials if applicable, name specific deliverables in the lists

### 3. SpecFlow Analysis

After planning the project structure, run SpecFlow Analyzer to validate and refine the project specification:

- Task workflows-engineering:workflow:spec-flow-analyzer(project_description, research_findings)

**SpecFlow Analyzer Output:**

- [ ] Review SpecFlow analysis results
- [ ] Incorporate any identified gaps or edge cases into the plan
- [ ] Update success criteria based on SpecFlow findings

### 4. Choose Detail Level

Select the detail level for your plan. Simpler is mostly better.

#### MINIMAL (Quick Plan)

**Best for:** Simple campaigns, small improvements, clear initiatives

**Includes:**

- Problem statement or project description
- Basic success criteria
- Essential context only

**Structure:**

````markdown
---
title: [Plan Title]
type: [campaign|initiative|research|onboarding|automation|content]
status: active
date: YYYY-MM-DD
origin: docs/brainstorms/YYYY-MM-DD-<topic>-brainstorm.md  # if originated from brainstorm, otherwise omit
---

# [Plan Title]

[Brief project description]

## Success Criteria

- [ ] Core outcome 1
- [ ] Core outcome 2

## Context

[Any critical information]

## MVP Deliverables

### audience-list.csv

- Target: VP Sales at Series B+ SaaS companies
- Source: Apollo + Clay enrichment
- Expected volume: 500 contacts

## Sources

- **Origin brainstorm:** [docs/brainstorms/YYYY-MM-DD-<topic>-brainstorm.md](path) - include if plan originated from a brainstorm
- Related project: [project reference]
- Documentation: [relevant_docs_url]
````

#### STANDARD (Most Projects)

**Best for:** Most campaigns, cross-team initiatives, client projects

**Includes everything from MINIMAL plus:**

- Detailed background and motivation
- Project considerations
- Success metrics
- Dependencies and risks
- Execution approach

**Structure:**

```markdown
---
title: [Plan Title]
type: [campaign|initiative|research|onboarding|automation|content]
status: active
date: YYYY-MM-DD
origin: docs/brainstorms/YYYY-MM-DD-<topic>-brainstorm.md  # if originated from brainstorm, otherwise omit
---

# [Plan Title]

## Overview

[Full description]

## Problem Statement / Motivation

[Why this matters]

## Proposed Approach

[High-level strategy]

## Project Considerations

- Target audience and segmentation
- Channel and tool selection
- Timeline and resource constraints

## Cross-Functional Impact

- **Downstream effects**: [What teams, workflows, or systems does this touch?]
- **Data dependencies**: [What data sources are needed? Are they reliable and up to date?]
- **Failure modes**: [What happens if a key step fails? Can partial execution cause confusion?]
- **Parallel workstreams**: [What other active projects overlap with this scope?]
- **Handoff points**: [Where does ownership transfer between people or teams?]

## Success Criteria

- [ ] Detailed outcome 1
- [ ] Detailed outcome 2
- [ ] Measurement requirements

## Success Metrics

[How we measure success - KPIs, benchmarks, targets]

## Dependencies & Risks

[What could block or complicate this]

## Sources & References

- **Origin brainstorm:** [docs/brainstorms/YYYY-MM-DD-<topic>-brainstorm.md](path) - include if plan originated from a brainstorm
- Similar projects: [reference path or link]
- Best practices: [documentation_url]
- Related campaigns: [campaign reference]
```

#### DETAILED (Major Initiatives)

**Best for:** Major programs, multi-month campaigns, new service launches, complex integrations

**Includes everything from STANDARD plus:**

- Detailed execution plan with phases
- Alternative approaches considered
- Detailed project specifications
- Resource requirements and timeline
- Future considerations and extensibility
- Risk mitigation strategies
- Documentation requirements

**Structure:**

```markdown
---
title: [Plan Title]
type: [campaign|initiative|research|onboarding|automation|content]
status: active
date: YYYY-MM-DD
origin: docs/brainstorms/YYYY-MM-DD-<topic>-brainstorm.md  # if originated from brainstorm, otherwise omit
---

# [Plan Title]

## Overview

[Executive summary]

## Problem Statement

[Detailed problem analysis]

## Proposed Approach

[Full strategy design]

## Project Architecture

### Strategy

[Detailed approach - audience, channels, messaging, tools]

### Execution Phases

#### Phase 1: [Foundation & Setup]

- Deliverables and owners
- Success criteria
- Estimated effort

#### Phase 2: [Core Execution]

- Deliverables and owners
- Success criteria
- Estimated effort

#### Phase 3: [Optimization & Scale]

- Deliverables and owners
- Success criteria
- Estimated effort

## Alternative Approaches Considered

[Other strategies evaluated and why rejected]

## Cross-Functional Impact

### Downstream Effects

[Map the chain reaction: what teams, tools, workflows, and processes are affected when this project launches? Trace at least two levels deep. Document: "Launching X changes Y, which affects Z, which requires updating W."]

### Data & Integration Dependencies

[Trace data flows end to end. List specific sources, enrichment steps, and destinations. Identify sync conflicts, stale data risks, and missing integrations.]

### Failure Modes & Recovery

[Walk through each critical step. Can partial execution create confusion, send wrong messages, or leave incomplete states? Document fallback plans or their absence.]

### Parallel Workstreams

[List all active projects that touch the same audience, tools, or team members. Note which need coordination and which share resources.]

### Handoff Points

[Document every point where ownership transfers between people or teams. Include expected format, timeline, and escalation path.]

## Success Criteria

### Primary Outcomes

- [ ] Detailed outcome criteria

### Operational Requirements

- [ ] Performance targets (response rates, conversion, pipeline generated)
- [ ] Quality standards (messaging consistency, brand alignment)
- [ ] Compliance requirements (opt-out rates, deliverability thresholds)

### Quality Gates

- [ ] Review and approval requirements
- [ ] Testing and QA checkpoints
- [ ] Stakeholder sign-off

## Success Metrics

[Detailed KPIs and measurement methods]

## Dependencies & Prerequisites

[Detailed dependency analysis]

## Risk Analysis & Mitigation

[Full risk assessment]

## Resource Requirements

[Team, time, tools, budget needs]

## Future Considerations

[Extensibility and long-term vision]

## Documentation Plan

[What docs, playbooks, or SOPs need creating or updating]

## Sources & References

### Origin

- **Brainstorm document:** [docs/brainstorms/YYYY-MM-DD-<topic>-brainstorm.md](path) - include if plan originated from a brainstorm. Key decisions carried forward: [list 2-3 major decisions from brainstorm]

### Internal References

- Related playbooks: [file_path]
- Similar campaigns: [file_path]
- Tool configuration: [file_path]

### External References

- Industry benchmarks: [url]
- Best practices guide: [url]
- Tool documentation: [url]

### Related Work

- Previous campaigns: [references]
- Related initiatives: [references]
- Strategy documents: [links]
```

### 5. Plan Creation & Formatting

<thinking>
Apply best practices for clarity and actionability, making the plan easy to scan and understand
</thinking>

**Content Formatting:**

- [ ] Use clear, descriptive headings with proper hierarchy (##, ###)
- [ ] Include data examples or sample deliverables where helpful
- [ ] Add screenshots/mockups if relevant (campaign previews, workflow diagrams)
- [ ] Use task lists (- [ ]) for trackable items that can be checked off
- [ ] Add collapsible sections for lengthy data or optional details using `<details>` tags
- [ ] Apply appropriate emoji for visual scanning (target campaign, content, research, automation)

**Cross-Referencing:**

- [ ] Link to related plans or projects
- [ ] Reference specific playbooks, SOPs, or skill files when relevant
- [ ] Link to tools and platforms with descriptive text
- [ ] Mention relevant team members with @username if needed
- [ ] Add links to external resources with descriptive text

**Examples & Templates:**

````markdown
# Good example with clear deliverable references

### Audience List (audience-list.csv)

- ICP: VP Sales / CRO at Series B+ SaaS (50-500 employees)
- Source: Apollo search > Clay enrichment > Instantly upload
- Filters: US-based, hired SDRs in last 6 months, uses Salesforce
- Expected volume: 500 verified contacts

# Collapsible supporting data

<details>
<summary>Full ICP criteria breakdown</summary>

Detailed targeting criteria here...

</details>
````

**AI-Era Considerations:**

- [ ] Account for AI-accelerated execution (enrichment, personalization, content generation)
- [ ] Include prompts or instructions that worked well during research
- [ ] Note which AI tools were used for initial exploration (Claude, Clay AI, etc.)
- [ ] Emphasize quality checks given rapid execution
- [ ] Document any AI-generated outputs that need human review

### 6. Final Review & Submission

**Brainstorm cross-check (if plan originated from a brainstorm):**

Before finalizing, re-read the brainstorm document and verify:
- [ ] Every key decision from the brainstorm is reflected in the plan
- [ ] The chosen approach matches what was decided in the brainstorm
- [ ] Constraints and requirements from the brainstorm are captured in success criteria
- [ ] Open questions from the brainstorm are either resolved or flagged
- [ ] The `origin:` frontmatter field points to the brainstorm file
- [ ] The Sources section includes the brainstorm with a summary of carried-forward decisions

**Pre-submission Checklist:**

- [ ] Title is searchable and descriptive
- [ ] Labels accurately categorize the project type
- [ ] All template sections are complete
- [ ] Links and references are working
- [ ] Success criteria are measurable
- [ ] Name specific deliverables in execution steps and task lists
- [ ] Add a mermaid diagram if applicable for workflow or process visualization

## Write Plan File

**REQUIRED: Write the plan file to disk before presenting any options.**

```bash
mkdir -p docs/plans/
```

Use the Write tool to save the complete plan to `docs/plans/YYYY-MM-DD-<type>-<descriptive-name>-plan.md`. This step is mandatory and cannot be skipped - even when running as part of LFG/SLFG or other automated pipelines.

Confirm: "Plan written to docs/plans/[filename]"

**Pipeline mode:** If invoked from an automated workflow (LFG, SLFG, or any `disable-model-invocation` context), skip all AskUserQuestion calls. Make decisions automatically and proceed to writing the plan without interactive prompts.

## Output Format

**Filename:** Use the date and kebab-case filename from Step 2 Title & Categorization.

```
docs/plans/YYYY-MM-DD-<type>-<descriptive-name>-plan.md
```

Examples:
- docs/plans/2026-01-15-campaign-q2-fintech-outbound-plan.md
- docs/plans/2026-02-03-initiative-content-calendar-redesign-plan.md
- docs/plans/2026-03-10-automation-lead-routing-workflow-plan.md
- BAD: `docs/plans/2026-01-15-campaign-thing-plan.md` (not descriptive - what "thing"?)
- BAD: `docs/plans/2026-01-15-campaign-new-campaign-plan.md` (too vague - what campaign?)
- BAD: `docs/plans/2026-01-15-campaign: fintech outbound-plan.md` (invalid characters - colon and space)
- BAD: `docs/plans/campaign-fintech-outbound-plan.md` (missing date prefix)

## Post-Generation Options

After writing the plan file, use the **AskUserQuestion tool** to present these options:

**Question:** "Plan ready at `docs/plans/YYYY-MM-DD-<type>-<name>-plan.md`. What would you like to do next?"

**Options:**
1. **Open plan in editor** - Open the plan file for review
2. **Run `/deepen-plan`** - Enhance each section with parallel research agents (best practices, benchmarks, examples)
3. **Run `/technical_review`** - Structured feedback from multiple review perspectives
4. **Review and refine** - Improve the document through structured self-review
5. **Start `/workflows:work`** - Begin executing this plan
6. **Start `/workflows:work` on remote** - Begin executing in Claude Code on the web (use `&` to run in background)
7. **Create Issue** - Create issue in project tracker (GitHub/Linear)

Based on selection:
- **Open plan in editor** - Run `open docs/plans/<plan_filename>.md` to open the file in the user's default editor
- **`/deepen-plan`** - Call the /deepen-plan command with the plan file path to enhance with research
- **`/technical_review`** - Call the /technical_review command with the plan file path
- **Review and refine** - Load `document-review` skill.
- **`/workflows:work`** - Call the /workflows:work command with the plan file path
- **`/workflows:work` on remote** - Run `/workflows:work docs/plans/<plan_filename>.md &` to start work in background for Claude Code web
- **Create Issue** - See "Issue Creation" section below
- **Other** (automatically provided) - Accept free text for rework or specific changes

**Note:** If running `/workflows:plan` with ultrathink enabled, automatically run `/deepen-plan` after plan creation for maximum depth and grounding.

Loop back to options after Simplify or Other changes until user selects `/workflows:work` or `/technical_review`.

## Issue Creation

When user selects "Create Issue", detect their project tracker from CLAUDE.md:

1. **Check for tracker preference** in user's CLAUDE.md (global or project):
   - Look for `project_tracker: github` or `project_tracker: linear`
   - Or look for mentions of "GitHub Issues" or "Linear" in their workflow section

2. **If GitHub:**

   Use the title and type from Step 2 (already in context - no need to re-read the file):

   ```bash
   gh issue create --title "<type>: <title>" --body-file <plan_path>
   ```

3. **If Linear:**

   ```bash
   linear issue create --title "<title>" --description "$(cat <plan_path>)"
   ```

4. **If no tracker configured:**
   Ask user: "Which project tracker do you use? (GitHub/Linear/Other)"
   - Suggest adding `project_tracker: github` or `project_tracker: linear` to their CLAUDE.md

5. **After creation:**
   - Display the issue URL
   - Ask if they want to proceed to `/workflows:work` or `/technical_review`

NEVER EXECUTE! Just research and write the plan.
