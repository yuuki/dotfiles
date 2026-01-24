#!/bin/bash
set -eu
set -o pipefail

PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"

SESSION_DIR="$HOME/.codex/sessions"
OBSIDIAN_DIR="$HOME/obsidian/research/ailogs/codex"
OBSIDIAN_REPO="$HOME/obsidian/research"
STATE_DIR="$HOME/.codex/obsidian-sync"
LOG_DIR="$HOME/.codex/logs"

mkdir -p "$OBSIDIAN_DIR" "$STATE_DIR" "$LOG_DIR"

iso_today_start_utc() {
  local today tz
  today=$(date +%Y-%m-%d)
  tz=$(date +%z)
  TZ=UTC date -j -f "%Y-%m-%d %H:%M:%S %z" "$today 00:00:00 $tz" +%Y-%m-%dT%H:%M:%S 2>/dev/null
}

latest_rollout_file() {
  local files
  files=$(find "$SESSION_DIR" -name "rollout-*.jsonl" -type f -mmin -60 -size +1000c -print 2>/dev/null)
  if [ -z "$files" ]; then
    return 0
  fi
  printf '%s\n' "$files" | xargs ls -t 2>/dev/null | head -1
}

append_new_messages() {
  local session_file output_file today today_start_utc
  session_file="$1"
  today=$(date +%Y-%m-%d)
  today_start_utc=$(iso_today_start_utc)

  output_file="$OBSIDIAN_DIR/$today.md"
  if [ ! -f "$output_file" ]; then
    printf '# %s Conversations with Codex CLI\n\n' "$today" > "$output_file"
  fi

  local session_key last_line_file last_line current_lines
  session_key=$(printf '%s' "$session_file" | shasum | awk '{print $1}')
  last_line_file="$STATE_DIR/last-synced-line-$session_key"
  if [ -f "$last_line_file" ]; then
    last_line=$(cat "$last_line_file")
  else
    last_line=0
  fi

  current_lines=$(wc -l < "$session_file" | tr -d ' ')
  if [ "$current_lines" -le "$last_line" ]; then
    return 0
  fi

  local new_content
  new_content=$(tail -n +$((last_line + 1)) "$session_file" | jq -r --arg today_start "$today_start_utc" '
    def time_of($ts):
      if ($ts | length) > 0 then
        (try ($ts | fromdateiso8601 | strftime("%H:%M")) catch "??:??")
      else
        "??:??"
      end;
    def key_of($text):
      ($text | split("\n")[0]) as $first
      | if ($first | length) > 80 then ($first[0:80] + "…") else $first end;
    select((.timestamp // "9999") >= $today_start)
    | select(.type == "response_item")
    | (.timestamp // "") as $ts
    | .payload as $p
    | select($p.type == "message")
    | select($p.role == "user" or $p.role == "assistant")
    | ($p.content | map(select(.type == "input_text" or .type == "output_text") | (.text // "")) | join("\n")) as $all_text
    | if ($all_text | test("<INSTRUCTIONS>"; "i")) then
        empty
      else
        $p.content[]?
        | if $p.role == "user" then
            select(.type == "input_text")
            | select(.text | length > 0)
            | .text as $text
            | ("## " + (time_of($ts)) + " User\n- key: " + (key_of($text)) + " / tags: user\n" + $text + "\n\n---")
          else
            select(.type == "output_text")
            | select(.text | length > 0)
            | select(.text | test("^No response requested"; "i") | not)
            | .text as $text
            | ("## " + (time_of($ts)) + " Codex\n- key: " + (key_of($text)) + " / tags: codex\n" + $text + "\n\n---")
          end
      end
  ' 2>/dev/null || true)

  if [ -n "$new_content" ]; then
    printf '%s\n\n' "$new_content" >> "$output_file"

    if [ -d "$OBSIDIAN_REPO/.git" ]; then
      (
        cd "$OBSIDIAN_REPO"
        git add "$output_file" >/dev/null 2>&1 || true
        git commit -m "Codex CLI: $today (auto)" >/dev/null 2>&1 || true
      )
    fi
  fi

  echo "$current_lines" > "$last_line_file"
}

main() {
  if ! command -v jq >/dev/null 2>&1; then
    echo "jq not found" >&2
    exit 1
  fi

  while true; do
    local session_file
    session_file=$(latest_rollout_file)
    if [ -n "$session_file" ] && [ -f "$session_file" ]; then
      append_new_messages "$session_file"
    fi
    sleep 10
  done
}

main
