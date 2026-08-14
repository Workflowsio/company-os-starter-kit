# The safety layer

Three hooks and the settings file that wires them up. The safety guard is the
one that matters: it is a pre-action gate that decides, before any action fires,
whether the acting identity is allowed to do that class of thing without a human
saying yes first.

Install it the moment your agent can reach a real person, move money, mutate a
production automation, or delete records. It is mandatory when permission
prompts are disabled or the agent runs unattended on a schedule, because with
prompts off the gate is the only thing between the model and the action.

| File | What it does | Wired to |
|---|---|---|
| `safety-guard.sh` | Pre-action approval gate, plus session start and session close modes | PreToolUse, SessionStart, SessionEnd |
| `safety-guard-test.sh` | Fires synthetic payloads at the gate and asserts every cell of the matrix | run by hand, and in CI |
| `session-logger.sh` | Writes every event to a per-session JSONL file | PreToolUse, PostToolUse, PostToolUseFailure, UserPromptSubmit, Stop, PreCompact, SessionEnd |
| `notify.sh` | Native OS notification when the agent needs attention | Stop, PermissionRequest, Notification, SessionStart, SessionEnd, SubagentStop |
| `../settings.json` | Wires all of it to the lifecycle events | config |
| `../safety-roster.example` | Template for the tier roster | copy it, see below |

---

## Install

```bash
# 1. Dependencies. The gate fails closed without them, on purpose.
brew install jq          # or: sudo apt install jq

# 2. Copy the hooks and the settings into your project.
mkdir -p .claude/hooks .claude/sessions
cp path/to/starter-kit/.claude/hooks/*.sh .claude/hooks/
cp path/to/starter-kit/.claude/settings.json .claude/settings.json
chmod +x .claude/hooks/*.sh        # belt and braces: settings.json calls each
                                   # hook through bash, so the bit is not what
                                   # decides whether the gate runs. Set it anyway
                                   # so you can run them by hand.

# 2b. Install the gate at the machine-global location too.
#     A gate present in the project config and absent from the machine-global one
#     covers exactly the sessions that happen to start in this project. Every
#     session started anywhere else, and every downstream clone, runs unguarded.
mkdir -p ~/.claude/hooks
cp .claude/hooks/safety-guard.sh ~/.claude/hooks/safety-guard.sh
$EDITOR ~/.claude/settings.json    # merge the same "hooks" block in

#     Then prove the two copies are the same policy, not two policies.
shasum -a 256 .claude/hooks/safety-guard.sh ~/.claude/hooks/safety-guard.sh

# 3. Create your roster. Without this every identity is on the strictest tier.
cp path/to/starter-kit/.claude/safety-roster.example .claude/safety-roster
$EDITOR .claude/safety-roster        # put your own committer email under owner:

# 4. Prove it works before you trust it.
bash .claude/hooks/safety-guard-test.sh
```

If you already have a `settings.json`, merge the `hooks` key rather than
replacing the file.

Two details in the shipped `settings.json` look like formatting and are not. Each
hook is invoked as `bash "$CLAUDE_PROJECT_DIR/.claude/hooks/<name>.sh"`. The
quotes matter because an unquoted path breaks at its first space and the tool call
is then never gated, and a store at `~/Documents/Company OS` is the normal case
rather than the exotic one. Going through `bash` matters because a copy that lost
its executable bit exits 126 when invoked directly, and 126 is a non-blocking hook
error rather than the exit 2 that blocks: the gate is off and nothing says so.

The real roster is gitignored and the example is not. Who is trusted on a
machine is a per-machine decision, not a repository fact, and a roster in git is
a roster that gets copied to a laptop it was never meant to describe.

---

## The model

Two axes. How much the acting identity is trusted, and how much damage the
action can do. The cell where they meet decides the outcome.

### Operation classes, by blast radius

| Class | Definition | Examples |
|---|---|---|
| Irreversible outward | Reaches a person outside the company, or moves money. Cannot be recalled. | Sending or replying to a prospect, activating or resuming a campaign, adding contacts to a live sequence, invoices, refunds, subscription changes |
| Production mutation | Changes a running system other people's work depends on | Live SQL, schema migrations, function deploys, creating or replacing a production automation |
| Destructive internal | Deletes or bulk-mutates internal records. Recoverable only from a backup. | Deleting records, lists or webhooks, bulk moves, force pushes, recursive deletes, dropping a table |
| Reversible internal | Internal, low blast radius, trivially undone | Everything on the not-guarded list below |

Class by consequence, not by how technical the action feels. Live SQL feels
dangerous and a campaign activation feels routine, but the activation is the one
that reaches every contact on the list and cannot be recalled.

### Identity tiers

Resolved from the version-control committer email, lowercased, matched against
the roster. Check yours with `git config user.email`.

| Tier | Who |
|---|---|
| owner | Built the system and carries the consequences |
| trusted | Runs live work daily and is accountable for it |
| team | Everyone else, including every unrecognised identity |
| unresolved | No identity available at all. Resolves to the strictest tier, never the friendliest |

Unresolved resolving to strictest is the most important default here. A gate that
assumes a friendly identity when it cannot find one is bypassed by running it
where identity is unconfigured, which is exactly what a scheduled run looks like.

### The matrix

| | Reversible internal | Destructive internal | Production mutation | Irreversible outward |
|---|---|---|---|---|
| owner | allow, silent | **allow, with a warning** | confirm | confirm |
| trusted | allow, silent | confirm | confirm | confirm |
| team | allow, silent | confirm | two-person | two-person |
| unresolved | allow, silent | confirm | two-person | two-person |

The owner-warning cell is load-bearing and it is the one people tighten during a
review. A gate that blocks its own author on every destructive command gets
switched off inside a week, and a switched-off gate protects nobody at any tier.
Spend the friction budget where trust and blast radius jointly justify it.

If your team is drowning in confirmations, the fix is almost always that a
reversible capability got classified as destructive. Move a class up a row
rather than adding a fifth tier.

---

## How an action gets classified

Before any of it, the payload has to parse. Unparseable JSON, a truncated body, or
a payload carrying the action under a key this gate does not know all block with an
audit row. Empty stdin is the only clean exit. A silent allow with no trace is
indistinguishable from a gate nobody triggered, which is the whole reason the
prefix-scan defect below took so long to find.

Then the gate runs these in order and stops at the first match.

1. **The guarded-verb veto.** The action name is tokenised, and a flag is set if
   any token is a write, delete, send or money verb. This runs before the
   allowlist because it is what makes the allowlist safe: a name carrying both a
   read word and a write word is a write. Without the veto,
   `delete_leads_from_list`, `move_leads_to_campaign_or_list`,
   `add_leads_to_campaign_or_list_bulk` and `find_and_delete_duplicates` all
   passed as reads, silently, with no audit row.
2. **Read allowlist**, for names carrying no guarded verb at all. `get`, `list`,
   `search`, `describe`, `read`, `count`, `preview`, `validate`, `fetch`, `query`,
   `find` and friends pass with no decision. Without this every lookup becomes a
   prompt and the team disables the gate inside a week.
3. **Explicit guarded list.** A short list of exact action names with their class,
   for the cases the verb matcher would get wrong. Matched on the full name and on
   the operation segment after the last `__`, because the namespace is the half
   that rots: the same payments write arrives under a repackaged namespace and a
   full-name-only match reads as coverage while opening a hole.
4. **Not-guarded list.** Narrow patterns for the internal reversible work below.
5. **Two compound rules.** Adding contacts to a campaign or a sequence is outward
   facing even though its name carries no outward verb, and so is editing the copy
   or the schedule of a campaign that is already running: it reaches the same
   people. Creating or replacing a live automation is a production mutation
   whatever verb the connector chose for it.
6. **Verb matcher.** Matches the capability verb across every namespace:
   delete, destroy, purge, drop, truncate, merge, reset, bulk, push, upsert on
   the destructive class; execute, deploy, migrate, apply, run, restore, sql on
   the production class; send, reply, message, activate, resume, start, launch,
   enable, publish, refund, invoice, subscribe, cancel on the outward class.
7. **The write family**, scoped to `mcp__` actions. Create, update, edit, patch,
   set, add, sync, archive, disable and manage land on the destructive class, so
   the owner gets a warned allow on routine work and everyone else confirms once.
   Export, webhook, writeback and forward land on the outward class, because data
   leaving for a third party cannot be recalled. Scoped to connected systems on
   purpose: the local file tools tokenise to the same verbs, they are reversible
   and internal by definition, and guarding them is the treadmill.
8. **Shell companion patterns**, for the same capabilities reached from a shell.

Steps 6 and 7 are the coverage story and steps 3 and 4 are the exceptions to it. A
hand-written list of action names is a snapshot: connectors get renamed,
versioned, and replaced by a successor with the same capability under a new
namespace, and none of that produces an error. The gate keeps passing its own
tests while exiting clean on actions it was built to stop. Matching the verb
means **a newly connected system is guarded by default rather than unguarded by
default**, so forgetting to update a list costs one approval rather than an
exposure.

Two maintenance rules keep it honest.

**Run the twin test whenever you connect a system.** If `resume` is guarded, is
`start`? If the singular is guarded, is the bulk variant? Is the same capability
reachable through a second connector, or through a shell call to the same
endpoint? Does a v2 exist under a new name? Gaps cluster on functional twins,
and the twin added later is usually the open one.

**When a verb match produces routine friction on something genuinely
reversible**, add a narrow pattern to the not-guarded block rather than deleting
a verb from the matcher.

---

## Deliberately not guarded

Published here with the reasoning, because an omission reads as an oversight and
produces either over-caution or a permission request every single time, while a
stated exclusion is a decision a reviewer can challenge.

| Not guarded | Why |
|---|---|
| Internal team messaging | Reversible, internal, low blast radius |
| Mail drafts | Nothing leaves until a human sends it |
| Calendar writes | Trivially undone |
| Issues, comments and pull requests in your code host | Reviewable before they change anything |
| Reads of any kind | A lookup that needs an approval is why teams disable gates |

Over-guarding reversible internal work produces the approval treadmill, and the
treadmill is what gets the whole gate switched off.

**Known gaps, stated rather than implied.** A message to an externally shared
channel in your team chat is outward facing and this gate treats all team chat
as internal, so move that connector into the explicit guarded list if you use
shared channels with customers. Identity resolves from the repository config, so
anything able to write that config can change the tier it resolves to. The shell
patterns are deliberately narrow, so a sufficiently rewritten command can miss
them. A connector exposing arbitrary SQL under a bare read name, `query` with
nothing else in the name to give it away, is indistinguishable from a lookup and
passes the allowlist: put it in the explicit guarded list the day you connect it.
The write family is classed destructive-internal, which is a decision about where
the approval budget goes rather than a claim that a CRM write is recoverable, so
name the ones that mutate production in your stack at production-mutation. And the
write family is scoped to `mcp__` names, so a second local edit tool under another
name is not covered by it.

The list in the script's own header is the authoritative copy of this. If you edit
the guard, edit that header in the same change.

---

## Approvals

Three classes. The difference between them is entirely what the approval is
bound to, and getting the binding wrong is how a gate stays intact while
controlling nothing.

| Class | Binds to | Lifetime | Available on | Who creates it |
|---|---|---|---|---|
| Per-call | A hash of the full canonical payload | Single use, deleted on redemption, expires with the TTL | Any class | The model, after stating the effect and getting a yes in session |
| Batch | The operation name only | Multi-use inside the TTL | Destructive internal only | The model, after one stated approval covering the described run |
| Two-person | A hash of the full canonical payload | Single use, deleted on redemption | Irreversible classes | An owner, at their own keyboard. Never the model |

**Per-call is bound to the payload.** That is the difference between "you may
send a message" and "you may send this message to this person". The canonical
form is the action name plus the whole tool input with keys sorted, hashed with
sha256. Never a prefix: hashing the opening few hundred characters produces real
collisions, and two outreach messages that share an opening and diverge in the
body then map to one approval file, so approving the first silently authorises
the second. Case 17 in the test harness fires exactly that payload pair.

**Batch is bound to the operation** and throws the payload away on purpose. The
failure it prevents is not technical bypass, it is human rubber-stamping: a
row-by-row run that prompts two hundred times trains the operator to approve
without reading, and one informed approval covering a described run is a
stronger control than two hundred unread ones. Ask once, say plainly that the
approval covers the whole run and what the run consists of, then mint it.

Batch is unavailable outside the destructive internal class, enforced by an
explicit tier check in the script rather than by convention, and the batch
instruction is never printed on an irreversible block. "Approve once, send to
everyone" is the exact catastrophe the irreversible classes exist to prevent, and
an operator who learns the batch line from a top-tier block message will try it.

When an irreversible run genuinely needs many approvals, restructure the run
into one reviewable payload rather than weakening the class. Stage it as a single
job whose payload is the full list, so one payload-bound approval covers the run
and the human approves the actual thing that will execute.

**TTL is 900 seconds**, overridable with `SAFETY_GUARD_TTL` for a long-running
supervised run. Long enough for one run, short enough that the next session
cannot inherit it. An expired approval is deleted on sight and the next block
message says an approval was found but had expired, because a silently ignored
expired approval reads as the gate malfunctioning. Session close clears every
remaining token.

### What the two-person control actually proves

A two-person approval implemented as a token in a shared filesystem proves that
somebody with write access to that directory was present at a keyboard. It does
not prove identity, because any process able to write that directory can mint
the file. That limitation belongs next to the guarantee. A control that claims
to be a real two-key mechanism while resting on a shared filesystem is lying to
its own operators, and the moment somebody discovers that, they stop trusting
every other claim the gate makes.

The same applies to the per-call approval the model mints after an in-session
yes: it proves the model asserts a human approved, not that the human read
anything. That is why the block message forces the model to state the recipient,
the content and the target system first, and why the payload binding matters.

Honest upgrades, in increasing cost order:

1. Require the token to be minted from a second machine.
2. Sign the token with a key the agent process cannot read.
3. Move approval to an out-of-band channel the model cannot write to, and have
   the gate poll for the decision.

---

## The block message

Written to **stderr**, because that is what the runtime feeds back to the model
on a blocking exit. A block message on stdout is a message the model may never
see. It is addressed to the model in the second person, because the model is
what reads it at decision time.

A real block, captured from the gate, with the hash shortened to fit:

```
BLOCKED - irreversible-outward operation requires approval.

Effect: mcp__instantly__reply_to_email on instantly reaches a person outside the company or moves money, and cannot be recalled.
Recipient: maria@prospect.example
Content: Re: your GTM stack
Campaign or list: c-441
Acting identity: newjoiner@example.com (tier: team)

Before asking for approval, tell the user exactly what you are about to do:
the recipient, the content, and the target system.

This is a two-person operation. You must NOT create the approval file.
Ask an owner to create it themselves, at their own keyboard, at:
  /tmp/.claude-safety/two-person-3fb29d06d696...

Report back to the user that the action is waiting on owner approval, and
state what you will do once it lands.

Never work around this gate with a raw API call, a different tool, or a
rewritten command. If the user declines, stop and report what was not done.
```

Every line is load-bearing. The tier name stops the model treating a non-zero
exit as a transient error and retrying. The effect line lets a human decide
without opening another system. The extracted fields exist because a
four-kilobyte payload dump gets approved without being read, so the gate
surfaces two or three decision-relevant values truncated to 200 characters and
never the raw payload. The identity line stops a user assuming the gate is
broken when they are silently on the strictest tier, and an unresolved identity
gets told exactly how to fix it. The unblock command stops the session dead
ending, which is the state a capable agent talks itself out of by improvising.
The anti-circumvention line exists because a capable agent treats a blocked
action as a routing problem and reaches for the underlying endpoint.

---

## The audit log

Tab-separated, one row per decision, at `~/.claude/safety-guard.log` unless you
set `SAFETY_GUARD_LOG`.

| Field | Content |
|---|---|
| 1 | UTC timestamp |
| 2 | Acting identity, or `none` |
| 3 | User tier |
| 4 | Operation class |
| 5 | Operation |
| 6 | Decision |
| 7 | Extracted fields, truncated to 160 characters |

Eleven decision values, four of which are allows: `warned-owner`,
`allowed-confirm`, `allowed-batch`, `allowed-two-person`, `blocked-confirm`,
`blocked-two-person`, `blocked-dependency`, `blocked-unparseable`,
`blocked-unparsed`, `synthetic-block`, `session-sweep`.

Keeping the allow values separate is the point. The tuning question is which
gates fire so often that people approve them without reading, and block rows
alone cannot answer it. Read the log before you read the script.

```bash
# which operations are being approved most often, the rubber-stamp candidates
cut -f5,6 ~/.claude/safety-guard.log | sort | uniq -c | sort -rn | head

# everything that was actually stopped this week
grep blocked- ~/.claude/safety-guard.log | cut -f1,2,4,5
```

The log rotates in band: above 2MB it truncates to the last 2,000 lines before
appending, because the gate fires on every action and the log must never become
the reason the gate is slow.

### Prove that silence is silence

An audit log holding two same-minute rows from installation day cannot
distinguish a well-tuned gate from one that has never been invoked. Fix that by
construction:

```bash
# every morning, fire a payload built to block and tag the row it produces.
# </dev/null because a scheduler hands the job an stdin it never closes, and a
# probe waiting on stdin is a probe that never reports.
0 9 * * * bash "/path/to/project/.claude/hooks/safety-guard.sh" --synthetic </dev/null
```

The probe is a real call through the same script, not a row written directly, so
it exercises the parser, the classifier, the matrix and the log in one pass. It
exits 0 when the payload was blocked as intended and non-zero when it was not,
which is the cheap signal that the gate has stopped working. Alert on both the
non-zero exit and the row's absence, rather than shrugging at an empty log.

---

## Verification

Reading the script proves the author's intent. Firing payloads proves the
behavior, and the two diverge more often than anyone expects.

```bash
bash .claude/hooks/safety-guard-test.sh
```

The harness redirects `HOME`, the approval directory and the log to a scratch
path, builds a throwaway repository per identity so the tier resolves the way it
will in production, and asserts an exit code and a message for every cell. Run
it after every edit to the guard. `.github/workflows/safety-guard.yml` runs it on
every proposed change to the gate and on every direct push to the default
branch, and prints the guard's sha256 so a reviewer can compare it against the
copy on their own machine.

These cases exist because a production gate got them wrong.

- **Case 11** puts the action name at byte 462 of the payload. A gate that scans
  only the opening bytes for a marker exits 0 here, silently, with no log row.
- **Case 12** mints a batch key for an irreversible action and asserts it stays
  blocked. This proves the tier check is a check rather than a convention.
- **Case 17** fires two messages sharing a 340-character opening and asserts they
  do not share an approval.
- **Case 25** removes `jq` from the path and asserts the gate blocks with a
  one-line install fix, rather than waving the action through.
- **Cases 38 to 46** fire real connector names rather than invented ones. Every
  one of them exited 0, silently, before the guarded-verb veto and the write
  family existed, while a near-twin name blocked and the suite stayed green. An
  invented test name that happens to dodge a collision is a pass over a hole.
- **Cases 50 to 57** fire payloads the gate cannot read: truncated JSON, a body
  that is not JSON, the action under a different key, the action nested deeper, a
  top-level array. Each must block and leave a row. Empty stdin is the one clean
  exit.
- **Case 58** writes an oversized payload through the session logger and asserts
  every line of the resulting file parses. The evidence trail is only evidence if
  it can be read.

Before you call the gate installed:

- [ ] Every cell of the matrix fired against a synthetic payload, with the
      observed exit codes recorded next to the intended ones.
- [ ] A blocking exit actually blocks. Confirm your runtime surfaces the
      non-zero exit to the model as an error rather than as a note.
- [ ] Every write path is registered, not only the one the agent usually uses.
      List them first: the action interface, the shell, a push to version
      control, a scheduled run under a non-interactive identity, and any second
      agent with its own identity. Write any path you could not cover into the
      known-gaps list before enabling.
- [ ] The gate is installed at every location the runtime reads, not only this
      project. A gate in the project config and absent from the machine-global
      one covers exactly the sessions that happen to start in the project. See
      step 2b above.
- [ ] All deployed copies are byte-identical, verified by hash. Copies drifting
      apart presents as "the gate behaves differently on my machine".
      `shasum -a 256 .claude/hooks/safety-guard.sh ~/.claude/hooks/safety-guard.sh`
- [ ] The roster file exists on the machine that needs it. A roster feature that
      ships with no roster present anywhere is dormant rather than deployed,
      which is why session start announces a missing one.
- [ ] The scheduled synthetic block is running.

---

## There is no fast path, and do not add one

The tempting optimisation is to scan the first few hundred bytes of the payload
for an action marker and exit clean when it is absent. That optimisation was
measured on a production gate. A realistic payload ordering put the action name
at byte 299, the marker fell outside a 200-byte window, and the same top-tier
action returned exit 0 with no output and no audit row. It silently disabled
every gate in the script, and it saved microseconds against a multi-second hook
budget.

This guard scans the whole input, and the comment saying why sits at the read.
Case 11 in the harness is the regression test.

The same reasoning covers a payload the parser cannot read, which is the identical
failure wearing different clothes: `.tool_name` comes back empty for a truncated
body, for a body that is not JSON, and for a payload carrying the action under
another key, and an empty action name used to read as "no action here" and exit 0
with no row. Those all block now, with a row naming the reason. The one clean exit
is genuinely empty stdin. Cases 50 to 57 are the regression tests.

The read is also gated on the mode, so `--session-start`, `--session-end` and
`--synthetic` do not wait on stdin. They take no payload, and an unconditional read
made each of them block until EOF, which hung the verification step above for
anyone running it at a terminal.

---

## Behavioral invariants

Do not remove these while editing.

- Non-zero exit blocks. A warning plus a success exit is advice, and the model
  is free to route around advice.
- Fail closed when the gate's own dependencies are missing, with a one-line fix.
- Fail closed on a payload the gate cannot parse or cannot find an action in.
  Empty stdin is the only clean exit, and every block leaves a row.
- The read allowlist never beats a guarded verb in the same name.
- The gate reads stdin in gate mode only. The session and probe modes take no
  payload and must not wait on one.
- Per-call approvals hash the full canonical payload. Batch approvals key on the
  operation.
- Batch is unavailable outside the destructive internal class, enforced by an
  explicit tier check, and the batch instruction is never printed on an
  irreversible block.
- An unresolved identity resolves to the strictest tier, and the block message
  says how to fix the identity.
- The model never mints a two-person approval, and the block message says so.
- Allows are logged, not only blocks, and the log rotates in band.
- The not-guarded list stays published with its reasoning, and the known gaps
  stay listed beside it.
- Every blocking mechanism has a cap and a defined behavior after the cap, so an
  agent is never trapped by an unsatisfiable condition. This gate blocks one
  action at a time and never blocks session close, so it needs no cap. If you
  add a session-close gate, stop it blocking after two attempts and have it
  instruct the model to state plainly what is unresolved and why.

---

## Build approval is not send approval

The gate stops one action. It cannot tell you the copy is right.

The recurring failure: a broadcast is genuinely authorised to be built and
triggered, tested for mechanics only, never read as a recipient would see it,
and then fired at the full list. Every message has to be retracted one recipient
at a time.

The replacement is a staged rollout, run as a hard sequence: send to three to
five real recipients, read the rendered result rather than the payload, correct
the copy, delete the tests, then launch the remainder. And keep conditional
logic out of the irreversible step: resolve every condition upstream into one
inspectable boolean and let the send read that single field.

---

## The other two hooks

### session-logger.sh

Writes a JSONL transcript per session to `.claude/sessions/`. That directory is
gitignored.

Every line has to parse, and that is a behavioral invariant rather than a nicety:
`jq` aborts at the first malformed record instead of skipping it, so one bad line
takes the whole file down and the payloads worth inspecting are the large ones.
Values from the payload are encoded by `jq` before they reach the line, and the
tool input is truncated inside `jq` and re-emitted as a string. It reads as a
string rather than an object for that reason. Byte-truncating an already encoded
object and interpolating the fragment raw is what made most `Write` and `Edit`
records invalid, which is every record above a kilobyte.

```bash
ls -lt .claude/sessions/ | head
cat .claude/sessions/<session_id>.jsonl | jq .
cat .claude/sessions/*.jsonl | jq -e . >/dev/null && echo "every line parses"
cat .claude/sessions/*.jsonl | grep '"tool_start"' | jq -r '.tool' | sort | uniq -c | sort -rn
grep '"tool_fail"' .claude/sessions/*.jsonl | jq '{tool: .tool, error: .error}'
find .claude/sessions -mtime +30 -delete
```

### notify.sh

Native notification when the agent needs attention. Uses `osascript` on macOS,
`notify-send` on Linux, and falls back to stderr. Useful when you step away
during a long run, and the reason a permission request does not sit unanswered.

It exits 0 on every path, including a missing `jq`, because a notifier that can
block a tool call is worse than no notifier. And nothing from the payload is
interpolated into a script: the message on a `Notification` event comes from the
payload, and a value carrying a double quote would close the AppleScript string so
that everything after it ran as AppleScript in your own session. Values are passed
as arguments and read inside the script, stripped of control characters and capped.
A safety kit does not ship a notifier whose input reaches an interpreter.

---

## Lifecycle events

| Event | Fires | Used for |
|---|---|---|
| `SessionStart` | Session begins or resumes | Guard policy banner, expired-approval sweep, notification |
| `UserPromptSubmit` | Each prompt | Logging |
| `PreToolUse` | Before every action | **The gate.** Exit 0 allows, exit 2 blocks and feeds stderr to the model |
| `PostToolUse` | After a successful action | Logging |
| `PostToolUseFailure` | After a failed action | Error tracking |
| `Stop` | The agent finishes a response | Notification, logging |
| `PermissionRequest` | The agent needs approval | Notification |
| `SubagentStop` | A sub-agent finishes | Notification |
| `PreCompact` | Before context compaction | Snapshot session stats |
| `SessionEnd` | Session closes | Approval sweep, summary, notification |

Every hook receives JSON on stdin:

```json
{
  "hook_event_name": "PreToolUse",
  "session_id": "abc-123-def",
  "cwd": "/path/to/project",
  "tool_name": "Bash",
  "tool_input": { "command": "git push --force" }
}
```

---

## Configuration

All optional, all environment variables.

| Variable | Default | Purpose |
|---|---|---|
| `SAFETY_GUARD_ROSTER` | `.claude/safety-roster`, then `~/.claude/safety-roster` | Tier roster path |
| `SAFETY_GUARD_TTL` | `900` | Approval lifetime in seconds |
| `SAFETY_GUARD_APPROVAL_DIR` | `${TMPDIR:-/tmp}/.claude-safety` | Where approval tokens live. Everything with write access here can mint an approval |
| `SAFETY_GUARD_LOG` | `~/.claude/safety-guard.log` | Audit log path |
| `SAFETY_GUARD_LOG_MAX` | `2000000` | Rotate above this many bytes |

---

## Troubleshooting

**The gate never fires.** Check it is registered on every path, not only the one
you tested. Check the script is executable. Check `jq` is on the path the
runtime uses, which is not always your shell's path. Then run the harness: if
the harness passes and real sessions never produce a log row, the problem is
registration rather than logic.

**Everything is blocked.** You have no roster, so every identity is on the
strictest tier. Session start says so on every session. Copy the example and put
your committer email under `owner:`.

**One routine action keeps prompting.** It matched a guarded verb. If it is
genuinely reversible and internal, add a narrow pattern to the not-guarded block.
If it is not, that prompt is the gate working.

**The block message is not reaching the model.** It goes to stderr, which the
runtime feeds back on a blocking exit. If you edited the script and moved a
message to stdout, the model will not see it on a block.

**Tiers behave differently on two machines.** Hash the deployed copies. They are
meant to be byte-identical, with the per-machine difference living in the roster
file and nowhere else.
