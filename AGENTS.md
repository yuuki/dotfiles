# Repository Guidelines

This repository is a `chezmoi`-managed dotfiles collection. Make changes in this repo (the **source**), not directly in the destination files under `$HOME`.

## Project Structure & Module Organization

- `dot_*`: files that map to `~/.<name>` (e.g. `dot_gitconfig` → `~/.gitconfig`).
- `dot_config/**`: files that map to `~/.config/**` (e.g. `dot_config/fish/**`).
- Directories listed in `.chezmoiignore` (e.g. `zsh/`, `fish/`, `tmux/`, `alacritty/`) are **not managed by chezmoi** here (kept mainly for reference/migration). Prefer editing `dot_*` / `dot_config/**`.
- `script/` and `bin/`: helper scripts (keep executable bits; intended for use from `$PATH`).

## Build, Test, and Development Commands

- `make apply`: apply this repo as the source (`chezmoi -S $(CURDIR) apply --mode symlink`).
- `make diff`: show pending changes before applying (recommended before commits/PRs).
- `make verify`: verify the destination matches the desired state.
- First-time setup: `chezmoi init yuuki/dotfiles --apply`
- Import an existing file: `chezmoi add ~/.gitconfig` (use `--follow` to import the contents of a symlink).

## Coding Style & Naming Conventions

- Keep the existing naming scheme: new managed files should be `dot_<name>` or under `dot_config/<app>/...`.
- Shell scripts are `bash`. Prefer safe defaults for new/updated scripts: `set -eu` (and add `-o pipefail` when pipelines matter).
- Match surrounding formatting and keep diffs minimal.

## Testing Guidelines

There is no unit-test suite. Treat the following as the verification flow:

- `make diff` to review the exact changes
- `make verify` to confirm applied state
- Optional script checks: `bash -n script/<name>` and/or `shellcheck script/<name>`

## Commit & Pull Request Guidelines

- Prefer short, scoped subjects seen in history (e.g. `fish: ...`, `docs: ...`, `tmux: ...`).
- PRs should include: summary, target OS (macOS/Linux), and what you ran (e.g. `make diff`, `make verify`).

## Security & Configuration Tips

- Do not commit secrets (tokens, keys, personal data). Keep machine-specific values in local `chezmoi` config (e.g. `~/.config/chezmoi/chezmoi.toml`) or outside the repo.
- **NEVER** put raw credentials in this repository or in documentation files (including `AGENTS.md`): API keys, access tokens, passwords, private keys, cookies, or similar authentication material.
- Retrieve credentials via the 1Password CLI `op` command (e.g. `op read "op://<Vault>/<Item>/<field>"` or `op run -- <command>`), and never hardcode secrets in files.
- Use `make apply-force` only for recovery; normal flow is `diff` → `apply` → `verify`.
