# Claude Code 会話の Obsidian 自動記録 設計

## 目的
Claude Code の全セッション会話を、Mac 上の Obsidian リポジトリ `~/obsidian/research/ailogs/claudecode` に日次で追記し、必要に応じて自動で git commit する。

## スコープ
- 対象 OS: macOS
- 対象ログ: `~/.claude/projects/**/session.jsonl` の最新アクティブセッション
- 出力形式: `YYYY-MM-DD.md` / 見出し `# YYYY-MM-DD Conversations with Claude Code`
- 追記方式: 既存ファイルに追記（重複防止）
- 自動コミット: 追記が発生した時のみ `~/obsidian/research` で実行

## アーキテクチャ
1) 監視スクリプト: `~/.claude/hooks/watch-and-save.sh`
- 5秒ごとに最新アクティブセッションを検出
- `last-synced-line` で差分抽出（新規行のみ）
- jsonl を Markdown へ整形して追記
- 追記があれば Obsidian リポジトリで `git add/commit`

2) 起動エージェント: `~/Library/LaunchAgents/*.plist`
- ログイン時に監視を常駐起動

## データフロー
- `session.jsonl` の新規行を jq で解析
- 役割/種類に応じて以下を除外: system / local-command / tool 等
- 変換結果を日付ファイル末尾へ追記
- 追記があった場合のみ git commit

## エラーハンドリング
- 出力先/対象ファイル不存在時はディレクトリ作成
- jq 失敗時は行をスキップしログに記録
- Obsidian リポジトリが未初期化なら commit をスキップ

## テスト/検証
- 手動で `watch-and-save.sh` を実行し、追記が行われるか確認
- `make diff` / `make verify` で chezmoi 差分を確認

## 変更予定ファイル
- 追加: `dot_claude/hooks/watch-and-save.sh`
- 追加: `dot_claude/Library/LaunchAgents/claude-watch-and-save.plist`（仮）
- 変更: 必要に応じて `dot_claude/settings.json`（Hook連携が必要なら）

