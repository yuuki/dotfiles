# Codex CLI 会話の Obsidian 自動記録 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Codex CLI の会話ログを `~/obsidian/research/ailogs/codex` に日次で追記し、変更があれば自動で git commit する。

**Architecture:** `~/.codex/sessions/**/rollout-*.jsonl` を10秒ポーリングし、最新ファイルの新規行のみを jq で整形して Markdown に追記する。`~/Library/LaunchAgents` の LaunchAgent で常駐起動する。

**Tech Stack:** bash, jq, launchd (LaunchAgent), git

---

### Task 1: 監視スクリプトの追加

**Files:**
- Create: `dot_codex/hooks/watch-and-save.sh`
- Create: `dot_codex/logs/.keep`

**Step 1: Write the failing test**

- 代替として手動検証用の想定を定義する（テストフレームワーク無し）:
  - 空の rollout jsonl の場合は追記が発生しない
  - 1行追加すると当日ファイルに1件だけ追記される

**Step 2: Run test to verify it fails**

- 手動検証: `watch-and-save.sh` 未実装のため上記想定は満たせない。

**Step 3: Write minimal implementation**

- `#!/bin/bash` + `set -eu` + `set -o pipefail`
- 監視対象: `SESSION_DIR="$HOME/.codex/sessions"`
- 出力先: `OBSIDIAN_DIR="$HOME/obsidian/research/ailogs/codex"`
- Obsidian リポジトリ: `OBSIDIAN_REPO="$HOME/obsidian/research"`
- 状態: `STATE_DIR="$HOME/.codex/obsidian-sync"`
- ログ: `LOG_DIR="$HOME/.codex/logs"`
- 最新ファイル探索: `find ... -name "rollout-*.jsonl" -mmin -60 -size +1000c`
- `last-synced-line` で差分抽出
- 当日開始時刻をUTC ISOで算出し、jqで `.timestamp` を日付フィルタ
- `response_item`/`message`/`role=user|assistant` の `input_text`/`output_text` のみ抽出
- `No response requested` は除外
- 追記があれば `git -C "$OBSIDIAN_REPO" add` → `git commit -m "Codex CLI: ${TODAY} (auto)"`（失敗は無視）
- ポーリング間隔: `sleep 10`

**Step 4: Run test to verify it passes**

- 手動検証:
  - `bash -n ~/.codex/hooks/watch-and-save.sh` で構文チェック
  - rollout jsonl に1行追加して `~/obsidian/research/ailogs/codex/YYYY-MM-DD.md` に追記されることを確認

**Step 5: Commit**

```bash
git add dot_codex/hooks/watch-and-save.sh dot_codex/logs/.keep
git commit -m "codex: add watch-and-save hook"
```

### Task 2: LaunchAgent の追加

**Files:**
- Create: `Library/LaunchAgents/com.codex.obsidian-sync.plist.tmpl`

**Step 1: Write the failing test**

- 代替として手動検証用の想定を定義する（テストフレームワーク無し）:
  - `launchctl list` に `com.codex.obsidian-sync` が表示される

**Step 2: Run test to verify it fails**

- 手動検証: plist 未作成のため `launchctl list | grep com.codex.obsidian-sync` は失敗する。

**Step 3: Write minimal implementation**

- LaunchAgent を `~/Library/LaunchAgents` に配置
- `ProgramArguments`: `/bin/bash` と `~/.codex/hooks/watch-and-save.sh`
- `RunAtLoad` / `KeepAlive` を有効化
- `StandardOutPath` / `StandardErrorPath`: `~/.codex/logs/*.log`

**Step 4: Run test to verify it passes**

- 手動検証:
  - `mkdir -p ~/.codex/logs`
  - `launchctl load ~/Library/LaunchAgents/com.codex.obsidian-sync.plist`
  - `launchctl list | grep com.codex.obsidian-sync` が表示される

**Step 5: Commit**

```bash
git add Library/LaunchAgents/com.codex.obsidian-sync.plist.tmpl
git commit -m "codex: add launchagent for obsidian sync"
```
