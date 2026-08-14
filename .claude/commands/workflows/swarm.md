---
name: workflows:swarm
description: Full autonomous workflow with swarm mode - spawns parallel agents for maximum speed. Plan, then swarm-execute, then parallel review, then deliver.
argument-hint: "[what you want to build or accomplish]"
---

Swarm-enabled autonomous workflow. Run these steps in order, parallelizing where indicated. Do not stop between steps - complete every step through to the end.

Steps 2, 5, 6 and 7 call `/deepen-plan`, `/test-browser`, `/resolve_todo_parallel` and `/feature-video`, which this kit does not ship. If a command is not installed, skip that step and say so in the run summary rather than stopping.

## Dynamic Context

Current branch: !`git branch --show-current`
Recent commits: !`git log --oneline -5`

## Phase 1: Plan (Sequential)

1. `/workflows:plan $ARGUMENTS`
2. `/deepen-plan`

## Phase 2: Execute (Swarm)

After the plan is written and deepened, execute it using parallel agent swarm orchestration.

### Step 1: Create the Task Board

Read the plan file. Break it into discrete, parallelizable tasks. Create ALL tasks upfront using TaskCreate, then wire dependencies with TaskUpdate.

```
TaskCreate({
  subject: "Task 1: [specific deliverable]",
  description: "[what needs to be done, files to create/modify, references to follow]",
  activeForm: "Building [deliverable]..."
})
TaskCreate({
  subject: "Task 2: [specific deliverable]",
  description: "[what needs to be done]",
  activeForm: "Drafting [deliverable]..."
})
... (create every task from the plan)
```

Then set up dependencies:
```
TaskUpdate({ taskId: "3", addBlockedBy: ["1"] })  // Task 3 needs Task 1 done first
TaskUpdate({ taskId: "5", addBlockedBy: ["2", "4"] })  // Task 5 needs 2 and 4
```

**Rules:**
- Aim for 8-15 tasks. Each = a concrete deliverable (file, component, report, draft, config)
- Group tiny items together. Split large items apart.
- Independent tasks have NO blockedBy (can run in parallel immediately)
- Sequential tasks use addBlockedBy to enforce ordering
- The user sees real-time progress as dots change: pending -> in_progress -> completed

### Step 2: Launch the Swarm

Launch 5-6 parallel Agent workers. Each agent gets a color for visual differentiation. Use `isolation: "worktree"` when agents touch different files to avoid conflicts.

**Match agent types to tasks** - use specialized agents from `.claude/agents/` when a task falls squarely in their domain. Use `general-purpose` for everything else.

```
Agent({
  description: "Swarm worker 1: [focus area]",
  prompt: "You are swarm worker 1 (color: blue). Your job:

PLAN CONTEXT:
[paste the full plan]

TASK LIST:
[paste all task IDs, subjects, dependencies, and current status]

WORKFLOW:
1. Call TaskList to see available tasks
2. Find an unclaimed task with no unresolved blockedBy dependencies
3. Use TaskUpdate to set yourself as owner and mark it in_progress
4. Do the work - follow any referenced playbooks, templates, or examples
5. Use TaskUpdate to mark it completed
6. Repeat until no unclaimed tasks remain

IMPORTANT: Only claim tasks where ALL blockedBy tasks are completed. If no tasks are available, wait briefly and check again.",
  subagent_type: "[matched agent type or general-purpose]",
  run_in_background: true,
  mode: "bypassPermissions",
  isolation: "worktree"
})

Agent({
  description: "Swarm worker 2: [focus area]",
  prompt: "[same pattern, color: green]",
  run_in_background: true,
  mode: "bypassPermissions",
  isolation: "worktree"
})

... (launch 5-6 workers total)
```

**Agent color assignments:** blue, green, purple, orange, cyan, pink

### Step 3: Monitor and Merge

Wait for all background agents to complete. As they finish:
- Check the task board with TaskList
- If any tasks were missed or failed, handle them directly
- Merge worktree changes back (agents in worktrees produce branches that need merging)
- Resolve any conflicts between parallel workers

## Phase 3: Verify (Parallel)

Create verification tasks and launch as parallel background agents:

```
TaskCreate({
  subject: "Deliverable review",
  description: "Multi-agent review of all completed work",
  activeForm: "Reviewing deliverables..."
})
TaskCreate({
  subject: "Browser tests",
  description: "Run browser tests on affected pages",
  activeForm: "Running browser tests..."
})
```

4. `/workflows:review` - spawn as background Agent, mark review task in_progress/completed
5. `/test-browser` - spawn as background Agent, mark test task in_progress/completed

Wait for both to complete.

## Phase 4: Finalize

Create finalization tasks:

```
TaskCreate({
  subject: "Resolve review findings",
  description: "Fix any issues found during review",
  activeForm: "Resolving review findings..."
})
TaskCreate({
  subject: "Record walkthrough",
  description: "Create video walkthrough of the completed deliverable",
  activeForm: "Recording walkthrough..."
})
```

6. `/resolve_todo_parallel` - resolve any findings from the review
7. `/feature-video` - record the final walkthrough
8. Mark all remaining tasks completed
9. Output `<promise>DONE</promise>` when complete

Start with step 1 now.
