---
name: workflows:review
description: Perform exhaustive deliverable reviews using multi-agent analysis, ultra-thinking, and isolated workspaces
argument-hint: "[deliverable path, PR number, GitHub URL, or latest]"
---

# Review Command

<command_purpose> Perform exhaustive reviews of GTM deliverables using multi-agent analysis, ultra-thinking, and isolated workspaces for deep independent inspection. </command_purpose>

## Introduction

<role>Senior GTM Review Lead with expertise in strategy alignment, risk assessment, brand voice, and deliverable quality assurance</role>

## Prerequisites

<requirements>
- Git repository with GitHub CLI (`gh`) installed and authenticated
- Clean main/master branch
- Proper permissions to create worktrees and access the repository
- For document reviews: Path to a markdown file, campaign copy, proposal, or other deliverable
</requirements>

## Main Tasks

### 1. Determine Review Target & Setup (ALWAYS FIRST)

<review_target> #$ARGUMENTS </review_target>

<thinking>
First, I need to determine the review target type and set up the deliverable for analysis.
</thinking>

#### Immediate Actions:

<task_list>

- [ ] Determine review type: PR number (numeric), GitHub URL, file path (.md), or empty (current branch)
- [ ] Check current git branch
- [ ] If ALREADY on the target branch (PR branch, requested branch name, or the branch already checked out for review) - proceed with analysis on current branch
- [ ] If DIFFERENT branch than the review target - offer to use worktree: "Use git-worktree skill for isolated review." Call `skill: git-worktree` with branch name
- [ ] Fetch PR metadata using `gh pr view --json` for title, body, files, linked issues
- [ ] Identify the type of deliverable: campaign copy, proposal, playbook, SOP, client report, content piece, automation config, etc.
- [ ] Prepare context: who is the audience, what is the goal, what brand standards apply
- [ ] Make sure we are on the branch we are reviewing. Use gh pr checkout to switch to the branch or manually checkout the branch.

Ensure that the deliverable is ready for analysis (either in worktree or on current branch). ONLY then proceed to the next step.

</task_list>

#### Protected Artifacts

<protected_artifacts>
The following paths are workflows-engineering pipeline artifacts and must never be flagged for deletion, removal, or gitignore by any review agent:

- `docs/plans/*.md` - Plan files created by `/workflows:plan`. These are living documents that track implementation progress (checkboxes are checked off by `/workflows:work`).
- `docs/solutions/*.md` - Solution documents created during the pipeline.

If a review agent flags any file in these directories for cleanup or removal, discard that finding during synthesis. Do not create a todo for it.
</protected_artifacts>

#### Load Review Agents

Read `workflows-engineering.local.md` in the project root. If found, use `review_agents` from YAML frontmatter. If the markdown body contains review context, pass it to each agent as additional instructions.

If no settings file exists, invoke the `setup` skill to create one. Then read the newly created file and continue.

#### Parallel Agents to review the deliverable:

<parallel_tasks>

Run all configured review agents in parallel using Task tool. For each agent in the `review_agents` list:

```
Task {agent-name}(Deliverable content + review context from settings body)
```

Additionally, always run these four core review agents regardless of settings:

- Task strategy-reviewer(Deliverable content) - Does this align with the stated goal, ICP, and GTM strategy? Are the assumptions sound? Is the approach differentiated?
- Task quality-reviewer(Deliverable content) - Is the output polished, complete, and professional? Are there errors, inconsistencies, or gaps? Does it meet the bar for client-facing work?
- Task brand-voice-reviewer(Deliverable content) - Does this match the brand voice guidelines? Is the tone right for the audience? Are there AI giveaway words, filler, or off-brand phrasing?
- Task completeness-reviewer(Deliverable content) - Is anything missing? Are all sections filled? Are CTAs present where needed? Does this fully address the brief?

</parallel_tasks>

#### Conditional Agents (Run if applicable):

<conditional_agents>

These agents are run ONLY when the deliverable matches specific criteria. Check the files and context to determine if they apply:

**OUTBOUND CAMPAIGNS: If deliverable contains email sequences, LinkedIn messages, or campaign copy:**

- Task deliverability-reviewer(Deliverable content) - Checks for spam trigger words, link density, personalization gaps, and send-readiness
- Task compliance-reviewer(Deliverable content) - Validates CAN-SPAM/GDPR compliance, opt-out presence, sender identity, and data handling
- Task conversion-reviewer(Deliverable content) - Assesses whether the copy will actually drive the desired action, with specific improvement suggestions

**When to run:**
- Deliverable includes email subject lines, body copy, or sequence steps
- Deliverable contains LinkedIn connection requests or DM templates
- Deliverable is a campaign brief or outbound playbook
- Deliverable title/body mentions: campaign, sequence, outbound, cadence, follow-up

**What these agents check:**
- `deliverability-reviewer`: Spam word density, link-to-text ratio, personalization tokens, warm-up readiness, sending volume alignment
- `compliance-reviewer`: Unsubscribe mechanism, physical address, sender name accuracy, data source legitimacy, GDPR consent trail
- `conversion-reviewer`: CTA clarity, value proposition strength, urgency without desperation, social proof placement, objection handling

**CLIENT DELIVERABLES: If output is going to a client (proposals, reports, decks, SOPs):**

- Task client-readiness-reviewer(Deliverable content) - Checks formatting, professional polish, client-specific context accuracy, and whether it is ready to send without edits
- Task risk-reviewer(Deliverable content) - Flags anything that could damage reputation, over-promise, expose confidential data, or create legal liability

**When to run:**
- File path contains "client" or a known client name
- Deliverable is a proposal, report, case study, or SOW
- Content references specific client metrics, names, or confidential data

</conditional_agents>

### 4. Ultra-Thinking Deep Dive Phases

<ultrathink_instruction> For each phase below, spend maximum cognitive effort. Think step by step. Consider all angles. Question assumptions. Bring all reviews into a synthesis for the user.</ultrathink_instruction>

<deliverable>
Complete deliverable context map with audience, goal, and component interactions
</deliverable>

#### Phase 3: Stakeholder Perspective Analysis

<thinking_prompt> ULTRA-THINK: Put yourself in each stakeholder's shoes. What matters to them? What are their pain points? </thinking_prompt>

<stakeholder_perspectives>

1. **Client Perspective** <questions>

   - Does this solve my problem?
   - Is it clear what I need to do next?
   - Does it feel tailored to my business, or generic?
   - Would I forward this to my boss with confidence? </questions>

2. **Prospect Perspective** <questions>

   - Does this earn my attention in the first 3 seconds?
   - Is the value proposition obvious?
   - Does this feel like spam or a real conversation?
   - Is there a clear, low-friction next step? </questions>

3. **Team Execution Perspective** <questions>

   - Can I execute this without asking 10 clarifying questions?
   - Are the steps specific enough to follow?
   - Are the tools and resources I need called out?
   - Is the timeline realistic? </questions>

4. **Brand & Reputation Perspective** <questions>

   - Does this reflect our positioning and values?
   - Could anything here be taken out of context?
   - Are we making claims we can back up?
   - Would your leadership be comfortable with their name on this? </questions>

5. **Business Outcome Perspective** <questions>
   - Will this actually move the metric it is supposed to move?
   - What is the expected ROI or conversion rate?
   - Are there legal or compliance risks?
   - What happens if this fails - what is the downside? </questions> </stakeholder_perspectives>

#### Phase 4: Scenario Exploration

<thinking_prompt> ULTRA-THINK: Explore edge cases and failure scenarios. What could go wrong? How does this perform under real-world conditions? </thinking_prompt>

<scenario_checklist>

- [ ] **Happy Path**: Recipient engages as intended, takes desired action
- [ ] **Ignored**: Deliverable gets no response or engagement - what then?
- [ ] **Misread**: Audience interprets the message differently than intended
- [ ] **Wrong Audience**: Deliverable reaches someone outside the ICP
- [ ] **Competitor Comparison**: Prospect is evaluating alternatives - does this stand out?
- [ ] **Scale Testing**: Does this hold up at 10x volume (100 sends vs 1,000 vs 10,000)?
- [ ] **Timing Issues**: What if the timing is wrong (end of quarter, holiday, market shift)?
- [ ] **Data Accuracy**: Are the personalization fields, stats, and claims correct?
- [ ] **Brand Damage**: Could this hurt reputation if screenshotted and shared?
- [ ] **Legal Exposure**: Any compliance, IP, or contractual risk? </scenario_checklist>

### 6. Multi-Angle Review Perspectives

#### Strategy Alignment Angle

- Does this advance the stated business objective?
- Is the approach consistent with the broader GTM strategy?
- Are assumptions about the market and ICP validated?
- Does this differentiate from what competitors are doing?

#### Effectiveness Angle

- Will this actually achieve the goal?
- Are the CTAs strong and the value props clear?
- Is the structure optimized for the channel (email, LinkedIn, doc, deck)?
- What is the expected outcome, and is it realistic?

#### Risk Assessment Angle

- Could this damage client relationships or brand reputation?
- Is confidential or sensitive data handled correctly?
- Are there compliance concerns (GDPR, CAN-SPAM, contractual)?
- What is the worst-case scenario if this goes wrong?

#### Clarity Angle

- Is this clear and actionable for the intended audience?
- Can someone execute on this without extra context?
- Is the language concise and free of jargon or filler?
- Are next steps, owners, and timelines explicit?

### 4. Clarity and Simplification Review

Run the Task deliverable-clarity-reviewer() to check if we can make the output clearer, more concise, and more actionable.

### 5. Findings Synthesis and Todo Creation Using file-todos Skill

<critical_requirement> ALL findings MUST be stored in the todos/ directory using the file-todos skill. Create todo files immediately after synthesis - do NOT present findings for user approval first. Use the skill for structured todo management. </critical_requirement>

#### Step 1: Synthesize All Findings

<thinking>
Consolidate all agent reports into a categorized list of findings.
Remove duplicates, prioritize by severity and impact.
</thinking>

<synthesis_tasks>

- [ ] Collect findings from all parallel agents
- [ ] Discard any findings that recommend deleting or gitignoring files in `docs/plans/` or `docs/solutions/` (see Protected Artifacts above)
- [ ] Categorize by type: strategy, effectiveness, brand/voice, clarity, compliance, risk, quality
- [ ] Assign severity levels: P1 CRITICAL, P2 IMPORTANT, P3 NICE-TO-HAVE
- [ ] Remove duplicate or overlapping findings
- [ ] Estimate effort for each finding (Small/Medium/Large)

</synthesis_tasks>

#### Step 2: Create Todo Files Using file-todos Skill

<critical_instruction> Use the file-todos skill to create todo files for ALL findings immediately. Do NOT present findings one-by-one asking for user approval. Create all todo files in parallel using the skill, then summarize results to user. </critical_instruction>

**Implementation Options:**

**Option A: Direct File Creation (Fast)**

- Create todo files directly using Write tool
- All findings in parallel for speed
- Use standard template from `.claude/skills/file-todos/assets/todo-template.md`
- Follow naming convention: `{issue_id}-pending-{priority}-{description}.md`

**Option B: Sub-Agents in Parallel (Recommended for Scale)** For large deliverables with 15+ findings, use sub-agents to create finding files in parallel:

```bash
# Launch multiple finding-creator agents in parallel
Task() - Create todos for first finding
Task() - Create todos for second finding
Task() - Create todos for third finding
etc. for each finding.
```

Sub-agents can:

- Process multiple findings simultaneously
- Write detailed todo files with all sections filled
- Organize findings by severity
- Create detailed Proposed Solutions
- Add acceptance criteria and work logs
- Complete much faster than sequential processing

**Execution Strategy:**

1. Synthesize all findings into categories (P1/P2/P3)
2. Group findings by severity
3. Launch 3 parallel sub-agents (one per severity level)
4. Each sub-agent creates its batch of todos using the file-todos skill
5. Consolidate results and present summary

**Process (Using file-todos Skill):**

1. For each finding:

   - Determine severity (P1/P2/P3)
   - Write detailed Problem Statement and Findings
   - Create 2-3 Proposed Solutions with pros/cons/effort/risk
   - Estimate effort (Small/Medium/Large)
   - Add acceptance criteria and work log

2. Use file-todos skill for structured todo management:

   ```bash
   skill: file-todos
   ```

   The skill provides:

   - Template location: `.claude/skills/file-todos/assets/todo-template.md`
   - Naming convention: `{issue_id}-{status}-{priority}-{description}.md`
   - YAML frontmatter structure: status, priority, issue_id, tags, dependencies
   - All required sections: Problem Statement, Findings, Solutions, etc.

3. Create todo files in parallel:

   ```bash
   {next_id}-pending-{priority}-{description}.md
   ```

4. Examples:

   ```
   001-pending-p1-off-brand-messaging.md
   002-pending-p1-missing-compliance-footer.md
   003-pending-p2-weak-cta.md
   004-pending-p3-redundant-section.md
   ```

5. Follow template structure from file-todos skill: `.claude/skills/file-todos/assets/todo-template.md`

**Todo File Structure (from template):**

Each todo must include:

- **YAML frontmatter**: status, priority, issue_id, tags, dependencies
- **Problem Statement**: What is wrong or missing, why it matters
- **Findings**: Discoveries from agents with evidence/location
- **Proposed Solutions**: 2-3 options, each with pros/cons/effort/risk
- **Recommended Action**: (Filled during triage, leave blank initially)
- **Technical Details**: Affected files, sections, dependencies
- **Acceptance Criteria**: Testable checklist items
- **Work Log**: Dated record with actions and learnings
- **Resources**: Links to PR, issues, documentation, similar patterns

**File naming convention:**

```
{issue_id}-{status}-{priority}-{description}.md

Examples:
- 001-pending-p1-reputation-risk.md
- 002-pending-p2-strategy-misalignment.md
- 003-pending-p3-copy-polish.md
```

**Status values:**

- `pending` - New findings, needs triage/decision
- `ready` - Approved, ready to address
- `complete` - Work finished

**Priority values:**

- `p1` - Critical (blocks delivery, reputation risk, compliance issue)
- `p2` - Important (should fix, strategy/effectiveness concern)
- `p3` - Nice-to-have (polish, minor improvements)

**Tagging:** Always add `deliverable-review` tag, plus: `strategy`, `effectiveness`, `brand-voice`, `clarity`, `compliance`, `risk`, `quality`, etc.

#### Step 3: Summary Report

After creating all todo files, present full summary:

````markdown
## Review Complete

**Review Target:** PR #XXXX - [PR Title] / [Deliverable Name]
**Type:** [Campaign Copy / Proposal / Playbook / Report / etc.]

### Findings Summary:

- **Total Findings:** [X]
- **P1 CRITICAL:** [count] - BLOCKS DELIVERY
- **P2 IMPORTANT:** [count] - Should Fix
- **P3 NICE-TO-HAVE:** [count] - Polish

### Created Todo Files:

**P1 - Critical (BLOCKS DELIVERY):**

- `001-pending-p1-{finding}.md` - {description}
- `002-pending-p1-{finding}.md` - {description}

**P2 - Important:**

- `003-pending-p2-{finding}.md` - {description}
- `004-pending-p2-{finding}.md` - {description}

**P3 - Nice-to-Have:**

- `005-pending-p3-{finding}.md` - {description}

### Review Agents Used:

- strategy-reviewer
- quality-reviewer
- brand-voice-reviewer
- completeness-reviewer
- [conditional agents if triggered]

### Next Steps:

1. **Address P1 Findings**: CRITICAL - must be fixed before delivery

   - Review each P1 todo in detail
   - Implement fixes or request exemption
   - Verify fixes before sending/publishing

2. **Triage All Todos**:
   ```bash
   ls todos/*-pending-*.md  # View all pending todos
   /triage                  # Use slash command for interactive triage
   ```
````

3. **Work on Approved Todos**:

   ```bash
   /resolve_todo_parallel  # Fix all approved items efficiently
   ```

4. **Track Progress**:
   - Rename file when status changes: pending - ready - complete
   - Update Work Log as you work
   - Commit todos: `git add todos/ && git commit -m "review: add deliverable review findings"`

### Severity Breakdown:

**P1 (Critical - Blocks Delivery):**

- Reputation or brand damage risk
- Compliance violations (GDPR, CAN-SPAM, contractual)
- Factual errors or misleading claims
- Confidential data exposure
- Fundamentally wrong strategy or audience

**P2 (Important - Should Fix):**

- Weak CTAs or unclear value proposition
- Strategy misalignment or missed positioning
- Significant tone/voice inconsistencies
- Missing sections or incomplete deliverable
- Effectiveness concerns (likely to underperform)

**P3 (Nice-to-Have):**

- Minor copy polish
- Formatting improvements
- Additional personalization opportunities
- Nice-to-have context or examples
- Documentation updates

### Important: P1 Findings Block Delivery

Any **P1 (CRITICAL)** findings must be addressed before the deliverable is sent, published, or delivered to a client. Present these prominently and ensure they are resolved first.
```
