---
name: workflows:swarm
description: Full autonomous workflow with swarm mode -- spawns parallel agents for maximum speed. Plan, then swarm-execute, then parallel review + test, then deliver.
argument-hint: "[what you want to build or accomplish]"
disable-model-invocation: true
---

Swarm-enabled autonomous workflow. Run these steps in order, parallelizing where indicated. Do not stop between steps -- complete every step through to the end.

## Phase 1: Plan (Sequential)

1. `/workflows:plan $ARGUMENTS`
2. `/workflows-engineering:deepen-plan`

## Phase 2: Execute (Swarm)

3. `/workflows:work` -- **Use swarm mode**: Create a Task list from the plan and launch an army of agent swarm subagents to build it in parallel. Each agent claims tasks, completes them, and moves to the next unclaimed task.

## Phase 3: Verify (Parallel)

After work completes, launch steps 4 and 5 as **parallel background agents** (both only need the completed work to analyze):

4. `/workflows:review` -- spawn as background Task agent
5. `/workflows-engineering:test-browser` -- spawn as background Task agent

Wait for both to complete before continuing.

## Phase 4: Finalize

6. `/workflows-engineering:resolve_todo_parallel` -- resolve any findings from the review
7. `/workflows-engineering:feature-video` -- record the final walkthrough
8. Output `<promise>DONE</promise>` when complete

Start with step 1 now.
