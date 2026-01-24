# Codex CLI 会話の Obsidian 自動記録 設計

## 目的
Codex CLI の会話ログを、Mac 上の Obsidian リポジトリ `~/obsidian/research/ailogs/codex` に日次で追記し、追記が発生した場合に自動で git commit する。

## スコープ
- 対象 OS: macOS
- 対象ログ: `~/.codex/sessions/**/rollout-*.jsonl` の最新ファイル
- 出力形式: `YYYY-MM-DD.md` / 見出し `# YYYY-MM-DD Conversations with Codex CLI`
- 追記方式: 既存ファイルに追記（重複防止）
- 自動コミット: 追記が発生した時のみ `~/obsidian/research` で実行
- ポーリング間隔: 10秒
- 収集対象: ユーザー/アシスタントの会話のみ（ツール実行・メタ情報は除外）

## アーキテクチャ
1) 監視スクリプト: `~/.codex/hooks/watch-and-save.sh`
- 10秒ごとに最新アクティブな rollout jsonl を検出
- `last-synced-line` で差分抽出（新規行のみ）
- jsonl を Markdown へ整形して追記
- 追記があれば Obsidian リポジトリで `git add/commit`

2) 起動エージェント: `~/Library/LaunchAgents/*.plist`
- ログイン時に監視を常駐起動

## データフロー
- rollout jsonl の新規行を jq で解析
- `response_item` の `message` かつ role が `user` / `assistant` のみ抽出
- 日付フィルタは当日開始時刻（ローカル日付の 00:00 を UTC に変換）を使用
- 変換結果を日次ファイル末尾へ追記
- 追記があった場合のみ git commit

## エラーハンドリング
- 出力先/対象ファイル不存在時はディレクトリ作成
- jq 失敗時は行をスキップしログに記録
- Obsidian リポジトリが未初期化なら commit をスキップ

## テスト/検証
- 手動で `watch-and-save.sh` を実行し、追記が行われるか確認
- `make diff` / `make verify` で chezmoi 差分を確認

## 変更予定ファイル
- 追加: `dot_codex/hooks/watch-and-save.sh`
- 追加: `dot_codex/logs/.keep`
- 追加: `Library/LaunchAgents/com.codex.obsidian-sync.plist.tmpl`
