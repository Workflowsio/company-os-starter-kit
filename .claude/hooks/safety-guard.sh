#!/usr/bin/env bash
# =============================================================================
# safety-guard.sh - pre-action approval gate for agents with write access
# =============================================================================
#
# Install this the moment the agent can reach a real person, move money, mutate
# a production automation, or delete records. It is mandatory when permission
# prompts are disabled or the agent runs unattended on a schedule, because with
# prompts off this gate is the only thing between the model and the action.
#
# MODES
#   (no args)         pre-action gate. Reads the pending action as JSON on stdin.
#   --session-start   prints the active policy, sweeps expired approvals.
#   --session-end     sweeps every approval so none is inherited by the next run.
#   --synthetic       fires a payload designed to block and logs one tagged row,
#                     so silence in the audit log is provable rather than assumed.
#
# EXIT CODES (the exit code is the API)
#   0  allow. On a warned allow the notice goes to stdout.
#   2  block. The runtime feeds stderr back to the model as a blocking error,
#      which is why every block message in this script is written to stderr.
#      A warning printed with a success exit is advice, and the model is free
#      to route around advice.
#
# -----------------------------------------------------------------------------
# THE FOUR OPERATION CLASSES (blast radius, not how technical the action feels)
# -----------------------------------------------------------------------------
#   irreversible-outward  Reaches a person outside the company, or moves money.
#                         Sends and replies, campaign activation and resume,
#                         adding contacts to a live sequence, invoices, refunds,
#                         subscription changes.
#   production-mutation   Changes a running system other people's work depends
#                         on. Live SQL, schema migrations, function deploys,
#                         creating or replacing a production automation.
#   destructive-internal  Deletes or bulk-mutates internal records. Recoverable
#                         only if a backup exists.
#   reversible-internal   Internal, low blast radius, trivially undone. Not
#                         guarded. See the list below.
#
# A campaign activation feels routine and live SQL feels dangerous, but the
# activation is the one that reaches every contact on the list and cannot be
# recalled. Classify by consequence.
#
# -----------------------------------------------------------------------------
# THE TIER MATRIX
# -----------------------------------------------------------------------------
#                     reversible  destructive  production  irreversible
#   owner             allow       WARN+allow   confirm     confirm
#   trusted           allow       confirm      confirm     confirm
#   team              allow       confirm      two-person  two-person
#   unresolved        allow       confirm      two-person  two-person
#
# The owner-warning cell is load-bearing. A gate that blocks its own author on
# every destructive command is switched off inside a week, and a switched-off
# gate protects nobody at any tier. Unresolved is not a fourth tier, it is a
# fallback that resolves to the strictest one.
#
# -----------------------------------------------------------------------------
# DELIBERATELY NOT GUARDED, AND WHY
# -----------------------------------------------------------------------------
#   Internal team messaging      Reversible, internal, low blast radius. Guarding
#   Mail drafts                  it produces the approval treadmill that gets the
#   Calendar writes              whole gate turned off, which costs more than
#   Issues, comments, PRs        every one of these actions is worth.
#   Reads of any kind            A lookup that needs an approval is why teams
#                                disable gates. See the read allowlist below.
#
# KNOWN GAPS, stated rather than implied:
#   1. A message to an externally shared channel in your team chat is outward
#      facing and this gate treats all team chat as internal. If you use shared
#      channels with customers, move that connector into EXPLICIT_GUARDED.
#   2. Identity resolves from the version-control committer email, so anything
#      able to write the repository config can change the tier it resolves to.
#      That is the same trust boundary as the approval directory. Both are
#      presence controls, not identity controls.
#   3. The shell companion patterns are deliberately narrow, so a determined
#      rewrite of a command can miss them. Add hostnames under guarded-hosts in
#      the roster to cover direct calls to your live systems.
#   4. A connector exposing arbitrary SQL under a bare read name, `query` with
#      nothing else in the name, is indistinguishable from a lookup by name and
#      passes the read allowlist. A name carrying `sql` is caught. Put a bare one
#      in EXPLICIT_GUARDED the day you connect it.
#   5. The write family (create, update, edit, patch, set, add, sync, manage) is
#      classed destructive-internal, so the owner gets a warned allow and everyone
#      else confirms once per payload. That is a friction choice, not a claim that
#      those writes are recoverable. If one of them mutates production in your
#      stack, name it in EXPLICIT_GUARDED at production-mutation.
#   6. The write family is scoped to `mcp__` names, so a second local edit tool
#      under a different name is not covered by it. Register every write path.
#
# -----------------------------------------------------------------------------
# CONFIGURATION (all optional, all environment variables)
# -----------------------------------------------------------------------------
#   SAFETY_GUARD_ROSTER        tier roster path. Default: .claude/safety-roster
#                              in this project, then ~/.claude/safety-roster.
#   SAFETY_GUARD_TTL           approval lifetime in seconds. Default 900.
#   SAFETY_GUARD_APPROVAL_DIR  where approval tokens live. Default
#                              ${TMPDIR:-/tmp}/.claude-safety
#   SAFETY_GUARD_LOG           audit log path. Default ~/.claude/safety-guard.log
#   SAFETY_GUARD_LOG_MAX       rotate above this many bytes. Default 2000000.
# =============================================================================

MODE="${1:-gate}"

# -----------------------------------------------------------------------------
# In gate mode, read the WHOLE input. There is no fast path here, on purpose.
#
# The tempting optimisation is to scan the first few hundred bytes for a tool
# marker and exit 0 when it is absent. That optimisation was measured on a
# production gate: a realistic payload ordering put the tool name at byte 299,
# the marker fell outside a 200-byte scan window, and the same top-tier action
# returned exit 0 with no output and no audit row. It silently disabled every
# gate in the script. The saving was microseconds against a multi-second hook
# budget. If you are about to add a prefix scan back, read this paragraph again.
#
# The read is gated on the mode rather than run unconditionally, because the
# session and probe modes take no payload: an unconditional `cat` makes them
# block on stdin until EOF, which hangs the documented verification step for a
# human at a terminal. Gate mode still reads every byte.
# -----------------------------------------------------------------------------
case "$MODE" in
  gate) INPUT=$(cat) ;;
  *)    INPUT="" ;;
esac

TTL="${SAFETY_GUARD_TTL:-900}"
APPROVAL_DIR="${SAFETY_GUARD_APPROVAL_DIR:-${TMPDIR:-/tmp}/.claude-safety}"
LOG_FILE="${SAFETY_GUARD_LOG:-$HOME/.claude/safety-guard.log}"
LOG_MAX="${SAFETY_GUARD_LOG_MAX:-2000000}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# =============================================================================
# Audit log: one tab-separated row per decision, allows included
# =============================================================================
# Fields: timestamp, identity, user tier, action class, operation, decision, detail
# Decisions: warned-owner, allowed-confirm, allowed-two-person, allowed-batch,
#            blocked-confirm, blocked-two-person, blocked-dependency,
#            blocked-unparseable, blocked-unparsed, synthetic-block, session-sweep
#
# Keeping the allow values separate is the point. Collapsing them makes the only
# question worth asking of this file unanswerable: which gates fire so often
# that people approve them without reading.
rotate_log() {
  [ -f "$LOG_FILE" ] || return 0
  local size
  size=$(wc -c < "$LOG_FILE" 2>/dev/null | tr -d ' ')
  [ -z "$size" ] && return 0
  if [ "$size" -gt "$LOG_MAX" ]; then
    tail -n 2000 "$LOG_FILE" > "$LOG_FILE.tmp" 2>/dev/null && mv "$LOG_FILE.tmp" "$LOG_FILE"
  fi
}

log_decision() {
  local action_class="$1" decision="$2" detail="$3"
  # A run started by --synthetic tags its own row, so a probe is never mistaken
  # for a real block during a tuning pass.
  if [ -n "${SAFETY_GUARD_SYNTHETIC:-}" ]; then
    case "$decision" in blocked-*) decision="synthetic-block" ;; esac
  fi
  mkdir -p "$(dirname "$LOG_FILE")" 2>/dev/null
  rotate_log
  detail=$(printf '%s' "$detail" | tr '\t\n' '  ' | cut -c1-160)
  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
    "${IDENTITY:-none}" \
    "${USER_TIER:-unresolved}" \
    "$action_class" \
    "${OPERATION:-unknown}" \
    "$decision" \
    "$detail" >> "$LOG_FILE"
}

# =============================================================================
# Dependencies: fail CLOSED, with a one-line install fix, and log the row
# =============================================================================
# A gate that waves an action through because its own parser is missing is not
# a gate. The row matters too: a dependency failure that leaves no trace looks
# exactly like a gate nobody ever triggered.
fail_closed() {
  {
    echo "BLOCKED - the safety gate cannot run, so nothing is allowed through."
    echo ""
    echo "Missing dependency: $1"
    echo "Install it with: $2"
    echo ""
    echo "Tell the user the gate is down and what you were about to do. Never work"
    echo "around this with a raw API call, a different tool, or a rewritten command."
  } >&2
  log_decision "dependency" "blocked-dependency" "missing:$1"
  exit 2
}

command -v jq >/dev/null 2>&1 || fail_closed "jq" "brew install jq   (or: sudo apt install jq)"

if command -v shasum >/dev/null 2>&1; then
  HASH_CMD="shasum -a 256"
elif command -v sha256sum >/dev/null 2>&1; then
  HASH_CMD="sha256sum"
else
  fail_closed "shasum or sha256sum" "brew install coreutils   (or: sudo apt install coreutils)"
fi

# =============================================================================
# Identity and tier
# =============================================================================
# Resolved from the version-control committer email, lowercased. An identity
# that does not resolve gets the strictest tier, never the friendliest one. A
# gate that assumes a friendly identity when it cannot find one is bypassed by
# running it where identity is unconfigured, which is exactly what a scheduled
# or unattended run looks like.
resolve_identity() {
  local email
  email=$(git config user.email 2>/dev/null)
  [ -z "$email" ] && email=$(git config --global user.email 2>/dev/null)
  printf '%s' "$email" | tr '[:upper:]' '[:lower:]'
}

# Built-in tier lists ship EMPTY. Fill the roster file instead: the script is
# deployed byte-identically to several locations, and a promotion must never be
# an N-file edit. A key present in the roster REPLACES the built-in list for
# that tier rather than extending it.
BUILTIN_OWNERS=""
BUILTIN_TRUSTED=""

ROSTER_PATH=""
find_roster() {
  if [ -n "${SAFETY_GUARD_ROSTER:-}" ]; then
    ROSTER_PATH="$SAFETY_GUARD_ROSTER"
    return
  fi
  if [ -f "$SCRIPT_DIR/../safety-roster" ]; then
    ROSTER_PATH="$SCRIPT_DIR/../safety-roster"
    return
  fi
  if [ -f "$HOME/.claude/safety-roster" ]; then
    ROSTER_PATH="$HOME/.claude/safety-roster"
    return
  fi
  ROSTER_PATH="$SCRIPT_DIR/../safety-roster"
}

roster_value() {
  # Reads "key: a@x.com, b@x.com" and returns " a@x.com b@x.com " lowercased.
  local key="$1" line
  [ -f "$ROSTER_PATH" ] || return 1
  line=$(grep -iE "^[[:space:]]*${key}[[:space:]]*:" "$ROSTER_PATH" 2>/dev/null | head -1)
  [ -z "$line" ] && return 1
  printf ' %s ' "$(printf '%s' "${line#*:}" | tr ',' ' ' | tr -s ' ' | tr '[:upper:]' '[:lower:]' | sed 's/^ *//; s/ *$//')"
}

find_roster
IDENTITY=$(resolve_identity)
OWNERS=$(roster_value owner) || OWNERS=" $BUILTIN_OWNERS "
TRUSTED=$(roster_value trusted) || TRUSTED=" $BUILTIN_TRUSTED "
GUARDED_HOSTS=$(roster_value guarded-hosts) || GUARDED_HOSTS=" "

if [ -z "$IDENTITY" ]; then
  USER_TIER="unresolved"
elif printf '%s' "$OWNERS" | grep -qF " $IDENTITY "; then
  USER_TIER="owner"
elif printf '%s' "$TRUSTED" | grep -qF " $IDENTITY "; then
  USER_TIER="trusted"
else
  USER_TIER="team"
fi

# =============================================================================
# Session modes
# =============================================================================
sweep_approvals() {
  # $1 = "expired" or "all"
  local removed=0 f
  [ -d "$APPROVAL_DIR" ] || { printf '0'; return 0; }
  for f in "$APPROVAL_DIR"/*; do
    [ -e "$f" ] || continue
    if [ "$1" = "all" ]; then
      rm -f "$f" && removed=$((removed + 1))
    else
      local age
      age=$(( $(date +%s) - $(stat -f %m "$f" 2>/dev/null || stat -c %Y "$f" 2>/dev/null || echo 0) ))
      if [ "$age" -gt "$TTL" ]; then rm -f "$f" && removed=$((removed + 1)); fi
    fi
  done
  printf '%s' "$removed"
}

if [ "$MODE" = "--session-start" ]; then
  removed=$(sweep_approvals expired)
  guard_hash=$($HASH_CMD "${BASH_SOURCE[0]}" 2>/dev/null | cut -c1-12)
  echo "Safety guard active. Identity: ${IDENTITY:-unresolved} (tier: $USER_TIER)."
  if [ -f "$ROSTER_PATH" ]; then
    echo "Roster: $ROSTER_PATH. Approvals: $APPROVAL_DIR. TTL ${TTL}s. Guard sha256: $guard_hash."
  else
    echo "Roster: $ROSTER_PATH is MISSING, so every identity resolves to the strictest"
    echo "tier and the roster feature is dormant. Copy .claude/safety-roster.example to"
    echo "that path and put your own address under owner: before relying on the tiers."
    echo "Approvals: $APPROVAL_DIR. TTL ${TTL}s. Guard sha256: $guard_hash."
  fi
  [ "$removed" -gt 0 ] && echo "Swept $removed expired approval token(s)."
  exit 0
fi

if [ "$MODE" = "--session-end" ]; then
  # Everything goes, not just the expired ones. A batch key that survives the
  # session it was approved for is a key the next session inherits.
  removed=$(sweep_approvals all)
  if [ "$removed" -gt 0 ]; then
    OPERATION="session-end"
    log_decision "reversible-internal" "session-sweep" "cleared $removed approval token(s)"
  fi
  exit 0
fi

if [ "$MODE" = "--synthetic" ]; then
  # Actually fires a payload built to block, through this same script, and tags
  # the resulting row. Without it, an empty audit log means either a well-tuned
  # gate or a gate that has never run once, and nobody can tell which.
  #
  # Schedule it, and alert on a non-zero exit as well as on a missing row: this
  # mode exits non-zero when the probe was NOT blocked, which is the only cheap
  # signal that the gate has stopped working.
  probe='{"tool_name":"mcp__safety_probe__delete_all_records","tool_input":{"probe":"synthetic","records":["a","b"]}}'
  probe_out=$(printf '%s' "$probe" | SAFETY_GUARD_SYNTHETIC=1 SAFETY_GUARD_ROSTER=/nonexistent \
    bash "${BASH_SOURCE[0]}" 2>&1)
  probe_code=$?
  if [ "$probe_code" = 2 ]; then
    echo "Synthetic probe blocked as expected. Row tagged synthetic-block in $LOG_FILE"
    exit 0
  fi
  echo "SAFETY GUARD PROBE FAILED: a payload built to block exited $probe_code." >&2
  echo "$probe_out" >&2
  exit 1
fi

if [ "${MODE#--}" != "$MODE" ]; then
  echo "safety-guard.sh: unknown mode '$MODE'. Use --session-start, --session-end or --synthetic." >&2
  exit 2
fi

# =============================================================================
# Parse the pending action
# =============================================================================
# UNPARSEABLE IS NOT EMPTY. A payload the parser cannot read is the same shape as
# a gate nobody triggered: exit 0, no output, no row. Truncated JSON is exactly
# what an oversized or partially written payload looks like, and `.tool_name`
# comes back empty for a body that is not JSON at all, for a body that carries
# the action under a different key, and for a body nested one level deeper. All
# three of those are a broken assumption about the runtime, not an idle call, so
# they block and leave a row rather than passing quietly.
if [ -n "$INPUT" ] && ! printf '%s' "$INPUT" | jq -e . >/dev/null 2>&1; then
  {
    echo "BLOCKED - the safety gate could not parse the pending action, so nothing"
    echo "is allowed through."
    echo ""
    echo "The payload on stdin is not valid JSON. That is a broken assumption about"
    echo "this runtime's hook payload shape, not an idle call, so the gate fails"
    echo "closed rather than waving the action past unread."
    echo ""
    echo "Tell the user the gate cannot read the payload and what you were about to"
    echo "do. Never work around this with a raw API call, a different tool, or a"
    echo "rewritten command."
  } >&2
  OPERATION="unparseable"
  log_decision "unparseable" "blocked-unparseable" "$(printf '%s' "$INPUT" | tr '\t\n' '  ' | cut -c1-80)"
  exit 2
fi

TOOL_NAME=$(printf '%s' "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null)
TOOL_INPUT=$(printf '%s' "$INPUT" | jq -c 'if (.tool_input|type) == "object" then .tool_input else {} end' 2>/dev/null)
[ -z "$TOOL_INPUT" ] && TOOL_INPUT='{}'

# Genuinely empty stdin is the only clean exit here: there is no action in it.
[ -z "$INPUT" ] && exit 0

# Parsed, but no action under .tool_name. The JSON is well formed and the field
# this gate depends on is not in it, which means the payload shape changed under
# the gate. Same reasoning as above: block, and leave a row naming the keys that
# were present so the shape is fixable rather than guessable.
if [ -z "$TOOL_NAME" ]; then
  {
    echo "BLOCKED - the safety gate found no action in the pending payload."
    echo ""
    echo "The payload parsed as JSON and carries no .tool_name field, so the gate"
    echo "cannot classify what is about to happen. A gate that shrugs at a payload"
    echo "shape it does not recognise is a gate that is off."
    echo ""
    echo "Check the hook payload shape your runtime sends, and tell the user the"
    echo "gate is not reading this runtime correctly."
  } >&2
  OPERATION="no-action-field"
  log_decision "unparseable" "blocked-unparsed" "keys:$(printf '%s' "$INPUT" | jq -r 'if type == "object" then (keys | join(",")) else type end' 2>/dev/null | cut -c1-80)"
  exit 2
fi

TOOL_LC=$(printf '%s' "$TOOL_NAME" | tr '[:upper:]' '[:lower:]')

# Tokenise the action name so verb matching is exact rather than substring
# matching. camelCase is split first, then underscores and dashes become
# spaces. " mcp hubspot delete records " matches " delete " and never matches
# a name that merely contains those letters.
TOKENS=" $(printf '%s' "$TOOL_NAME" \
  | sed 's/\([a-z0-9]\)\([A-Z]\)/\1 \2/g' \
  | tr '[:upper:]' '[:lower:]' \
  | tr '_-' '  ' \
  | tr -s ' ') "

OPERATION="$TOOL_NAME"
CLASS=""

# -----------------------------------------------------------------------------
# 1. The guarded-verb veto, which is what makes the read allowlist safe.
#
#    The allowlist below has to run early or every lookup becomes a prompt and
#    the team disables the gate. Running it early with a plain substring test is
#    how one read word neutralises a destructive verb sitting in the same name.
#    Measured against real connector names: delete_leads_from_LIST,
#    move_leads_to_campaign_or_LIST, add_leads_to_campaign_or_LIST_bulk and
#    FIND_and_delete_duplicates all exited 0, silently, with no audit row,
#    because one allowlisted token appeared anywhere in the name.
#
#    So the allowlist is vetoed whenever a guarded verb is present. A name
#    carrying both a read word and a write word is a write.
# -----------------------------------------------------------------------------
HAS_GUARDED_VERB=0
case "$TOKENS" in
  *" delete "*|*" destroy "*|*" purge "*|*" remove "*|*" drop "*|*" truncate "*|\
*" wipe "*|*" overwrite "*|*" reset "*|*" merge "*|*" bulk "*|*" mass "*|\
*" send "*|*" reply "*|*" message "*|*" broadcast "*|*" outreach "*|\
*" activate "*|*" resume "*|*" start "*|*" launch "*|*" enable "*|*" publish "*|\
*" refund "*|*" charge "*|*" invoice "*|*" payment "*|*" payout "*|*" cancel "*|\
*" move "*|*" add "*|*" upload "*|*" import "*|*" upsert "*|*" push "*|\
*" write "*|*" create "*|*" update "*|*" edit "*|*" patch "*|*" set "*|\
*" sync "*|*" archive "*|*" disable "*|*" manage "*|*" export "*|*" webhook "*|\
*" writeback "*|*" forward "*|*" execute "*|*" deploy "*|*" migrate "*|\
*" migration "*|*" provision "*|*" rollback "*|*" restore "*|*" apply "*|*" sql "*)
    HAS_GUARDED_VERB=1 ;;
esac

# -----------------------------------------------------------------------------
# 2. Read allowlist, only for names that carry no guarded verb at all.
#    Without it every lookup becomes a prompt and the team disables the gate.
#
#    This list is wider than the minimal read set (get, list, search, describe,
#    read, count, preview, validate) because a narrow one prompts on half the
#    lookups a GTM stack does. The width is safe only because of the veto above:
#    widen the allowlist and the veto together, never the allowlist alone.
#
#    KNOWN LIMIT: a connector that exposes arbitrary SQL under a bare read name
#    (`query`, with nothing else in the name to give it away) is indistinguishable
#    from a lookup here and passes. Names carrying ` sql ` are vetoed above; a
#    bare one goes in EXPLICIT_GUARDED by hand. This is listed in KNOWN GAPS.
# -----------------------------------------------------------------------------
if [ "$HAS_GUARDED_VERB" = 0 ]; then
  case "$TOKENS" in
    *" get "*|*" list "*|*" search "*|*" describe "*|*" read "*|*" count "*|\
*" preview "*|*" validate "*|*" fetch "*|*" query "*|*" find "*|*" lookup "*|\
*" retrieve "*|*" status "*|*" info "*|*" stats "*|*" schema "*|*" docs "*|*" details "*)
      exit 0 ;;
  esac
fi

# -----------------------------------------------------------------------------
# 3. Explicit guarded list. A small, honest set of real examples. This is belt
#    and braces, not the coverage story - the verb matcher below is the backstop
#    that keeps a newly connected system guarded by default. Extend this list
#    when a real action needs a class the verb matcher would get wrong.
#
#    Matched on the full name AND on the operation segment after the last `__`,
#    because the namespace is the half that rots. The same capability arrives as
#    mcp__plugin_stripe_stripe__stripe_api_write after a packaging change, and a
#    full-name-only match reads as coverage while opening a hole that moves money.
# -----------------------------------------------------------------------------
OP_SEGMENT="${TOOL_NAME##*__}"
declare -a EXPLICIT_GUARDED=(
  # irreversible-outward
  "mcp__stripe__create_refund:irreversible-outward"
  "mcp__stripe__stripe_api_write:irreversible-outward"
  "mcp__hubspot__singlesend_email:irreversible-outward"
  "mcp__instantly__reply_to_email:irreversible-outward"
  # production-mutation
  "mcp__supabase__execute_sql:production-mutation"
  "mcp__supabase__apply_migration:production-mutation"
  "mcp__supabase__deploy_edge_function:production-mutation"
  "mcp__supabase__create_project:production-mutation"
  "mcp__supabase__pause_project:production-mutation"
  "mcp__n8n__n8n_test_workflow:production-mutation"
  "mcp__n8n__n8n_update_full_workflow:production-mutation"
  # destructive-internal
  "mcp__github__merge_pull_request:destructive-internal"
  "mcp__github__push_files:destructive-internal"
  "mcp__github__create_or_update_file:destructive-internal"
  "mcp__airtable__delete_records:destructive-internal"
)
for entry in "${EXPLICIT_GUARDED[@]}"; do
  entry_name="${entry%%:*}"
  if [ "$TOOL_NAME" = "$entry_name" ] || [ "$OP_SEGMENT" = "${entry_name##*__}" ]; then
    CLASS="${entry##*:}"; break
  fi
done

# -----------------------------------------------------------------------------
# 4. Deliberately not guarded. Keep these patterns narrow: a not-guarded pattern
#    beats the verb backstop, so a loose one opens a hole quietly.
# -----------------------------------------------------------------------------
if [ -z "$CLASS" ]; then
  case "$TOOL_LC" in
    *slack*)      exit 0 ;;   # internal team messaging
    *calendar*)   exit 0 ;;   # calendar writes
    *gmail*draft*|*gmail*label*|*gmail*thread*|*gmail*spam*|*gmail*trash*) exit 0 ;;
    *github*issue*|*github*comment*|*github*create_pull_request*|*github*review*) exit 0 ;;
  esac
fi

# -----------------------------------------------------------------------------
# 5. Verb matcher across every namespace. This is the fix for name-based
#    coverage rotting: connectors get renamed, versioned and replaced by a
#    successor with the same capability, and none of that produces an error.
#    Matching the verb means a new connector arrives guarded by default, and
#    forgetting to update a list costs one approval rather than an exposure.
#
#    Two maintenance rules keep this honest. Run the twin test whenever you
#    connect a system: if resume is guarded, is start? if the singular is
#    guarded, is the bulk variant? if v1 is guarded, is v2? And when a verb
#    match produces routine friction on something genuinely reversible, add a
#    narrow pattern to the not-guarded block above rather than deleting a verb.
# -----------------------------------------------------------------------------
if [ -z "$CLASS" ]; then
  # Moving contacts into a live sequence is an outward-facing action even though
  # its name carries no outward verb. This is the miss that sends real mail.
  # Editing the copy or the schedule of a campaign that is already running
  # reaches exactly the same people, so it sits in the same cell.
  case "$TOKENS" in
    *" campaign "*|*" campaigns "*|*" sequence "*|*" sequences "*|*" subsequence "*)
      case "$TOKENS" in
        *" add "*|*" move "*|*" upload "*|*" import "*|\
*" update "*|*" edit "*|*" schedule "*|*" settings "*) CLASS="irreversible-outward" ;;
      esac ;;
  esac
fi

if [ -z "$CLASS" ]; then
  # Creating or replacing a live automation is a production mutation whatever
  # verb the connector chose for it, and the generic verb rows below would file
  # a create as merely destructive-internal.
  case "$TOKENS" in
    *" workflow "*|*" workflows "*|*" automation "*|*" pipeline "*)
      case "$TOKENS" in
        *" create "*|*" update "*|*" delete "*|*" deploy "*|*" publish "*|\
*" activate "*|*" autofix "*|*" archive "*) CLASS="production-mutation" ;;
      esac ;;
  esac
fi

if [ -z "$CLASS" ]; then
  case "$TOKENS" in
    *" send "*|*" reply "*|*" message "*|*" broadcast "*|*" outreach "*|\
*" activate "*|*" resume "*|*" start "*|*" launch "*|*" enable "*|*" publish "*|\
*" refund "*|*" charge "*|*" invoice "*|*" payment "*|*" subscription "*|*" subscribe "*|*" checkout "*|*" payout "*|*" cancel "*)
      CLASS="irreversible-outward" ;;
    *" execute "*|*" deploy "*|*" migrate "*|*" migration "*|*" provision "*|*" rollback "*|*" restore "*|*" apply "*|*" run "*|*" sql "*)
      CLASS="production-mutation" ;;
    *" delete "*|*" destroy "*|*" purge "*|*" remove "*|*" drop "*|*" truncate "*|\
*" merge "*|*" reset "*|*" bulk "*|*" mass "*|*" overwrite "*|*" wipe "*|\
*" push "*|*" upsert "*|*" import "*)
      CLASS="destructive-internal" ;;
  esac
fi

# -----------------------------------------------------------------------------
# 6. The write family, scoped to connected systems.
#
#    Without this row the headline claim is false for most of what a GTM agent
#    actually does. Measured unguarded before it existed, every one silent and
#    unlogged: updating the sequence a live campaign sends, updating and creating
#    CRM records, creating engagements, exporting contacts to an arbitrary
#    webhook, and a payments write under a repackaged namespace.
#
#    Scoped to `mcp__` on purpose. The local file tools tokenise to the same
#    verbs (Write, Edit, TodoWrite), they are reversible and internal by
#    definition, and guarding them is the approval treadmill that gets the whole
#    gate switched off. The distinction that matters is whether the write leaves
#    this machine.
#
#    Class note: this lands on destructive-internal, so the owner gets a warned
#    allow rather than a prompt on their own routine work, and everyone else
#    confirms once. Data leaving for a third party is the exception and goes to
#    the outward class, because an export is not recallable.
# -----------------------------------------------------------------------------
if [ -z "$CLASS" ] && [ "${TOOL_NAME#mcp__}" != "$TOOL_NAME" ]; then
  case "$TOKENS" in
    *" export "*|*" webhook "*|*" writeback "*|*" forward "*)
      CLASS="irreversible-outward" ;;
    *" write "*|*" create "*|*" update "*|*" edit "*|*" patch "*|*" set "*|\
*" add "*|*" sync "*|*" archive "*|*" disable "*|*" manage "*)
      CLASS="destructive-internal" ;;
  esac
fi

# -----------------------------------------------------------------------------
# 7. Shell companion patterns. Guarding a named action while the same capability
#    is reachable from a shell guards the polite path only. These stay narrow
#    because a deny with false positives gets the gate disabled, and on this
#    path a wrong match costs a working command rather than one approval.
# -----------------------------------------------------------------------------
SHELL_ALTERNATIVE=""
if [ "$TOOL_NAME" = "Bash" ]; then
  CMD=$(printf '%s' "$TOOL_INPUT" | jq -r '.command // ""' 2>/dev/null)
  OPERATION=$(printf '%s' "$CMD" | awk '{print $1" "$2}' | cut -c1-48)
  CLASS=""

  if printf '%s' "$CMD" | grep -qE '\bgit[[:space:]]+push\b[^|;&]*(--force|[[:space:]]-f\b)'; then
    CLASS="destructive-internal"
    SHELL_EFFECT="rewrites published history on the remote"
  elif printf '%s' "$CMD" | grep -qE '\bgit[[:space:]]+reset[[:space:]]+--hard\b'; then
    CLASS="destructive-internal"
    SHELL_EFFECT="discards uncommitted work permanently"
  elif printf '%s' "$CMD" | grep -qE '\brm[[:space:]]+(-[a-zA-Z]*r[a-zA-Z]*f|-[a-zA-Z]*f[a-zA-Z]*r)\b'; then
    CLASS="destructive-internal"
    SHELL_EFFECT="recursively force-deletes a directory tree"
  elif printf '%s' "$CMD" | grep -qE '\brm\b[^|;&]*\.(env|pem|key|credentials|secret)\b'; then
    CLASS="destructive-internal"
    SHELL_EFFECT="deletes a file that holds credentials"
  elif printf '%s' "$CMD" | grep -qiE '\b(DROP[[:space:]]+(TABLE|DATABASE|SCHEMA)|TRUNCATE[[:space:]]+TABLE)\b'; then
    CLASS="production-mutation"
    SHELL_EFFECT="destroys a database object"
  elif printf '%s' "$CMD" | grep -qE '(curl|wget)[[:space:]][^|;&]*\|[[:space:]]*(ba|z)?sh\b'; then
    CLASS="production-mutation"
    SHELL_EFFECT="pipes a remote script straight into an interpreter"
  elif printf '%s' "$CMD" | grep -qE '\bgit[[:space:]]+config\b[^|;&]*\buser\.(email|name)[[:space:]]+[^[:space:]]'; then
    CLASS="production-mutation"
    SHELL_EFFECT="changes the identity this safety gate resolves"
  else
    # Direct calls to your live systems, from the roster's guarded-hosts key.
    for host in $GUARDED_HOSTS; do
      [ -z "$host" ] && continue
      if printf '%s' "$CMD" | grep -qF "$host"; then
        CLASS="irreversible-outward"
        SHELL_EFFECT="calls $host directly, which is a live system"
        SHELL_ALTERNATIVE="The same capability exists as a guarded action. Use that path so the approval flow applies, rather than reaching the endpoint from a shell."
        break
      fi
    done
  fi
fi

# Nothing matched, so this is reversible internal. Allow with no log noise.
[ -z "$CLASS" ] && exit 0

# =============================================================================
# Decision-relevant field extraction
# =============================================================================
# Never print the raw payload. A four-kilobyte dump gets approved without being
# read. Surface two or three fields a reviewer can decide from, each truncated.
trunc() { printf '%s' "$1" | tr '\n' ' ' | cut -c1-200; }

first_val() {
  local k v
  for k in "$@"; do
    v=$(printf '%s' "$TOOL_INPUT" | jq -r --arg k "$k" '
      (.[$k] // empty) | if type == "string" then . elif type == "array" or type == "object" then tojson else tostring end' 2>/dev/null | head -1)
    if [ -n "$v" ] && [ "$v" != "null" ]; then printf '%s' "$v"; return; fi
  done
}

array_count() {
  local k n
  for k in "$@"; do
    n=$(printf '%s' "$TOOL_INPUT" | jq -r --arg k "$k" 'if (.[$k]|type) == "array" then (.[$k]|length) else empty end' 2>/dev/null | head -1)
    if [ -n "$n" ]; then printf '%s' "$n"; return; fi
  done
}

FIELDS=""
add_field() { [ -n "$2" ] && FIELDS="${FIELDS}$1: $(trunc "$2")
"; }

if [ "$TOOL_NAME" = "Bash" ]; then
  add_field "Command" "$CMD"
  add_field "Working directory" "$(printf '%s' "$INPUT" | jq -r '.cwd // empty' 2>/dev/null)"
else
  case "$CLASS" in
    irreversible-outward)
      add_field "Recipient" "$(first_val to recipient email lead_email contact_email address channel)"
      add_field "Content" "$(first_val subject body text message content copy first_line)"
      add_field "Campaign or list" "$(first_val campaign_id campaign_name sequence_id list_id list_name)"
      add_field "Amount" "$(first_val amount amount_cents total currency)"
      add_field "Recipient count" "$(array_count leads contacts recipients emails to)"
      ;;
    production-mutation)
      add_field "Statement" "$(first_val query sql statement command code)"
      add_field "Target" "$(first_val project_id database schema workflow_id workflow_name id name)"
      add_field "Live" "$(first_val active is_active published environment)"
      ;;
    destructive-internal)
      add_field "Record count" "$(array_count records ids leads recordIds rows contacts)"
      add_field "Source" "$(first_val table_id tableId list_id source repo repository baseId)"
      add_field "Destination" "$(first_val destination target_list branch path to_campaign_id)"
      add_field "Identifier" "$(first_val id name pullNumber campaign_id)"
      ;;
  esac
fi
[ -z "$FIELDS" ] && FIELDS="Payload keys: $(trunc "$(printf '%s' "$TOOL_INPUT" | jq -r 'keys | join(", ")' 2>/dev/null)")
"

LOG_DETAIL=$(printf '%s' "$FIELDS" | tr '\n' ';' | cut -c1-160)

# =============================================================================
# Approvals
# =============================================================================
# Per-call keys hash the FULL canonical payload. Hashing a prefix produces real
# collisions: two outreach messages that share an opening and diverge in the
# body map to one approval file, so approving the first silently authorises the
# second. The canonical form is the action name plus the whole tool input with
# keys sorted, which drops only the envelope fields the model does not control
# and the human is not deciding on.
CANON="${TOOL_NAME}
$(printf '%s' "$TOOL_INPUT" | jq -S -c . 2>/dev/null)"
PAYLOAD_HASH=$(printf '%s' "$CANON" | $HASH_CMD | cut -d' ' -f1)

# Batch keys are the OPERATION, so one file covers many payloads of the same
# operation inside the TTL and covers nothing else.
BATCH_KEY=$(printf '%s' "$OPERATION" | tr -c '[:alnum:]._-' '-' | cut -c1-48)

CALL_FILE="$APPROVAL_DIR/call-$PAYLOAD_HASH"
TWO_PERSON_FILE="$APPROVAL_DIR/two-person-$PAYLOAD_HASH"
BATCH_FILE="$APPROVAL_DIR/batch-$BATCH_KEY"

EXPIRED_NOTE=""
approval_valid() {
  # Valid returns 0. An expired file is deleted and noted, because a silently
  # ignored expired approval reads as the gate malfunctioning.
  local f="$1" age
  [ -f "$f" ] || return 1
  age=$(( $(date +%s) - $(stat -f %m "$f" 2>/dev/null || stat -c %Y "$f" 2>/dev/null || echo 0) ))
  if [ "$age" -gt "$TTL" ]; then
    rm -f "$f"
    EXPIRED_NOTE="An approval for this action was found but had expired, so it was removed. Ask again."
    return 1
  fi
  return 0
}

if approval_valid "$TWO_PERSON_FILE"; then
  rm -f "$TWO_PERSON_FILE"
  log_decision "$CLASS" "allowed-two-person" "$LOG_DETAIL"
  exit 0
fi

if approval_valid "$CALL_FILE"; then
  rm -f "$CALL_FILE"
  log_decision "$CLASS" "allowed-confirm" "$LOG_DETAIL"
  exit 0
fi

# Batch is structurally unavailable outside destructive-internal, enforced here
# by an explicit tier check rather than by convention. "Approve once, send to
# everyone" is exactly the catastrophe the irreversible classes exist to
# prevent, so a batch file minted against one of them changes nothing.
if [ "$CLASS" = "destructive-internal" ] && approval_valid "$BATCH_FILE"; then
  log_decision "$CLASS" "allowed-batch" "$LOG_DETAIL"
  exit 0
fi

# =============================================================================
# The matrix
# =============================================================================
case "$USER_TIER:$CLASS" in
  owner:destructive-internal)                       OUTCOME="warn" ;;
  owner:*|trusted:*)                                OUTCOME="confirm" ;;
  *:destructive-internal)                           OUTCOME="confirm" ;;
  *)                                                OUTCOME="two-person" ;;
esac

case "$CLASS" in
  irreversible-outward) EFFECT="reaches a person outside the company or moves money, and cannot be recalled" ;;
  production-mutation)  EFFECT="changes a running production system that other people's work depends on" ;;
  destructive-internal) EFFECT="deletes or bulk-mutates internal records, recoverable only from a backup" ;;
esac
[ -n "${SHELL_EFFECT:-}" ] && EFFECT="$SHELL_EFFECT"

if [ "$TOOL_NAME" = "Bash" ]; then
  SYSTEM="the shell"
else
  SYSTEM=$(printf '%s' "$TOOL_NAME" | awk -F'__' '{print ($2 != "" ? $2 : $1)}')
fi

# -----------------------------------------------------------------------------
# Warned allow: the owner-on-destructive cell
# -----------------------------------------------------------------------------
if [ "$OUTCOME" = "warn" ]; then
  echo "SAFETY GUARD - allowed with a warning. $OPERATION $EFFECT. Logged as warned-owner."
  log_decision "$CLASS" "warned-owner" "$LOG_DETAIL"
  exit 0
fi

# -----------------------------------------------------------------------------
# Block. Written to stderr, because that is what the runtime feeds to the model.
# -----------------------------------------------------------------------------
{
  echo "BLOCKED - $CLASS operation requires approval."
  echo ""
  echo "Effect: $OPERATION on $SYSTEM $EFFECT."
  printf '%s' "$FIELDS"
  echo "Acting identity: ${IDENTITY:-none resolved} (tier: $USER_TIER)"
  if [ "$USER_TIER" = "unresolved" ]; then
    echo "Your identity did not resolve, so you are on the strictest tier. Fix it with"
    echo "  git config user.email you@yourcompany.com"
    echo "and add that address to $ROSTER_PATH under owner: or trusted:."
  fi
  [ -n "$EXPIRED_NOTE" ] && { echo ""; echo "$EXPIRED_NOTE"; }
  echo ""
  echo "Before asking for approval, tell the user exactly what you are about to do:"
  echo "the recipient, the content, and the target system."
  echo ""

  if [ "$OUTCOME" = "two-person" ]; then
    echo "This is a two-person operation. You must NOT create the approval file."
    echo "Ask an owner to create it themselves, at their own keyboard, at:"
    echo "  $TWO_PERSON_FILE"
    echo ""
    echo "Report back to the user that the action is waiting on owner approval, and"
    echo "state what you will do once it lands."
  else
    echo "To proceed after they approve, run:"
    echo "  mkdir -p \"$APPROVAL_DIR\" && touch \"$CALL_FILE\""
    echo ""
    echo "This approval covers this payload only and expires in ${TTL}s."
    if [ "$CLASS" = "destructive-internal" ]; then
      echo ""
      echo "For a run of this same operation row by row, ask once, say plainly that the"
      echo "approval covers the whole run and what the run consists of, then run:"
      echo "  mkdir -p \"$APPROVAL_DIR\" && touch \"$BATCH_FILE\""
      echo "That key covers this operation only, for ${TTL}s."
    fi
  fi

  [ -n "$SHELL_ALTERNATIVE" ] && { echo ""; echo "$SHELL_ALTERNATIVE"; }
  echo ""
  echo "Never work around this gate with a raw API call, a different tool, or a"
  echo "rewritten command. If the user declines, stop and report what was not done."
} >&2

if [ "$OUTCOME" = "two-person" ]; then
  log_decision "$CLASS" "blocked-two-person" "$LOG_DETAIL"
else
  log_decision "$CLASS" "blocked-confirm" "$LOG_DETAIL"
fi
exit 2
