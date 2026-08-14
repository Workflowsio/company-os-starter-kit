#!/usr/bin/env bash

# =============================================================================
# Session Logger - Claude Code Event Logger
# =============================================================================
#
# Logs every Claude Code hook event to a per-session JSONL file.
# Each session gets its own file: .claude/sessions/<session_id>.jsonl
#
# What gets logged:
#   - User prompts (truncated to 2000 chars)
#   - Tool calls (tool name + truncated input)
#   - Tool completions and failures
#   - Response completions
#   - Compaction snapshots (stats before context window compresses)
#   - Session end summaries (total prompts, tools, failures, top tools)
#
# Wire to these events in settings.json:
#   UserPromptSubmit, PreToolUse, PostToolUse, PostToolUseFailure,
#   Stop, PreCompact, SessionEnd
#
# Output: .claude/sessions/<session_id>.jsonl (one JSON object per line)
# Requires: jq (brew install jq / apt install jq)
#
# EVERY LINE MUST PARSE. The log is the evidence trail for "did the gate actually
# fire", and one malformed line takes the whole file down: `jq .` aborts at the
# first bad record rather than skipping it. So every value that comes from the
# payload is encoded by jq before it reaches the line, and anything truncated is
# truncated INSIDE jq and re-emitted as a JSON string. Byte-truncating an already
# encoded object and interpolating the fragment raw is how most Write and Edit
# calls, which run past a kilobyte, produced an unreadable file.
# =============================================================================

command -v jq >/dev/null 2>&1 || {
  echo "[Claude Code] session-logger.sh needs jq: brew install jq (or: sudo apt install jq)" >&2
  exit 0
}

INPUT=$(cat)

# Resolve paths relative to this script's location
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_DIR="$SCRIPT_DIR/../sessions"
mkdir -p "$LOG_DIR"

# Extract common fields from the hook input
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"' 2>/dev/null)
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // "unknown"' 2>/dev/null)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# Filesystem-safe session id, because it becomes a filename.
SESSION_ID=$(printf '%s' "$SESSION_ID" | tr -c '[:alnum:]._-' '-' | cut -c1-96)
[ -z "$SESSION_ID" ] && SESSION_ID="unknown"

# JSON-encoded copies of the values that get interpolated into a line. A tool
# name carrying a quote would otherwise break the record it appears in.
SESSION_J=$(printf '%s' "$SESSION_ID" | jq -Rs .)
EVENT_J=$(printf '%s' "$EVENT" | jq -Rs .)
TOOL_J=$(printf '%s' "$TOOL_NAME" | jq -Rs .)

# Each session gets its own transcript file
TRANSCRIPT="$LOG_DIR/${SESSION_ID}.jsonl"

# Build a structured log entry based on the event type
case "$EVENT" in

  # ---- User typed a prompt ----
  UserPromptSubmit)
    PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty' 2>/dev/null | head -c 2000)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"user_prompt\",\"sid\":$SESSION_J,\"prompt\":$(echo "$PROMPT" | jq -Rs .)}" >> "$TRANSCRIPT"
    ;;

  # ---- Claude is about to call a tool ----
  PreToolUse)
    # Truncated inside jq and re-emitted as a JSON string, so the record still
    # parses whatever the payload size. `input` is a string, not an object: the
    # alternative is a line that stops being valid JSON above a kilobyte.
    TOOL_INPUT=$(echo "$INPUT" | jq -c '(.tool_input // {}) | tojson | .[0:1000]' 2>/dev/null)
    [ -z "$TOOL_INPUT" ] && TOOL_INPUT='""'
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"tool_start\",\"sid\":$SESSION_J,\"tool\":$TOOL_J,\"input\":$TOOL_INPUT}" >> "$TRANSCRIPT"
    ;;

  # ---- Tool call completed successfully ----
  PostToolUse)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"tool_done\",\"sid\":$SESSION_J,\"tool\":$TOOL_J}" >> "$TRANSCRIPT"
    ;;

  # ---- Tool call failed ----
  PostToolUseFailure)
    STDERR=$(echo "$INPUT" | jq -r '.tool_error // empty' 2>/dev/null | head -c 500)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"tool_fail\",\"sid\":$SESSION_J,\"tool\":$TOOL_J,\"error\":$(echo "$STDERR" | jq -Rs .)}" >> "$TRANSCRIPT"
    ;;

  # ---- Claude finished its response ----
  Stop)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"response_complete\",\"sid\":$SESSION_J}" >> "$TRANSCRIPT"
    ;;

  # ---- Context window is about to be compacted ----
  PreCompact)
    # Capture a snapshot of what happened so far (stats survive compaction)
    PROMPT_COUNT=$(grep -c '"user_prompt"' "$TRANSCRIPT" 2>/dev/null) || PROMPT_COUNT=0
    TOOL_COUNT=$(grep -c '"tool_start"' "$TRANSCRIPT" 2>/dev/null) || TOOL_COUNT=0
    FAIL_COUNT=$(grep -c '"tool_fail"' "$TRANSCRIPT" 2>/dev/null) || FAIL_COUNT=0
    LAST_PROMPT=$(grep '"user_prompt"' "$TRANSCRIPT" 2>/dev/null | tail -1 | jq -r '.prompt // ""' 2>/dev/null | head -c 300)
    LAST_PROMPT_JSON=$(echo "$LAST_PROMPT" | jq -Rs .)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"compaction\",\"sid\":$SESSION_J,\"snapshot\":{\"prompts\":$PROMPT_COUNT,\"tools\":$TOOL_COUNT,\"failures\":$FAIL_COUNT,\"last_prompt\":$LAST_PROMPT_JSON}}" >> "$TRANSCRIPT"
    ;;

  # ---- Session is ending ----
  SessionEnd)
    # Generate a summary of the entire session
    PROMPT_COUNT=$(grep -c '"user_prompt"' "$TRANSCRIPT" 2>/dev/null) || PROMPT_COUNT=0
    TOOL_COUNT=$(grep -c '"tool_start"' "$TRANSCRIPT" 2>/dev/null) || TOOL_COUNT=0
    FAIL_COUNT=$(grep -c '"tool_fail"' "$TRANSCRIPT" 2>/dev/null) || FAIL_COUNT=0
    COMPACT_COUNT=$(grep -c '"compaction"' "$TRANSCRIPT" 2>/dev/null) || COMPACT_COUNT=0
    FIRST_TS=$(head -1 "$TRANSCRIPT" 2>/dev/null | jq -r '.ts // ""' 2>/dev/null)

    # Top 5 most-used tools
    TOP_TOOLS=$(grep '"tool_start"' "$TRANSCRIPT" 2>/dev/null \
      | jq -r '.tool' 2>/dev/null \
      | sort | uniq -c | sort -rn | head -5 \
      | awk '{print $2 "(" $1 ")"}' \
      | tr '\n' ', ' | sed 's/,$//')

    echo "{\"ts\":\"$TIMESTAMP\",\"event\":\"session_end\",\"sid\":$SESSION_J,\"summary\":{\"started\":$(printf '%s' "$FIRST_TS" | jq -Rs .),\"prompts\":$PROMPT_COUNT,\"tools\":$TOOL_COUNT,\"failures\":$FAIL_COUNT,\"compactions\":$COMPACT_COUNT,\"top_tools\":$(printf '%s' "$TOP_TOOLS" | jq -Rs .)}}" >> "$TRANSCRIPT"
    ;;

  # ---- Any other event we haven't explicitly handled ----
  *)
    echo "{\"ts\":\"$TIMESTAMP\",\"event\":$EVENT_J,\"sid\":$SESSION_J}" >> "$TRANSCRIPT"
    ;;
esac

exit 0
