# AGENTS.md - the second-agent contract

<!-- Only needed when a SECOND runtime, agent or differently-configured teammate
     setup reads and writes this store. One runtime needs no contract. Two
     without one produce two readings of the same files, and the divergence is
     invisible until an action fires that should not have.
     This file holds ONLY what differs by runtime. It restates no structure, no
     connected-system inventory and no data model, because all of that is in
     CLAUDE.md and a second copy is a second thing to drift. Keep it around a
     fifth the length of CLAUDE.md. Pointers run one way: this file points at
     CLAUDE.md and CLAUDE.md never points back, so when two files disagree
     there is exactly one direction to walk. -->

**Audience boundary, restated in full on purpose.** Never write credentials, personal opinions about a named individual, personal life context, {{extra_boundary_item}}, or anything you would not hand a new hire on day one. A boundary only one side knows about is not a boundary.

---
## 1. Load order

1. `CLAUDE.md` - structure, connected systems, guardrails. Read in full.
2. `INDEX.md` - what exists here, and which skill already covers this task.
3. Any file in `.claude/rules/` whose `paths:` glob matches your working directory. The narrow rule wins inside its scope and says so in its own body.
4. `clients/<slug>/operating-state.md`, if an account is in scope. Trust it over your own re-audit. It is the state that survived the last context clear.
5. `MEMORY.md`, only when the task is unfamiliar. Open the topic file it routes you to, not the index's line about it.
6. Section 2 below - which task types you own and which you hand off.
7. Nothing else preloads. Account data loads at execution time.

<!-- Not one line of the pointed-to content is repeated above. Summarizing the
     important bits for the second agent is exactly how two files start
     disagreeing, and the summary is always the copy that goes stale. -->

---
## 2. Role boundary, by task type

<!-- Split by TASK TYPE, never by tool name. Tool names differ across runtimes
     and rot as connectors are renamed, and a boundary that stops matching hands
     the acting runtime task types nobody assigned it. -->

| Owned by the authoring runtime | Owned by the acting runtime |
|---|---|
| Reading and writing files in this store | Sending anything to a person outside the company |
| Drafting copy, briefs and playbooks | Activating, pausing or mutating a live campaign |
| Structural changes to the store | Writing to the CRM or the ops database |
| Analysis and reporting from exported data | Running live queries or migrations against production data |
| Building and editing skills and rules | Mutating a production automation |
| Preparing a change for review | Financial actions |

The asymmetry is deliberate. The runtime that edits the store owns more task types; the runtime that touches live systems owns fewer and heavier ones. This is ownership, not capability: an agent that technically can fire a live action still knows it is not its call.

---
## 3. Safety

Gated classes and the tier model live in CLAUDE.md section 9 and in `.claude/hooks/safety-guard.sh`. The gate is the authority; this file only says what to do when it denies you.

1. Stop. Do not retry with a different tool, a raw interface call, or a rewritten command.
2. Tell the human in one line: what the action does, to whom or to what system, reversible or not.
3. Get an explicit yes for this payload. A general go-ahead earlier in the session is not approval.
4. Complete the unblock step exactly as the deny message names it, then retry once.
5. Still denied: emit the packet below. Never escalate your own permissions.
6. Never create a two-person approval file yourself, under any circumstances.
7. Record the outcome in the account's operating-state doc, including a denial you did not override.

---
## 4. The handoff packet

When you hit an action you do not own, you do not stop and you do not improvise. You emit these eight fields. Each one exists to stop the receiver re-deriving a decision you already made.

1. **Goal** - the outcome in one sentence, in business terms.
2. **Why blocked** - which task type this is and which runtime owns it.
3. **Safety tier** - reversible and internal, or irreversible and outward-facing.
4. **Approval status** - who approved, when, and *what exactly* they approved. "The user said go ahead" is not an approval record.
5. **Source context** - the files and records the decision came from, by path, so the receiver can verify rather than trust.
6. **Exact action and payload** - the literal payload, not a description of it. A described payload gets reconstructed, and a reconstruction is a different payload.
7. **Verification** - how you will know it worked, stated before it runs.
8. **Rollback** - what undoes this, or the explicit statement that nothing does.

Field 8 does double duty. Writing "nothing undoes this" is often the moment you realize the action needs a human rather than a handoff. The packet carries the decision and nothing else: the receiver loads the account, the playbook and the structure from the store through the load order above.
