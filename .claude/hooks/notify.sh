#!/usr/bin/env bash

# =============================================================================
# Notify - macOS Notification Hook for Claude Code
# =============================================================================
#
# Sends a native macOS notification when Claude Code needs your attention.
# Useful when you step away from the terminal during long-running tasks.
#
# Wire to these events in settings.json:
#   Stop             - Claude finished responding
#   PermissionRequest - Claude needs approval to proceed
#   Notification      - Claude sent a notification
#   SubagentStop     - A sub-agent finished its task
#
# Requirements: macOS (uses osascript). For Linux, swap osascript for
# notify-send. For cross-platform, use terminal-notifier or ntfy.sh.
#
# NOTHING FROM THE PAYLOAD IS INTERPOLATED INTO A SCRIPT. The message on a
# Notification event comes from the payload, and a value carrying a double quote
# closes the AppleScript string so everything after it runs as AppleScript in the
# user's own session. Values are passed as arguments and read inside the script
# instead. A safety kit does not ship a notifier whose input reaches an
# interpreter.
#
# This hook exits 0 on every path, including a missing dependency. A notifier
# that can block a tool call is worse than no notifier.
# =============================================================================

command -v jq >/dev/null 2>&1 || {
  echo "[Claude Code] notify.sh needs jq: brew install jq (or: sudo apt install jq)" >&2
  exit 0
}

INPUT=$(cat)

# Extract event type from hook input
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // "unknown"' 2>/dev/null)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"' 2>/dev/null)

# Build notification title and message based on event type
case "$EVENT" in
  Stop)
    TITLE="Claude Code"
    MESSAGE="Response complete."
    ;;
  PermissionRequest)
    TITLE="Claude Code - Action Required"
    MESSAGE="Claude needs your approval to proceed."
    # Play a sound for permission requests since they block progress
    SOUND="Ping"
    ;;
  Notification)
    TITLE="Claude Code"
    MESSAGE=$(echo "$INPUT" | jq -r '.message // "Notification from Claude"' 2>/dev/null)
    ;;
  SubagentStop)
    TITLE="Claude Code"
    MESSAGE="Sub-agent task complete."
    ;;
  SessionStart)
    TITLE="Claude Code"
    MESSAGE="Session started."
    ;;
  SessionEnd)
    TITLE="Claude Code"
    MESSAGE="Session ended."
    ;;
  *)
    TITLE="Claude Code"
    MESSAGE="Event: $EVENT"
    ;;
esac

# Strip control characters and cap the length before the value goes anywhere.
# A notification is a glance, and a long one is truncated by the OS anyway.
MESSAGE=$(printf '%s' "$MESSAGE" | tr -d '\000-\037' | cut -c1-200)
TITLE=$(printf '%s' "$TITLE" | tr -d '\000-\037' | cut -c1-80)

# ---- macOS notification via osascript ----
if command -v osascript >/dev/null 2>&1; then
  # Arguments, not string interpolation. `on run {t, m}` binds the values as
  # AppleScript variables, so a quote in the message is data rather than syntax.
  if [ -n "$SOUND" ]; then
    osascript \
      -e 'on run {t, m, s}' \
      -e 'display notification m with title t sound name s' \
      -e 'end run' \
      -- "$TITLE" "$MESSAGE" "$SOUND" 2>/dev/null
  else
    osascript \
      -e 'on run {t, m}' \
      -e 'display notification m with title t' \
      -e 'end run' \
      -- "$TITLE" "$MESSAGE" 2>/dev/null
  fi

# ---- Linux notification via notify-send ----
elif command -v notify-send >/dev/null 2>&1; then
  URGENCY="normal"
  [ "$EVENT" = "PermissionRequest" ] && URGENCY="critical"
  # `--` terminates option parsing, so a message beginning with a hyphen is not
  # read as a flag.
  notify-send --urgency="$URGENCY" -- "$TITLE" "$MESSAGE" 2>/dev/null

# ---- Fallback: print to stderr so it shows in the terminal ----
else
  printf '[%s] %s\n' "$TITLE" "$MESSAGE" >&2
fi

exit 0
