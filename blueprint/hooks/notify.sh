#!/bin/bash

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
# =============================================================================

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

# ---- macOS notification via osascript ----
if command -v osascript &>/dev/null; then
  if [ -n "$SOUND" ]; then
    osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"$SOUND\"" 2>/dev/null
  else
    osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\"" 2>/dev/null
  fi

# ---- Linux notification via notify-send ----
elif command -v notify-send &>/dev/null; then
  URGENCY="normal"
  [ "$EVENT" = "PermissionRequest" ] && URGENCY="critical"
  notify-send --urgency="$URGENCY" "$TITLE" "$MESSAGE" 2>/dev/null

# ---- Fallback: print to stderr so it shows in the terminal ----
else
  echo "[$TITLE] $MESSAGE" >&2
fi

exit 0
