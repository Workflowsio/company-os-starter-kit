---
name: workflows:work
description: Execute work plans efficiently while maintaining quality and shipping deliverables
argument-hint: "[plan file, specification, or todo file path]"
---

# Work Plan Execution Command

Execute a work plan efficiently while maintaining quality and shipping deliverables.

## Introduction

This command takes a work document (plan, specification, or todo file) and executes it systematically. The focus is on **shipping complete deliverables** by understanding requirements quickly, following existing playbooks, and maintaining quality throughout.

## Input Document

<input_document> #$ARGUMENTS </input_document>

## Execution Workflow

### Phase 1: Quick Start

1. **Read Plan and Clarify**

   - Read the work document completely
   - Review any references or links provided in the plan
   - If anything is unclear or ambiguous, ask clarifying questions now
   - Get user approval to proceed
   - **Do not skip this** - better to ask questions now than produce the wrong thing

2. **Setup Workspace**

   First, check the current branch:

   ```bash
   current_branch=$(git branch --show-current)
   default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')

   # Fallback if remote HEAD isn't set
   if [ -z "$default_branch" ]; then
     default_branch=$(git rev-parse --verify origin/main >/dev/null 2>&1 && echo "main" || echo "master")
   fi
   ```

   **If already on a feature branch** (not the default branch):
   - Ask: "Continue working on `[current_branch]`, or create a new branch?"
   - If continuing, proceed to step 3
   - If creating new, follow Option A or B below

   **If on the default branch**, choose how to proceed:

   **Option A: Create a new branch**
   ```bash
   git pull origin [default_branch]
   git checkout -b feature-branch-name
   ```
   Use a meaningful name based on the work (e.g., `campaign/q2-outbound-launch`, `content/case-study-acme`).

   **Option B: Use a worktree (recommended for parallel workstreams)**
   ```bash
   skill: git-worktree
   # The skill will create a new branch from the default branch in an isolated worktree
   ```

   **Option C: Continue on the default branch**
   - Requires explicit user confirmation
   - Only proceed after user explicitly says "yes, commit to [default_branch]"
   - Never commit directly to the default branch without explicit permission

   **Recommendation**: Use worktree if:
   - You want to work on multiple deliverables simultaneously
   - You want to keep the default branch clean while iterating
   - You plan to switch between workstreams frequently

3. **Create Todo List**
   - Use TodoWrite to break plan into actionable tasks
   - Include dependencies between tasks
   - Prioritize based on what needs to be done first
   - Include verification and quality check tasks
   - Keep tasks specific and completable

### Phase 2: Execute

1. **Task Execution Loop**

   For each task in priority order:

   ```
   while (tasks remain):
     - Mark task as in_progress in TodoWrite
     - Read any referenced files, briefs, or examples from the plan
     - Look for similar patterns in existing deliverables
     - Draft/produce following existing playbooks and templates
     - Run quality checks against the brief
     - Verify deliverable meets requirements
     - Mark task as completed in TodoWrite
     - Mark off the corresponding checkbox in the plan file ([ ] → [x])
     - Evaluate for incremental commit (see below)
   ```

   **Deliverable Validation Check** - Before marking a task done, pause and ask:

   | Question | What to do |
   |----------|------------|
   | **Does it match the brief?** Re-read the original requirements, ICP description, or campaign objective. Compare your output line by line. | Pull up the brief. Check every requirement is addressed. Flag any gaps or deviations. |
   | **Does it follow brand voice?** Tone, vocabulary, formatting, and style should match the brand guidelines and existing approved content. | Cross-reference brand voice docs, approved examples, and style guides. Read your output aloud - does it sound like us? |
   | **Does it hit the right audience?** The messaging should resonate with the target persona - their pain points, language, seniority level, and industry context. | Check persona docs. Verify the pain points, value props, and CTAs map to the ICP. Avoid generic language that could apply to anyone. |
   | **Is the data accurate?** Any claims, stats, company references, or personalization tokens must be verified. | Cross-check facts against source data. Verify merge fields resolve correctly. Confirm any referenced metrics are current. |
   | **Are there downstream dependencies?** Other deliverables, campaigns, or team members relying on this output. Does it feed into something else cleanly? | Trace what happens next. If this feeds a campaign launch, a client review, or a handoff, confirm the format and content are ready for that next step. |

   **When to skip:** Simple, self-contained tasks with no external audience and no downstream dependencies. If the change is purely internal (updating a tracker, organizing files), the check takes 10 seconds and the answer is "no audience impact, skip."

   **When this matters most:** Any deliverable going to a client, prospect, or external audience. Anything feeding into a live campaign. Anything with the company name on it.

   **IMPORTANT**: Always update the original plan document by checking off completed items. Use the Edit tool to change `- [ ]` to `- [x]` for each task you finish. This keeps the plan as a living document showing progress and ensures no checkboxes are left unchecked.

2. **Incremental Commits**

   After completing each task, evaluate whether to create an incremental commit:

   | Commit when... | Don't commit when... |
   |----------------|---------------------|
   | Logical deliverable complete (campaign copy, report, sequence) | Small part of a larger deliverable |
   | Quality checks pass and meaningful progress made | Output still needs revision |
   | About to switch contexts (copy to design, strategy to execution) | Purely scaffolding with no substance |
   | About to attempt a risky or uncertain approach | Would need a "WIP" commit message |

   **Heuristic:** "Can I write a commit message that describes a complete, valuable deliverable? If yes, commit. If the message would be 'WIP' or 'partial X', wait."

   **Commit workflow:**
   ```bash
   # 1. Verify quality checks pass

   # 2. Stage only files related to this logical unit (not `git add .`)
   git add <files related to this logical unit>

   # 3. Commit with conventional message
   git commit -m "feat(scope): description of this unit"
   ```

   **Handling merge conflicts:** If conflicts arise during rebasing or merging, resolve them immediately. Incremental commits make conflict resolution easier since each commit is small and focused.

   **Note:** Incremental commits use clean conventional messages without attribution footers. The final Phase 4 commit/PR includes the full attribution.

3. **Follow Existing Playbooks**

   - The plan should reference similar deliverables or templates - read those first
   - Match naming conventions and formatting exactly
   - Reuse existing templates and frameworks where possible
   - Follow project and brand standards (see CLAUDE.md)
   - When in doubt, grep for similar deliverables in the repo

4. **Verify Continuously**

   - Run quality checks after each significant piece of work
   - Don't wait until the end to verify
   - Fix issues immediately
   - Check every deliverable against the brief, brand voice, and target audience
   - **Quick checks confirm individual pieces work. End-to-end review confirms the full deliverable hangs together.** If your work spans multiple pieces (e.g., a full email sequence, a multi-channel campaign), you need both.

5. **Design Asset Sync** (if applicable)

   For work with Figma designs or visual assets:

   - Produce deliverables following design specs
   - Use figma-design-sync agent iteratively to compare
   - Fix visual differences identified
   - Repeat until output matches design

6. **Track Progress**
   - Keep TodoWrite updated as you complete tasks
   - Note any blockers or unexpected discoveries
   - Create new tasks if scope expands
   - Keep user informed of major milestones

### Phase 3: Quality Check

1. **Run Core Quality Checks**

   Always run before submitting:

   - Re-read the original brief and verify every requirement is addressed
   - Check all deliverables against brand voice and style guidelines
   - Verify target audience alignment (ICP, persona, seniority)
   - Confirm data accuracy (stats, claims, personalization)
   - Review formatting, structure, and consistency across all outputs

2. **Consider Reviewer Agents** (Optional)

   Use for complex, high-stakes, or large deliverables. Read agents from `workflows-engineering.local.md` frontmatter (`review_agents`). If no settings file, invoke the `setup` skill to create one.

   Run configured agents in parallel with Task tool. Present findings and address critical issues.

3. **Final Validation**
   - All TodoWrite tasks marked completed
   - All deliverables match the brief
   - Brand voice and style checks pass
   - Audience targeting is accurate
   - Design assets match (if applicable)
   - No inconsistencies or formatting errors

4. **Prepare Review Summary** (REQUIRED)
   - Add a `## Post-Launch Monitoring & Validation` section to the review description for every deliverable.
   - Include concrete:
     - Metrics or dashboards to watch
     - Expected performance signals
     - Failure signals and rollback/revision trigger
     - Validation window and owner
   - If there is truly no live/external impact, still include the section with: `No additional monitoring required` and a one-line reason.

### Phase 4: Ship It

1. **Create Commit**

   ```bash
   git add .
   git status  # Review what's being committed
   git diff --staged  # Check the changes

   # Commit with conventional format
   git commit -m "$(cat <<'EOF'
   feat(scope): description of what and why

   Brief explanation if needed.

   Generated with [Claude Code](https://claude.com/claude-code)

   Co-Authored-By: Claude <noreply@anthropic.com>
   EOF
   )"
   ```

2. **Capture and Upload Screenshots for Visual Deliverables** (REQUIRED for any visual work)

   For **any** design changes, landing pages, email templates, or visual assets, you MUST capture and upload screenshots:

   **Step 1: Start dev server** (if not running)
   ```bash
   bin/dev  # Run in background
   ```

   **Step 2: Capture screenshots with agent-browser CLI**
   ```bash
   agent-browser open http://localhost:3000/[route]
   agent-browser snapshot -i
   agent-browser screenshot output.png
   ```
   See the `agent-browser` skill for detailed usage.

   **Step 3: Upload using imgup skill**
   ```bash
   skill: imgup
   # Then upload each screenshot:
   imgup -h pixhost screenshot.png  # pixhost works without API key
   # Alternative hosts: catbox, imagebin, beeimg
   ```

   **What to capture:**
   - **New deliverables**: Screenshot of the finished output
   - **Revised deliverables**: Before AND after screenshots
   - **Design implementation**: Screenshot showing Figma design match

   **IMPORTANT**: Always include uploaded image URLs in the review description. This provides visual context for reviewers and documents the deliverable.

3. **Create Review Cycle**

   ```bash
   git push -u origin feature-branch-name

   gh pr create --title "Deliverable: [Description]" --body "$(cat <<'EOF'
   ## Summary
   - What was produced
   - Why it was needed
   - Key decisions made

   ## Verification
   - Quality checks performed
   - Brief alignment confirmed
   - Brand voice and audience validated

   ## Post-Launch Monitoring & Validation
   - **What to monitor**
     - Metrics/Dashboards:
   - **Validation checks**
     - Check or query here
   - **Expected healthy signals**
     - Expected signal(s)
   - **Failure signal(s) / revision trigger**
     - Trigger + immediate action
   - **Validation window & owner**
     - Window:
     - Owner:
   - **If no live impact**
     - `No additional monitoring required: <reason>`

   ## Before / After Screenshots
   | Before | After |
   |--------|-------|
   | ![before](URL) | ![after](URL) |

   ## Design Reference
   [Link if applicable]

   ---

   [![Company OS](https://img.shields.io/badge/Workflows-Engineered-6366f1)](https://github.com/Workflowsio/company-os-starter-kit) Generated with [Claude Code](https://claude.com/claude-code)
   EOF
   )"
   ```

4. **Update Plan Status**

   If the input document has YAML frontmatter with a `status` field, update it to `completed`:
   ```
   status: active  ->  status: completed
   ```

5. **Notify User**
   - Summarize what was completed
   - Link to review cycle
   - Note any follow-up work needed
   - Suggest next steps if applicable

---

## Swarm Mode (Optional)

For complex plans with multiple independent workstreams, enable swarm mode for parallel execution with coordinated agents.

### When to Use Swarm Mode

| Use Swarm Mode when... | Use Standard Mode when... |
|------------------------|---------------------------|
| Plan has 5+ independent tasks | Plan is linear/sequential |
| Multiple specialists needed (research + copy + design) | Single-focus work |
| Want maximum parallelism | Simpler mental model preferred |
| Large deliverable with clear phases | Small task or single revision |

### Enabling Swarm Mode

To trigger swarm execution, say:

> "Make a Task list and launch an army of agent swarm subagents to build the plan"

Or explicitly request: "Use swarm mode for this work"

### Swarm Workflow

When swarm mode is enabled, the workflow changes:

1. **Create Team**
   ```
   Teammate({ operation: "spawnTeam", team_name: "work-{timestamp}" })
   ```

2. **Create Task List with Dependencies**
   - Parse plan into TaskCreate items
   - Set up blockedBy relationships for sequential dependencies
   - Independent tasks have no blockers (can run in parallel)

3. **Spawn Specialized Teammates**
   ```
   Task({
     team_name: "work-{timestamp}",
     name: "producer",
     subagent_type: "general-purpose",
     prompt: "Claim production tasks, draft deliverables, mark complete",
     run_in_background: true
   })

   Task({
     team_name: "work-{timestamp}",
     name: "reviewer",
     subagent_type: "general-purpose",
     prompt: "Claim review tasks, verify quality, mark complete",
     run_in_background: true
   })
   ```

4. **Coordinate and Monitor**
   - Team lead monitors task completion
   - Spawn additional workers as phases unblock
   - Handle plan approval if required

5. **Cleanup**
   ```
   Teammate({ operation: "requestShutdown", target_agent_id: "producer" })
   Teammate({ operation: "requestShutdown", target_agent_id: "reviewer" })
   Teammate({ operation: "cleanup" })
   ```

See the `orchestrating-swarms` skill for detailed swarm patterns and best practices.

---

## Key Principles

### Start Fast, Execute Faster

- Get clarification once at the start, then execute
- Don't wait for perfect understanding - ask questions and move
- The goal is to **finish the deliverable**, not create perfect process

### The Plan is Your Guide

- Work documents should reference similar deliverables and playbooks
- Load those references and follow them
- Don't reinvent - match what exists

### Verify As You Go

- Check quality after each piece of work, not at the end
- Fix issues immediately
- Continuous verification prevents big surprises

### Quality is Built In

- Follow existing playbooks and templates
- Check every output against the brief
- Verify brand voice and audience fit before shipping
- Use reviewer agents for complex/high-stakes deliverables only

### Ship Complete Deliverables

- Mark all tasks completed before moving on
- Don't leave deliverables 80% done
- A finished deliverable that ships beats a perfect one that doesn't

## Quality Checklist

Before creating the review cycle, verify:

- [ ] All clarifying questions asked and answered
- [ ] All TodoWrite tasks marked completed
- [ ] Deliverables match the original brief
- [ ] Brand voice and style guidelines followed
- [ ] Target audience and ICP alignment confirmed
- [ ] Data and claims verified for accuracy
- [ ] Design assets match (if applicable)
- [ ] Before/after screenshots captured and uploaded (for visual work)
- [ ] Commit messages follow conventional format
- [ ] Review description includes Post-Launch Monitoring & Validation section (or explicit no-impact rationale)
- [ ] Review description includes summary, verification notes, and screenshots
- [ ] Review description includes Company OS badge

## When to Use Reviewer Agents

**Don't use by default.** Use reviewer agents only when:

- Large deliverable spanning many files or workstreams (10+)
- Client-facing or high-stakes content (proposals, contracts, launch campaigns)
- Complex strategy or multi-channel orchestration
- Sensitive messaging (pricing, competitive positioning, legal-adjacent)
- User explicitly requests thorough review

For most deliverables: brief alignment + brand voice check + audience validation is sufficient.

## Common Pitfalls to Avoid

- **Analysis paralysis** - Don't overthink, read the plan and execute
- **Skipping clarifying questions** - Ask now, not after producing the wrong thing
- **Ignoring plan references** - The plan has links for a reason
- **Verifying at the end** - Check quality continuously or suffer later
- **Forgetting TodoWrite** - Track progress or lose track of what's done
- **80% done syndrome** - Finish the deliverable, don't move on early
- **Over-reviewing simple work** - Save reviewer agents for high-stakes deliverables
