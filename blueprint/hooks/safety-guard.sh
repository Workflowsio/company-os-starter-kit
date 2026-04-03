#!/bin/bash

# =============================================================================
# Safety Guard - PreToolUse Hook for Claude Code
# =============================================================================
#
# Blocks dangerous operations before they execute. Claude Code calls this hook
# before every tool use. The script reads the tool call from stdin (JSON),
# checks it against a blocklist, and exits with code 2 to block or 0 to allow.
#
# Exit codes:
#   0 = allow the tool call
#   2 = block the tool call (Claude will show the block message to the user)
#
# Install: wire this script to PreToolUse in .claude/settings.json
# Customize: add/remove tool names and bash patterns to match your stack
# =============================================================================

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""' 2>/dev/null)
TOOL_INPUT=$(echo "$INPUT" | jq -c '.tool_input // {}' 2>/dev/null)

# =============================================================================
# BLOCKED MCP TOOLS
# =============================================================================
# Add any MCP tool names that should require explicit human approval.
# Format: "mcp__<server>__<tool_name>"
#
# Find your tool names by running Claude Code and asking it to list available
# tools, or check your MCP server documentation.
# =============================================================================

BLOCKED_TOOLS=(

  # ---------------------------------------------------------------------------
  # 1. EMAIL & MESSAGING (sending messages to real people)
  # ---------------------------------------------------------------------------
  # Gmail / email
  "mcp__gmail__send_email"
  "mcp__gmail__send_draft"
  "mcp__gmail__create_draft"            # drafts can auto-send via rules
  # Slack
  "mcp__slack__slack_post_message"
  "mcp__slack__slack_send_message"
  "mcp__slack__slack_schedule_message"
  "mcp__slack__slack_reply_to_thread"
  # Generic messaging -- add your platforms here
  # "mcp__teams__send_message"
  # "mcp__discord__send_message"

  # ---------------------------------------------------------------------------
  # 2. OUTBOUND CAMPAIGNS (activating sends real outreach to strangers)
  # ---------------------------------------------------------------------------
  # Uncomment and customize for your outbound platform:
  # "mcp__<outbound_tool>__activate_campaign"
  # "mcp__<outbound_tool>__pause_campaign"
  # "mcp__<outbound_tool>__resume_campaign"

  # ---------------------------------------------------------------------------
  # 3. FINANCIAL OPERATIONS (real money, invoices, refunds)
  # ---------------------------------------------------------------------------
  "mcp__stripe__create_invoice"
  "mcp__stripe__finalize_invoice"
  "mcp__stripe__create_refund"
  "mcp__stripe__create_payment_link"
  "mcp__stripe__stripe_api_execute"     # raw API = anything goes
  # "mcp__quickbooks__create_invoice"
  # "mcp__xero__create_invoice"

  # ---------------------------------------------------------------------------
  # 4. BULK DATA OPERATIONS (mass changes that are hard to undo)
  # ---------------------------------------------------------------------------
  # CRM bulk operations
  # "mcp__hubspot__bulk_create"
  # "mcp__hubspot__bulk_delete"
  # "mcp__salesforce__bulk_upsert"
  # Lead list operations
  # "mcp__<crm>__bulk_add_contacts"
  # "mcp__<crm>__bulk_delete_contacts"

  # ---------------------------------------------------------------------------
  # 5. DESTRUCTIVE DELETES (irreversible data loss)
  # ---------------------------------------------------------------------------
  "mcp__airtable__delete_records"
  # "mcp__notion__delete_block"
  # "mcp__hubspot__delete_contact"
  # "mcp__salesforce__delete_record"

  # ---------------------------------------------------------------------------
  # 6. DATABASE ADMIN (schema changes, migrations, raw SQL)
  # ---------------------------------------------------------------------------
  "mcp__supabase__execute_sql"          # raw SQL can drop anything
  "mcp__supabase__apply_migration"
  "mcp__supabase__deploy_edge_function"
  "mcp__supabase__create_project"
  "mcp__supabase__pause_project"
  # "mcp__postgres__execute_query"
  # "mcp__planetscale__execute"

  # ---------------------------------------------------------------------------
  # 7. GITHUB MUTATIONS (pushing code, merging PRs)
  # ---------------------------------------------------------------------------
  "mcp__github__push_files"
  "mcp__github__create_or_update_file"
  "mcp__github__merge_pull_request"

  # ---------------------------------------------------------------------------
  # 8. CALENDAR MUTATIONS (scheduling meetings on your behalf)
  # ---------------------------------------------------------------------------
  "mcp__google_calendar__create_event"
  "mcp__google_calendar__delete_event"
  "mcp__google_calendar__update_event"
  "mcp__google_calendar__respond_to_event"

  # ---------------------------------------------------------------------------
  # 9. INFRASTRUCTURE (deploying, provisioning, destroying resources)
  # ---------------------------------------------------------------------------
  # "mcp__aws__cloudformation_deploy"
  # "mcp__vercel__deploy_project"
  # "mcp__fly__deploy_app"
  # "mcp__terraform__apply"
)

# Check if the current tool is in the blocked list
for blocked in "${BLOCKED_TOOLS[@]}"; do
  # Skip commented-out entries (lines starting with #)
  [[ "$blocked" == \#* ]] && continue

  if [ "$TOOL_NAME" = "$blocked" ]; then
    # Build a human-readable description of what was blocked
    case "$TOOL_NAME" in
      *send*|*post*|*reply*|*schedule*|*draft*)
        CATEGORY="External messaging"
        ;;
      *activate*|*pause*|*resume*)
        CATEGORY="Campaign lifecycle change"
        ;;
      *stripe*|*invoice*|*refund*|*payment*)
        CATEGORY="Financial operation"
        ;;
      *bulk*|*add_leads*|*move_leads*)
        CATEGORY="Bulk data operation"
        ;;
      *delete*)
        CATEGORY="Destructive delete"
        ;;
      *sql*|*migration*|*deploy*|*project*)
        CATEGORY="Database/infrastructure operation"
        ;;
      *push*|*merge*|*create_or_update*)
        CATEGORY="GitHub mutation"
        ;;
      *event*|*calendar*)
        CATEGORY="Calendar mutation"
        ;;
      *)
        CATEGORY="Blocked operation"
        ;;
    esac

    DETAILS=$(echo "$TOOL_INPUT" | jq -c '.' 2>/dev/null | head -c 300)

    echo "SAFETY GUARD BLOCKED: $CATEGORY"
    echo "Tool: $TOOL_NAME"
    echo "Details: $DETAILS"
    echo ""
    echo "Describe what you were about to do and ask the user for explicit approval."
    exit 2
  fi
done

# =============================================================================
# DANGEROUS BASH PATTERNS
# =============================================================================
# These catch dangerous shell commands regardless of which MCP tool is used.
# =============================================================================

if [ "$TOOL_NAME" = "Bash" ]; then
  CMD=$(echo "$TOOL_INPUT" | jq -r '.command // ""' 2>/dev/null)

  # git push --force / -f (destroys remote history)
  if echo "$CMD" | grep -qE '\bgit\s+push\s+.*(-f|--force)\b'; then
    echo "SAFETY GUARD BLOCKED: git push --force"
    echo "Command: $CMD"
    echo ""
    echo "Force-pushing rewrites remote history. Ask the user for approval."
    exit 2
  fi

  # git push to main/master (should go through PR review)
  if echo "$CMD" | grep -qE '\bgit\s+push\s+.*\b(origin\s+)?(main|master)\b'; then
    echo "SAFETY GUARD BLOCKED: git push to main/master"
    echo "Command: $CMD"
    echo ""
    echo "Pushing directly to the default branch bypasses code review. Ask the user for approval."
    exit 2
  fi

  # git reset --hard (destroys uncommitted work)
  if echo "$CMD" | grep -qE '\bgit\s+reset\s+--hard\b'; then
    echo "SAFETY GUARD BLOCKED: git reset --hard"
    echo "Command: $CMD"
    echo ""
    echo "This discards all uncommitted changes permanently. Ask the user for approval."
    exit 2
  fi

  # rm -rf (recursive force delete)
  if echo "$CMD" | grep -qE '\brm\s+-(rf|fr)\b'; then
    echo "SAFETY GUARD BLOCKED: rm -rf"
    echo "Command: $CMD"
    echo ""
    echo "Recursive force-delete is irreversible. Ask the user for approval."
    exit 2
  fi

  # DROP TABLE/DATABASE/SCHEMA, TRUNCATE TABLE (destroys data)
  if echo "$CMD" | grep -qiE '\b(DROP\s+(TABLE|DATABASE|SCHEMA)|TRUNCATE\s+TABLE)\b'; then
    echo "SAFETY GUARD BLOCKED: Destructive SQL (DROP/TRUNCATE)"
    echo "Command: $CMD"
    echo ""
    echo "This permanently destroys database objects. Ask the user for approval."
    exit 2
  fi

  # curl/wget piped to shell (remote code execution)
  if echo "$CMD" | grep -qE '(curl|wget)\s.*\|\s*(ba)?sh'; then
    echo "SAFETY GUARD BLOCKED: Remote code execution (curl|sh)"
    echo "Command: $CMD"
    echo ""
    echo "Piping remote content to a shell is dangerous. Ask the user for approval."
    exit 2
  fi

  # chmod 777 (world-writable permissions)
  if echo "$CMD" | grep -qE '\bchmod\s+777\b'; then
    echo "SAFETY GUARD BLOCKED: chmod 777"
    echo "Command: $CMD"
    echo ""
    echo "World-writable permissions are a security risk. Ask the user for approval."
    exit 2
  fi

  # Deleting .env or credentials files
  if echo "$CMD" | grep -qE '\brm\s.*\.(env|pem|key|credentials|secret)'; then
    echo "SAFETY GUARD BLOCKED: Deleting credentials/secrets file"
    echo "Command: $CMD"
    echo ""
    echo "This would delete a file that may contain secrets. Ask the user for approval."
    exit 2
  fi
fi

# =============================================================================
# All clear -- allow the tool call
# =============================================================================
exit 0
