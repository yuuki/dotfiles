# Claude Code 会話の Obsidian 自動記録 Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Claude Code の全セッション会話を `~/obsidian/research/ailogs/claudecode` に日次で追記し、変更があれば自動で git commit する。

**Architecture:** `~/.claude/projects/**/session.jsonl` を5秒ポーリングし、最新アクティブセッションの新規行のみを jq で整形して Markdown に追記する。`~/Library/LaunchAgents` の LaunchAgent で常駐起動する。

**Tech Stack:** bash, jq, launchd (LaunchAgent), git

---

### Task 1: 監視スクリプトの追加

**Files:**
- Create: `dot_claude/hooks/watch-and-save.sh`
- Create: `dot_claude/logs/.keep`

**Step 1: Write the failing test**

- 代替として手動検証用の想定を定義する（テストフレームワーク無し）:
  - 空の `session.jsonl` を用意した場合は追記が発生しない
  - 1行追加すると当日ファイルに1件だけ追記される

**Step 2: Run test to verify it fails**

- 手動検証: `watch-and-save.sh` 実装前なので上記想定は満たせない（未実装）。

**Step 3: Write minimal implementation**

- `#!/bin/bash` + `set -eu` + `set -o pipefail`
- 監視対象: `SESSION_DIR="$HOME/.claude/projects"`
- 出力先: `OBSIDIAN_DIR="$HOME/obsidian/research/ailogs/claudecode"`
- Obsidian リポジトリ: `OBSIDIAN_REPO="$HOME/obsidian/research"`
- ログ/状態: `STATE_DIR="$HOME/.claude/obsidian-sync"`、`mkdir -p` で作成
- 最新セッション探索（subagents除外）: `find ... -mmin -60 -size +1000c` を使用
- セッションごとの last-line 管理: `session_file` からハッシュを作成し `last-synced-line-<hash>` に保存
- 当日開始時刻をUTC ISOで算出し、jqで `.timestamp` を日付フィルタ
- ノイズ除外: `<local-command|<command-name|<system-reminder|<task-notification>` と `No response requested`
- 追記があれば `git -C "$OBSIDIAN_REPO" add` → `git commit -m "Claude Code: ${TODAY} (auto)"` を実行（失敗は無視）

**Step 4: Run test to verify it passes**

- 手動検証:
  - `bash -n ~/.claude/hooks/watch-and-save.sh` で構文チェック
  - `session.jsonl` に1行追加して `~/obsidian/research/ailogs/claudecode/YYYY-MM-DD.md` に追記されることを確認

**Step 5: Commit**

```bash
git add dot_claude/hooks/watch-and-save.sh dot_claude/logs/.keep
git commit -m "claude: add watch-and-save hook"
```

### Task 2: LaunchAgent の追加

**Files:**
- Create: `Library/LaunchAgents/com.claude.obsidian-sync.plist`

**Step 1: Write the failing test**

- 代替として手動検証用の想定を定義する（テストフレームワーク無し）:
  - `launchctl list` に `com.claude.obsidian-sync` が表示される

**Step 2: Run test to verify it fails**

- 手動検証: plist 未作成のため `launchctl list | grep com.claude.obsidian-sync` は失敗する。

**Step 3: Write minimal implementation**

- LaunchAgent を `~/Library/LaunchAgents` に配置
- `ProgramArguments`: `/bin/bash` と `~/.claude/hooks/watch-and-save.sh`
- `RunAtLoad` / `KeepAlive` を有効化
- `StandardOutPath` / `StandardErrorPath`: `~/.claude/logs/*.log`

**Step 4: Run test to verify it passes**

- 手動検証:
  - `mkdir -p ~/.claude/logs`
  - `launchctl load ~/Library/LaunchAgents/com.claude.obsidian-sync.plist`
  - `launchctl list | grep com.claude.obsidian-sync` が表示される

**Step 5: Commit**

```bash
git add Library/LaunchAgents/com.claude.obsidian-sync.plist
git commit -m "claude: add launchagent for obsidian sync"
```

### Task 3: 最低限の使用手順を README に追記（任意）

**Files:**
- Modify: `README.md`

**Step 1: Write the failing test**

- 代替として手動検証用の想定を定義する（ドキュメントのみ）:
  - セットアップ手順が README に記載されている

**Step 2: Run test to verify it fails**

- 既存 README に手順が無ければ未達成。

**Step 3: Write minimal implementation**

- `make apply` 後の手順として:
  - `mkdir -p ~/.claude/logs`
  - `launchctl load ~/Library/LaunchAgents/com.claude.obsidian-sync.plist`
  - `launchctl list | grep com.claude.obsidian-sync`

**Step 4: Run test to verify it passes**

- README で手順を確認。

**Step 5: Commit**

```bash
git add README.md
git commit -m "docs: add setup steps for claude obsidian logging"
```
