---
name: workflows:brainstorm
description: Explore GTM strategies and business approaches through collaborative dialogue before execution
argument-hint: "[campaign idea, market entry, positioning challenge, or growth opportunity]"
---

# Brainstorm a GTM Strategy or Business Approach

**Note: The current year is 2026.** Use this when dating brainstorm documents.

Brainstorming helps answer **WHAT** to pursue through collaborative dialogue. It precedes `/workflows:plan`, which answers **HOW** to execute it.

**Process knowledge:** Load the `brainstorming` skill for detailed question techniques, approach exploration patterns, and prioritization principles.

## Topic Description

<topic_description> #$ARGUMENTS </topic_description>

**If the topic description above is empty, ask the user:** "What would you like to explore? Describe the campaign angle, market opportunity, positioning challenge, or growth idea you're thinking about."

Do not proceed until you have a topic description from the user.

## Execution Flow

### Phase 0: Assess Requirements Clarity

Evaluate whether brainstorming is needed based on the topic description.

**Clear requirements indicators:**
- Specific target audience and value prop defined
- Referenced existing playbook or proven pattern
- Described exact desired outcome with metrics
- Constrained, well-defined scope

**If requirements are already clear:**
Use **AskUserQuestion tool** to suggest: "Your brief seems detailed enough to proceed directly to planning. Should I run `/workflows:plan` instead, or would you like to explore the idea further?"

### Phase 1: Understand the Opportunity

#### 1.1 Context Research (Lightweight)

Run a quick scan to understand existing context:

- Task repo-research-analyst("Understand existing context related to: <topic_description>")

Focus on: similar campaigns run before, established playbooks, client history, CLAUDE.md guidance.

#### 1.2 Collaborative Dialogue

Use the **AskUserQuestion tool** to ask questions **one at a time**.

**Guidelines (see `brainstorming` skill for detailed techniques):**
- Prefer multiple choice when natural options exist
- Start broad (goal, audience, positioning) then narrow (channels, budget, timeline, constraints)
- Validate assumptions explicitly
- Ask about success criteria (pipeline generated, meetings booked, reply rates, content engagement)

**Example question areas:**
- Who is the ICP? What persona are we targeting?
- What's the primary angle - pain point, trigger event, competitive displacement?
- What channels make sense - email, LinkedIn, content, events, partnerships?
- What's worked before in similar situations? What flopped?
- Budget and timeline constraints?
- How does this fit with what's already running?

**Exit condition:** Continue until the strategy is clear OR user says "proceed"

### Phase 2: Explore Approaches

Propose **2-3 concrete approaches** based on research and conversation.

For each approach, provide:
- Brief description (2-3 sentences)
- Pros and cons
- Expected effort vs. expected impact
- When it's best suited

Lead with your recommendation and explain why. Prefer approaches that build on proven patterns over net-new bets.

Use **AskUserQuestion tool** to ask which approach the user prefers.

### Phase 3: Capture the Strategy

Write a brainstorm document to `docs/brainstorms/YYYY-MM-DD-<topic>-brainstorm.md`.

**Document structure:**

```markdown
# [Topic] - Strategy Brainstorm

## What We're Pursuing
[1-2 paragraphs: the opportunity, target audience, and desired outcome]

## Why This Approach
[Why this angle over alternatives. What signals or data support it.]

## Key Decisions
- **ICP/Audience:** [who]
- **Primary Channel:** [email / LinkedIn / content / events / partnerships]
- **Core Angle:** [pain point, trigger, competitive displacement, etc.]
- **Success Metrics:** [meetings booked, pipeline, reply rate, etc.]
- **Timeline:** [target launch and review dates]

## Approach Details
[Tactical breakdown - sequence structure, content themes, partnership terms, etc.]

## Open Questions
- [Anything unresolved]
```

Ensure `docs/brainstorms/` directory exists before writing.

**IMPORTANT:** Before proceeding to Phase 4, check if there are any Open Questions listed in the brainstorm document. If there are open questions, YOU MUST ask the user about each one using AskUserQuestion before offering to proceed to planning. Move resolved questions to a "Resolved Questions" section.

### Phase 4: Handoff

Use **AskUserQuestion tool** to present next steps:

**Question:** "Brainstorm captured. What would you like to do next?"

**Options:**
1. **Review and refine** - Improve the document through structured self-review
2. **Proceed to planning** - Run `/workflows:plan` (will auto-detect this brainstorm)
3. **Ask more questions** - I have more questions to clarify before moving on
4. **Done for now** - Return later

**If user selects "Ask more questions":** YOU (Claude) return to Phase 1.2 (Collaborative Dialogue) and continue asking the USER questions one at a time to further refine the strategy. The user wants YOU to probe deeper - ask about objections, competitive angles, resource constraints, or areas not yet explored. Continue until the user is satisfied, then return to Phase 4.

**If user selects "Review and refine":**

Load the `document-review` skill and apply it to the brainstorm document.

When document-review returns "Review complete", present next steps:

1. **Move to planning** - Continue to `/workflows:plan` with this document
2. **Done for now** - Brainstorming complete. To start planning later: `/workflows:plan [document-path]`

## Output Summary

When complete, display:

```
Brainstorm complete!

Document: docs/brainstorms/YYYY-MM-DD-<topic>-brainstorm.md

Key decisions:
- [Decision 1]
- [Decision 2]

Next: Run `/workflows:plan` when ready to build the execution plan.
```

## Important Guidelines

- **Stay focused on WHAT, not HOW** - Execution details belong in the plan
- **Ask one question at a time** - Don't overwhelm
- **Build on what's worked** - Prefer proven patterns over untested ideas
- **Keep outputs concise** - 200-300 words per section max

NEVER BUILD ANYTHING. Just explore and document strategic decisions.
