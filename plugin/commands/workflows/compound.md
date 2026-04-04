---
name: workflows:compound
description: Document a win, process improvement, or playbook discovery to compound your team's knowledge
argument-hint: "[optional: brief context about the win or discovery]"
---

# /compound

Coordinate multiple subagents working in parallel to document a recent win, process improvement, or playbook discovery.

## Purpose

Captures what worked while context is fresh, creating structured documentation in `docs/wins/` with YAML frontmatter for searchability and future reference. Uses parallel subagents for maximum efficiency.

**Why "compound"?** Each documented win compounds your team's knowledge. The first time you crack a new campaign angle takes weeks of testing. Document it, and the next client gets that playbook on day one. Knowledge compounds.

## Usage

```bash
/workflows:compound                    # Document the most recent win
/workflows:compound [brief context]    # Provide additional context hint
```

## Execution Strategy: Two-Phase Orchestration

<critical_requirement>
**Only ONE file gets written - the final documentation.**

Phase 1 subagents return TEXT DATA to the orchestrator. They must NOT use Write, Edit, or create any files. Only the orchestrator (Phase 2) writes the final documentation file.
</critical_requirement>

### Phase 1: Parallel Research

<parallel_tasks>

Launch these subagents IN PARALLEL. Each returns text data to the orchestrator.

#### 1. **Context Analyzer**
   - Extracts conversation history and relevant data
   - Identifies win type, client/campaign, channel, metrics
   - Validates against schema
   - Returns: YAML frontmatter skeleton

#### 2. **Win Extractor**
   - Analyzes what was tried and what actually worked
   - Identifies the specific tactic, angle, or process change
   - Extracts results with real numbers where available
   - Returns: Win content block

#### 3. **Related Docs Finder**
   - Searches `docs/wins/` for related documentation
   - Identifies cross-references and links
   - Finds related client work or campaigns
   - Returns: Links and relationships

#### 4. **Replication Strategist**
   - Develops guidance for replicating this win
   - Creates "when to use this" criteria
   - Notes constraints or prerequisites (ICP fit, budget, tooling)
   - Returns: Replication playbook content

#### 5. **Category Classifier**
   - Determines optimal `docs/wins/` category
   - Validates category against schema
   - Suggests filename based on slug
   - Returns: Final path and filename

</parallel_tasks>

### Phase 2: Assembly & Write

<sequential_tasks>

**WAIT for all Phase 1 subagents to complete before proceeding.**

The orchestrating agent (main conversation) performs these steps:

1. Collect all text results from Phase 1 subagents
2. Assemble complete markdown file from the collected pieces
3. Validate YAML frontmatter against schema
4. Create directory if needed: `mkdir -p docs/wins/[category]/`
5. Write the SINGLE final file: `docs/wins/[category]/[filename].md`

</sequential_tasks>

### Phase 3: Optional Enhancement

**WAIT for Phase 2 to complete before proceeding.**

<parallel_tasks>

Based on win type, optionally invoke specialized agents to review the documentation:

- **campaign win** - verify metrics and attribution
- **process improvement** - check for automation opportunities
- **objection handling** - cross-reference with other client contexts
- **content discovery** - flag for content team repurposing

</parallel_tasks>

## What It Captures

- **The situation**: Client, campaign, channel, ICP, timeline
- **What was tried**: Approaches tested, including what didn't work
- **What cracked it**: The specific tactic, angle, copy, or process change
- **The numbers**: Reply rates, meetings booked, pipeline generated, hours saved
- **Why it worked**: Analysis of what made this effective
- **How to replicate**: Step-by-step for applying this to the next client or campaign

## Preconditions

<preconditions enforcement="advisory">
  <check condition="win_confirmed">
    Result has been confirmed (not speculative)
  </check>
  <check condition="result_measurable">
    Outcome is measurable or clearly observable
  </check>
  <check condition="non_trivial">
    Non-trivial discovery (not obvious or one-off luck)
  </check>
</preconditions>

## What It Creates

**Organized documentation:**

- File: `docs/wins/[category]/[filename].md`

**Categories auto-detected from win type:**

- campaign-wins/
- objection-handling/
- process-improvements/
- content-discoveries/
- tool-hacks/
- client-playbooks/
- channel-tactics/
- partnership-plays/
- pricing-lessons/

## Common Mistakes to Avoid

| Wrong | Correct |
|-------|---------|
| Subagents write files like `context-analysis.md`, `win-draft.md` | Subagents return text data; orchestrator writes one final file |
| Research and assembly run in parallel | Research completes, then assembly runs |
| Multiple files created during workflow | Single file: `docs/wins/[category]/[filename].md` |

## Success Output

```
Documentation complete.

Subagent Results:
  - Context Analyzer: Identified campaign_win for Acme Corp, LinkedIn outbound
  - Win Extractor: Pain-point angle + 3-step sequence structure
  - Related Docs Finder: 2 related playbooks
  - Replication Strategist: Replication guide with ICP criteria
  - Category Classifier: campaign-wins/

File created:
- docs/wins/campaign-wins/acme-linkedin-pain-point-sequence.md

This will be searchable for future reference when running similar
campaigns for SaaS clients targeting product teams.

What's next?
1. Continue workflow (recommended)
2. Link related documentation
3. Share with team via Slack
4. View documentation
5. Other
```

## The Compounding Philosophy

This creates a compounding knowledge system:

1. First time you crack "LinkedIn sequence for developer tools ICP" - weeks of A/B testing
2. Document the win - docs/wins/campaign-wins/devtools-linkedin-sequence.md (5 min)
3. Next client with similar ICP - deploy proven playbook on day one (30 min)
4. Knowledge compounds - team gets faster with every client

The feedback loop:

```
Launch - Test - Measure - Learn - Document - Replicate - Improve
    ^                                                        |
    +--------------------------------------------------------+
```

**Each client engagement should make the next one faster and more effective.**

## Auto-Invoke

<auto_invoke> <trigger_phrases> - "that worked" - "campaign crushed it" - "huge win" - "this is a playbook" - "we should document this" - "save this for next time" </trigger_phrases>

<manual_override> Use /workflows:compound [context] to document immediately without waiting for auto-detection. </manual_override> </auto_invoke>

## Routes To

`compound-docs` skill

## Applicable Specialized Agents

Based on win type, these agents can enhance documentation:

### Analysis & Validation
- **pattern-recognition-specialist**: Identifies repeating patterns across client wins
- **best-practices-researcher**: Enriches with industry benchmarks and context

### Enhancement & Documentation
- **every-style-editor**: Reviews documentation style and clarity

### When to Invoke
- **Auto-triggered** (optional): Agents can run post-documentation for enhancement
- **Manual trigger**: User can invoke agents after /workflows:compound completes for deeper review
- **Customize agents**: Edit `workflows-engineering.local.md` or invoke the `setup` skill to configure which review agents are used across all workflows

## Related Commands

- `/research [topic]` - Deep investigation (searches docs/wins/ for patterns)
- `/workflows:plan` - Planning workflow (references documented wins and playbooks)
