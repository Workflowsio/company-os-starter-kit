#!/usr/bin/env bash
# =============================================================================
# safety-guard-test.sh - proves every cell of the matrix by execution
# =============================================================================
#
# Reading the guard proves the author's intent. Firing payloads at it proves the
# behavior, and those two diverge more often than anyone expects. Run this after
# every edit to safety-guard.sh, and paste the table into your own docs so the
# observed column sits next to the intended one.
#
# The names fired below are REAL connector operations wherever a real one exists.
# An invented name that happens to dodge a collision reports a pass over a hole:
# `..._add_leads_to_campaign_bulk` blocked while the real
# `..._add_leads_to_campaign_or_list_bulk` exited 0, and the suite was green.
# The last section covers the session logger, because a gate whose evidence trail
# does not parse cannot be shown to have fired.
#
#   bash .claude/hooks/safety-guard-test.sh
#
# Everything runs against a scratch HOME, a scratch approval directory, a
# scratch audit log and throwaway git repositories, so it cannot touch your real
# approvals or your real log. Exits non-zero if any case fails.
# =============================================================================

GUARD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/safety-guard.sh"
BASH_BIN=$(command -v bash)
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

# A PATH holding everything the guard needs EXCEPT jq, so the dependency case
# proves the jq branch rather than proving that an empty PATH breaks a script.
mkdir -p "$WORK/bin"
for b in cat date wc tail mv tr cut grep sed awk git shasum sha256sum stat rm mkdir dirname head touch env; do
  p=$(command -v "$b" 2>/dev/null) && ln -sf "$p" "$WORK/bin/$b"
done

age_file() {
  # Backdates a file so the expiry branch can be tested honestly, rather than
  # by setting a TTL no operator would ever configure.
  perl -e 'utime time-7200, time-7200, $ARGV[0]' "$1" 2>/dev/null
}

export GIT_CONFIG_NOSYSTEM=1
export SAFETY_GUARD_APPROVAL_DIR="$WORK/approvals"
export SAFETY_GUARD_LOG="$WORK/audit.log"
export SAFETY_GUARD_ROSTER="$WORK/roster"
export HOME="$WORK/home"
mkdir -p "$HOME" "$SAFETY_GUARD_APPROVAL_DIR"

cat > "$WORK/roster" <<'EOF'
owner: owner@example.com
trusted: trusted@example.com
guarded-hosts: api.livesystem.example
EOF

# One throwaway repository per identity, so the guard resolves the identity the
# same way it will in production: from the version-control committer email.
mkrepo() {
  local dir="$WORK/repo-$1"
  mkdir -p "$dir"
  git -C "$dir" init -q 2>/dev/null
  [ -n "$2" ] && git -C "$dir" config user.email "$2"
  printf '%s' "$dir"
}
REPO_OWNER=$(mkrepo owner owner@example.com)
REPO_TRUSTED=$(mkrepo trusted trusted@example.com)
REPO_TEAM=$(mkrepo team newjoiner@example.com)
REPO_NONE=$(mkrepo none "")

PASS=0; FAIL=0
LAST_OUT=""; LAST_ERR=""; LAST_CODE=0

run_case() {
  # run_case <repo> <payload> [env assignments...]
  local repo="$1" payload="$2"; shift 2
  LAST_OUT=$(mktemp); LAST_ERR=$(mktemp)
  ( cd "$repo" && printf '%s' "$payload" | env "$@" "$BASH_BIN" "$GUARD" ) >"$LAST_OUT" 2>"$LAST_ERR"
  LAST_CODE=$?
}

check() {
  # check <case name> <expected exit> <expected substring or -> <where: out|err|none>
  local name="$1" want_code="$2" want_text="$3" where="${4:-err}" got_text="" ok=1
  case "$where" in
    out) got_text=$(cat "$LAST_OUT") ;;
    err) got_text=$(cat "$LAST_ERR") ;;
    none) got_text="$(cat "$LAST_OUT")$(cat "$LAST_ERR")" ;;
  esac
  [ "$LAST_CODE" = "$want_code" ] || ok=0
  if [ "$want_text" = "-" ]; then
    [ -z "$got_text" ] || ok=0
  else
    printf '%s' "$got_text" | grep -qF "$want_text" || ok=0
  fi
  if [ "$ok" = 1 ]; then
    PASS=$((PASS + 1)); printf 'PASS  exit=%s  %s\n' "$LAST_CODE" "$name"
  else
    FAIL=$((FAIL + 1)); printf 'FAIL  exit=%s (wanted %s)  %s\n' "$LAST_CODE" "$want_code" "$name"
    printf '      wanted text: %s\n      got: %s\n' "$want_text" "$(printf '%s' "$got_text" | head -3)"
  fi
  rm -f "$LAST_OUT" "$LAST_ERR"
}

P_DESTRUCTIVE='{"tool_name":"mcp__airtable__delete_records","tool_input":{"tableId":"tblLeads","recordIds":["r1","r2","r3"]}}'
P_OUTWARD='{"tool_name":"mcp__instantly__activate_campaign","tool_input":{"campaign_id":"c-99","name":"Q3 outbound"}}'
P_PRODUCTION='{"tool_name":"mcp__supabase__execute_sql","tool_input":{"project_id":"prj_1","query":"update accounts set owner_id = 4"}}'
P_REVERSIBLE='{"tool_name":"mcp__slack__slack_post_message","tool_input":{"channel":"#gtm","text":"standup in 5"}}'
P_READ='{"tool_name":"mcp__hubspot__search_crm_objects","tool_input":{"objectType":"contacts"}}'

echo "=== tier x class matrix ==="
run_case "$REPO_OWNER"   "$P_DESTRUCTIVE"; check "1  owner + destructive internal -> warn, allow" 0 "allowed with a warning" out
run_case "$REPO_OWNER"   "$P_OUTWARD";     check "2  owner + irreversible outward -> block, self-unblock" 2 "touch" err
run_case "$REPO_OWNER"   "$P_PRODUCTION";  check "3  owner + production mutation -> block" 2 "BLOCKED - production-mutation" err
run_case "$REPO_TRUSTED" "$P_DESTRUCTIVE"; check "4  trusted + destructive internal -> block" 2 "BLOCKED - destructive-internal" err
run_case "$REPO_TRUSTED" "$P_OUTWARD";     check "5  trusted + irreversible outward -> block" 2 "expires in 900s" err
run_case "$REPO_TEAM"    "$P_DESTRUCTIVE"; check "6  team + destructive internal -> confirm, not two-person" 2 "touch" err
run_case "$REPO_TEAM"    "$P_OUTWARD";     check "7  team + irreversible outward -> two-person" 2 "must NOT create the approval file" err
run_case "$REPO_NONE"    "$P_OUTWARD";     check "8  unresolved identity -> strictest tier" 2 "must NOT create the approval file" err
run_case "$REPO_NONE"    "$P_OUTWARD";     check "8b unresolved identity -> told how to fix identity" 2 "git config user.email" err
run_case "$REPO_TEAM"    "$P_REVERSIBLE";  check "9  any + reversible internal -> silent allow" 0 "-" none
run_case "$REPO_TEAM"    "$P_READ";        check "10 any + read -> silent allow" 0 "-" none

echo ""
echo "=== the cases that catch real defects ==="

# Case 11: the byte-offset case. A gate that greps only the opening bytes of the
# payload for a tool marker exits 0 here and logs nothing.
PAD=$(printf 'a%.0s' $(seq 1 400))
P_LATE="{\"session_id\":\"$PAD\",\"cwd\":\"/tmp\",\"hook_event_name\":\"PreToolUse\",\"tool_name\":\"mcp__instantly__activate_campaign\",\"tool_input\":{\"campaign_id\":\"c-99\"}}"
OFFSET=$(printf '%s' "$P_LATE" | grep -bo 'tool_name' | head -1 | cut -d: -f1)
run_case "$REPO_OWNER" "$P_LATE"
check "11 tool name at byte $OFFSET still blocks (no prefix scan)" 2 "BLOCKED" err

# Case 12: a batch key minted for an irreversible action must change nothing.
mkdir -p "$SAFETY_GUARD_APPROVAL_DIR"
touch "$SAFETY_GUARD_APPROVAL_DIR/batch-mcp__instantly__activate_campaign"
run_case "$REPO_TRUSTED" "$P_OUTWARD"
check "12 batch key on an irreversible action -> still blocked" 2 "BLOCKED - irreversible-outward" err
rm -f "$SAFETY_GUARD_APPROVAL_DIR/batch-mcp__instantly__activate_campaign"

# Case 13: the batch instruction is never printed on an irreversible block.
run_case "$REPO_TRUSTED" "$P_OUTWARD"
if grep -qF "batch-" "$LAST_ERR" 2>/dev/null; then
  FAIL=$((FAIL + 1)); echo "FAIL  13 batch instruction leaked into an irreversible block"
else
  PASS=$((PASS + 1)); echo "PASS  exit=$LAST_CODE  13 no batch instruction on an irreversible block"
fi
rm -f "$LAST_OUT" "$LAST_ERR"

# Case 14: a batch key on a destructive internal action is honoured, repeatedly.
touch "$SAFETY_GUARD_APPROVAL_DIR/batch-mcp__airtable__delete_records"
run_case "$REPO_TEAM" "$P_DESTRUCTIVE"; check "14 batch key on destructive internal -> allowed" 0 "-" none
run_case "$REPO_TEAM" "$P_DESTRUCTIVE"; check "14b batch key is multi-use inside the TTL" 0 "-" none
rm -f "$SAFETY_GUARD_APPROVAL_DIR/batch-mcp__airtable__delete_records"

# Case 15: a per-call approval is bound to the payload, single use, and a
# different payload for the same operation does not redeem it.
CANON=$(printf 'mcp__instantly__activate_campaign\n%s' "$(printf '%s' '{"campaign_id":"c-99","name":"Q3 outbound"}' | jq -S -c .)")
HASH=$(printf '%s' "$CANON" | shasum -a 256 | cut -d' ' -f1)
touch "$SAFETY_GUARD_APPROVAL_DIR/call-$HASH"
run_case "$REPO_TEAM" "$P_OUTWARD"; check "15 per-call approval on the exact payload -> allowed" 0 "-" none
run_case "$REPO_TEAM" "$P_OUTWARD"; check "15b same approval a second time -> blocked, it was consumed" 2 "BLOCKED" err

P_OUTWARD_OTHER='{"tool_name":"mcp__instantly__activate_campaign","tool_input":{"campaign_id":"c-100","name":"Q3 outbound"}}'
touch "$SAFETY_GUARD_APPROVAL_DIR/call-$HASH"
run_case "$REPO_TEAM" "$P_OUTWARD_OTHER"; check "16 approval for one payload does not cover another" 2 "BLOCKED" err
rm -f "$SAFETY_GUARD_APPROVAL_DIR/call-$HASH"

# Case 17: two message bodies sharing a long opening must not collide. This is
# the truncated-hashing defect, fired directly at the hasher.
OPEN=$(printf 'Hi there, quick note about your GTM stack. %.0s' $(seq 1 8))
P_A="{\"tool_name\":\"mcp__instantly__reply_to_email\",\"tool_input\":{\"to\":\"a@lead.example\",\"body\":\"$OPEN Can we talk Tuesday?\"}}"
P_B="{\"tool_name\":\"mcp__instantly__reply_to_email\",\"tool_input\":{\"to\":\"a@lead.example\",\"body\":\"$OPEN Sending the invoice now.\"}}"
CANON_A=$(printf 'mcp__instantly__reply_to_email\n%s' "$(printf '%s' "$P_A" | jq -S -c .tool_input)")
HASH_A=$(printf '%s' "$CANON_A" | shasum -a 256 | cut -d' ' -f1)
touch "$SAFETY_GUARD_APPROVAL_DIR/call-$HASH_A"
run_case "$REPO_TEAM" "$P_B"
check "17 messages sharing a 340-char opening do not share an approval" 2 "BLOCKED" err
run_case "$REPO_TEAM" "$P_A"; check "17b the approved body is the one that goes through" 0 "-" none

# Case 18: expiry. An approval older than the TTL is removed and named.
touch "$SAFETY_GUARD_APPROVAL_DIR/call-$HASH"
age_file "$SAFETY_GUARD_APPROVAL_DIR/call-$HASH"
run_case "$REPO_TEAM" "$P_OUTWARD"
check "18 expired approval -> blocked and the message says it expired" 2 "had expired" err
[ -f "$SAFETY_GUARD_APPROVAL_DIR/call-$HASH" ] && { FAIL=$((FAIL+1)); echo "FAIL  18b expired approval was not deleted"; } || { PASS=$((PASS+1)); echo "PASS  18b expired approval deleted on sight"; }

echo ""
echo "=== shell companion path ==="
run_case "$REPO_OWNER" '{"tool_name":"Bash","tool_input":{"command":"git push --force origin main"}}'
check "19 owner + force push -> warn, allow (destructive internal)" 0 "allowed with a warning" out
run_case "$REPO_TEAM" '{"tool_name":"Bash","tool_input":{"command":"rm -rf ./clients"}}'
check "20 team + recursive delete -> block" 2 "BLOCKED - destructive-internal" err
run_case "$REPO_OWNER" '{"tool_name":"Bash","tool_input":{"command":"psql -c \"DROP TABLE accounts\""}}'
check "21 owner + drop table -> block (production mutation)" 2 "BLOCKED - production-mutation" err
run_case "$REPO_OWNER" '{"tool_name":"Bash","tool_input":{"command":"curl -X POST https://api.livesystem.example/v1/send"}}'
check "22 curl at a roster guarded-host -> block, names the better path" 2 "guarded action" err
run_case "$REPO_OWNER" '{"tool_name":"Bash","tool_input":{"command":"git config user.email someone@else.example"}}'
check "23 rewriting the committer identity is itself guarded" 2 "BLOCKED - production-mutation" err
run_case "$REPO_OWNER" '{"tool_name":"Bash","tool_input":{"command":"git status && ls -la"}}'
check "24 ordinary shell work is untouched" 0 "-" none

echo ""
echo "=== fail closed, and the not-guarded list ==="
run_case "$REPO_OWNER" "$P_OUTWARD" "PATH=$WORK/bin"
check "25 missing jq -> blocks with a one-line install fix" 2 "brew install jq" err
grep -q "blocked-dependency" "$SAFETY_GUARD_LOG" \
  && { PASS=$((PASS+1)); echo "PASS  25b the dependency failure is in the audit log"; } \
  || { FAIL=$((FAIL+1)); echo "FAIL  25b a dependency failure left no trace"; }
run_case "$REPO_TEAM" '{"tool_name":"mcp__claude_ai_Google_Calendar__delete_event","tool_input":{"eventId":"e1"}}'
check "26 calendar write is deliberately not guarded" 0 "-" none
run_case "$REPO_TEAM" '{"tool_name":"mcp__github__create_issue","tool_input":{"title":"bug"}}'
check "27 code-host issue is deliberately not guarded" 0 "-" none
run_case "$REPO_TEAM" '{"tool_name":"mcp__claude_ai_Gmail__create_draft","tool_input":{"to":"a@b.example"}}'
check "28 mail draft is deliberately not guarded" 0 "-" none

echo ""
echo "=== coverage rot backstop ==="
run_case "$REPO_TEAM" '{"tool_name":"mcp__brandnew_v3__start_campaign","tool_input":{"id":"c1"}}'
check "29 a connector nobody listed is guarded by default" 2 "BLOCKED - irreversible-outward" err
run_case "$REPO_TEAM" '{"tool_name":"mcp__brandnew_v3__add_leads_to_campaign_bulk","tool_input":{"leads":[1,2,3]}}'
check "30 adding contacts to a live sequence classes as outward" 2 "BLOCKED - irreversible-outward" err

echo ""
echo "=== real connector names, not invented ones ==="
# Cases 29 and 30 used invented names, which is how a suite reports a pass over a
# hole. Every name below is a real connector operation, and each one exited 0
# silently before the read allowlist was vetoed by the guarded verbs: one
# allowlisted token anywhere in the name won outright.
run_case "$REPO_TEAM" '{"tool_name":"mcp__heyreach__delete_leads_from_list","tool_input":{"listId":7,"leads":["a","b"]}}'
check "38 delete_leads_from_LIST is a delete, not a list read" 2 "BLOCKED - destructive-internal" err
run_case "$REPO_TEAM" '{"tool_name":"mcp__instantly__move_leads_to_campaign_or_list","tool_input":{"campaign_id":"c-1"}}'
check "39 move_leads_to_campaign_or_LIST is outward" 2 "BLOCKED - irreversible-outward" err
run_case "$REPO_TEAM" '{"tool_name":"mcp__instantly__add_leads_to_campaign_or_list_bulk","tool_input":{"leads":[1,2]}}'
check "40 add_leads_to_campaign_or_LIST_bulk is outward" 2 "BLOCKED - irreversible-outward" err
run_case "$REPO_TEAM" '{"tool_name":"mcp__crm__find_and_delete_duplicates","tool_input":{"ids":["a"]}}'
check "41 FIND_and_delete_duplicates is a delete" 2 "BLOCKED - destructive-internal" err
run_case "$REPO_TEAM" '{"tool_name":"mcp__heyreach__update_campaign_sequence","tool_input":{"campaignId":9,"steps":[]}}'
check "42 editing a live sequence reaches the same people as activating it" 2 "BLOCKED - irreversible-outward" err
run_case "$REPO_TEAM" '{"tool_name":"mcp__airtable__update_records","tool_input":{"tableId":"tbl1","records":[1,2]}}'
check "43 a bulk CRM write is guarded" 2 "BLOCKED - destructive-internal" err
run_case "$REPO_TEAM" '{"tool_name":"mcp__ocean__export_people_to_webhook","tool_input":{"url":"https://hook.example"}}'
check "44 an export to an arbitrary endpoint is outward" 2 "BLOCKED - irreversible-outward" err
run_case "$REPO_TEAM" '{"tool_name":"mcp__plugin_stripe_stripe__stripe_api_write","tool_input":{"amount":50000}}'
check "45 the successor twin under a repackaged namespace is still guarded" 2 "BLOCKED" err
run_case "$REPO_TEAM" '{"tool_name":"mcp__n8n__n8n_create_workflow","tool_input":{"name":"live sync"}}'
check "46 creating a production automation is a production mutation" 2 "BLOCKED - production-mutation" err
# The other half of the same rule: reads that merely contain a guarded-looking
# word must stay silent, or the veto has bought coverage with an approval treadmill.
run_case "$REPO_TEAM" '{"tool_name":"mcp__heyreach__get_campaign_sequence","tool_input":{"campaignId":9}}'
check "47 reading a sequence is still silent" 0 "-" none
run_case "$REPO_TEAM" '{"tool_name":"mcp__instantly__list_campaigns","tool_input":{}}'
check "48 listing campaigns is still silent" 0 "-" none
run_case "$REPO_TEAM" '{"tool_name":"mcp__trigger-dev__get_run_details","tool_input":{"runId":"r1"}}'
check "49 a read whose name contains run is still silent" 0 "-" none

echo ""
echo "=== payloads the gate cannot read ==="
# Every one of these exited 0 with no output and no audit row before the parse
# check existed. Truncation is the shape an oversized or partially written
# payload takes, and a reshaped payload is what a runtime change looks like.
run_case "$REPO_OWNER" '{"tool_name":"mcp__instantly__activate_camp'
check "50 truncated JSON blocks rather than parsing to nothing" 2 "could not parse" err
run_case "$REPO_OWNER" 'not json at all, tool_name mcp__stripe__create_refund'
check "51 a body that is not JSON blocks" 2 "could not parse" err
run_case "$REPO_OWNER" '{"toolName":"mcp__instantly__reply_to_email","tool_input":{}}'
check "52 the action under a different key blocks rather than passing" 2 "found no action" err
run_case "$REPO_OWNER" '{"params":{"tool_name":"mcp__stripe__create_refund"}}'
check "53 the action nested one level deeper blocks" 2 "found no action" err
run_case "$REPO_OWNER" '[{"tool_name":"mcp__stripe__create_refund"}]'
check "54 a top-level array blocks" 2 "found no action" err
grep -q "blocked-unparseable" "$SAFETY_GUARD_LOG" \
  && { PASS=$((PASS+1)); echo "PASS  55 an unparseable payload leaves an audit row"; } \
  || { FAIL=$((FAIL+1)); echo "FAIL  55 an unparseable payload left no trace"; }
grep -q "blocked-unparsed" "$SAFETY_GUARD_LOG" \
  && { PASS=$((PASS+1)); echo "PASS  56 a reshaped payload leaves an audit row"; } \
  || { FAIL=$((FAIL+1)); echo "FAIL  56 a reshaped payload left no trace"; }
run_case "$REPO_OWNER" ''
check "57 genuinely empty stdin is the one clean exit" 0 "-" none

echo ""
echo "=== no friction on ordinary work ==="
# Over-guarding is what gets a gate switched off, so the everyday path has to be
# provably silent. Every case here must exit 0 and print nothing at all.
for t in \
  '{"tool_name":"Write","tool_input":{"file_path":"company-wiki/icp.md","content":"..."}}' \
  '{"tool_name":"Edit","tool_input":{"file_path":"company-wiki/icp.md","old_string":"a","new_string":"b"}}' \
  '{"tool_name":"Read","tool_input":{"file_path":"company-wiki/icp.md"}}' \
  '{"tool_name":"Grep","tool_input":{"pattern":"icp"}}' \
  '{"tool_name":"WebFetch","tool_input":{"url":"https://example.com"}}' \
  '{"tool_name":"TodoWrite","tool_input":{"todos":[]}}' \
  '{"tool_name":"Task","tool_input":{"prompt":"summarise the account notes"}}' \
  '{"tool_name":"Bash","tool_input":{"command":"npm test"}}' \
  '{"tool_name":"Bash","tool_input":{"command":"git commit -m \"wiki: refresh icp\""}}' \
  '{"tool_name":"Bash","tool_input":{"command":"git push origin main"}}' \
  '{"tool_name":"mcp__hubspot__get_crm_objects","tool_input":{"objectType":"deals"}}'
do
  run_case "$REPO_TEAM" "$t"
  label=$(printf '%s' "$t" | jq -r '.tool_name + " " + ((.tool_input.command // .tool_input.file_path // "") | tostring)')
  check "37 silent on ordinary work: $label" 0 "-" none
done

echo ""
echo "=== audit log ==="
ALLOWS=$(grep -cE 'warned-owner|allowed-confirm|allowed-batch|allowed-two-person' "$SAFETY_GUARD_LOG" 2>/dev/null || echo 0)
BLOCKS=$(grep -cE 'blocked-confirm|blocked-two-person|blocked-dependency' "$SAFETY_GUARD_LOG" 2>/dev/null || echo 0)
FIELDS=$(head -1 "$SAFETY_GUARD_LOG" | awk -F'\t' '{print NF}')
echo "allow rows: $ALLOWS   block rows: $BLOCKS   fields per row: $FIELDS"
[ "$ALLOWS" -gt 0 ] && [ "$BLOCKS" -gt 0 ] && [ "$FIELDS" = 7 ] \
  && { PASS=$((PASS+1)); echo "PASS  31 log carries both allows and blocks, 7 tab-separated fields"; } \
  || { FAIL=$((FAIL+1)); echo "FAIL  31 log schema or decision coverage is wrong"; }

echo ""
echo "=== session modes ==="
touch "$SAFETY_GUARD_APPROVAL_DIR/batch-leftover"
echo '{}' | bash "$GUARD" --session-end >/dev/null 2>&1
[ -f "$SAFETY_GUARD_APPROVAL_DIR/batch-leftover" ] \
  && { FAIL=$((FAIL+1)); echo "FAIL  32 session close left an approval behind for the next session"; } \
  || { PASS=$((PASS+1)); echo "PASS  32 session close clears every approval token"; }
OUT=$(echo '{}' | bash "$GUARD" --session-start 2>&1)
printf '%s' "$OUT" | grep -q "Safety guard active" \
  && { PASS=$((PASS+1)); echo "PASS  33 session start prints the active policy"; } \
  || { FAIL=$((FAIL+1)); echo "FAIL  33 session start banner missing"; }
# </dev/null on purpose: a session or probe mode that reads stdin blocks until EOF,
# which hangs this suite for a human at a terminal rather than for CI.
OUT=$(bash "$GUARD" --synthetic </dev/null 2>&1); CODE=$?
if [ "$CODE" = 0 ] && grep -q "synthetic-block" "$SAFETY_GUARD_LOG"; then
  PASS=$((PASS+1)); echo "PASS  34 the synthetic probe really fires and is blocked, row tagged"
else
  FAIL=$((FAIL+1)); echo "FAIL  34 synthetic probe exited $CODE or left no tagged row"
fi

echo '{}' | bash "$GUARD" --not-a-mode >/dev/null 2>&1
[ $? = 2 ] \
  && { PASS=$((PASS+1)); echo "PASS  35 an unrecognised mode fails loudly rather than silently allowing"; } \
  || { FAIL=$((FAIL+1)); echo "FAIL  35 an unrecognised mode did not fail closed"; }

rm -f "$WORK/roster"
OUT=$(echo '{}' | bash "$GUARD" --session-start 2>&1)
printf '%s' "$OUT" | grep -q "MISSING" \
  && { PASS=$((PASS+1)); echo "PASS  36 a missing roster is announced, not silently assumed"; } \
  || { FAIL=$((FAIL+1)); echo "FAIL  36 missing roster was not announced"; }

echo ""
echo "=== the evidence trail: every logged line must parse ==="
# The audit log answers "was this action decided on". The session log answers
# "did the gate run at all", and it only answers that if the file is readable.
# One malformed line takes the whole file down, because jq aborts at the first bad
# record rather than skipping it, and the payloads worth inspecting are the large
# ones. A 3KB Write payload used to produce an invalid line.
LOGGER="$(dirname "$GUARD")/session-logger.sh"
if [ -f "$LOGGER" ]; then
  mkdir -p "$WORK/hooks"
  cp "$LOGGER" "$WORK/hooks/session-logger.sh"
  BIG=$(printf 'x%.0s' $(seq 1 3000))
  printf '%s' "{\"hook_event_name\":\"PreToolUse\",\"session_id\":\"s1\",\"tool_name\":\"Write\",\"tool_input\":{\"file_path\":\"company-wiki/x.md\",\"content\":\"$BIG\"}}" \
    | bash "$WORK/hooks/session-logger.sh" >/dev/null 2>&1
  printf '%s' '{"hook_event_name":"PreToolUse","session_id":"s1","tool_name":"Bash","tool_input":{"command":"echo \"quoted\" && ls"}}' \
    | bash "$WORK/hooks/session-logger.sh" >/dev/null 2>&1
  printf '%s' '{"hook_event_name":"Stop","session_id":"s1"}' \
    | bash "$WORK/hooks/session-logger.sh" >/dev/null 2>&1
  if [ -s "$WORK/sessions/s1.jsonl" ] && jq -e . "$WORK/sessions/s1.jsonl" >/dev/null 2>&1; then
    PASS=$((PASS+1)); echo "PASS  58 every line of the session log parses, oversized payload included"
  else
    FAIL=$((FAIL+1)); echo "FAIL  58 the session log has a line jq cannot read"
  fi
else
  echo "SKIP  58 session-logger.sh not found beside the guard"
fi

echo ""
echo "$PASS passed, $FAIL failed"
[ "$FAIL" = 0 ] || exit 1
