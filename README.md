# dotfiles

This repository is managed with [chezmoi](https://www.chezmoi.io/).

## Quick start

1. Install `chezmoi`.
2. Initialize and apply:

```sh
chezmoi init yuuki/dotfiles --apply
```

By default, chezmoi uses `~/.local/share/chezmoi` as the source directory.

## Daily workflow

Edit files in the chezmoi source directory (e.g. `dot_gitconfig`, `dot_config/...`), then apply:

```sh
chezmoi apply
```

Inspect changes before applying:

```sh
chezmoi diff
```

Verify destination matches the desired state:

```sh
chezmoi verify
```

Pull upstream changes and apply:

```sh
chezmoi update
```

## Symlink mode

This repo is intended to be applied in symlink mode:

```sh
chezmoi apply --mode symlink
```

You can also set this permanently in `~/.config/chezmoi/chezmoi.toml`:

```toml
mode = "symlink"
```

## Using this repo as source directly (optional)

If you keep this repo cloned somewhere else (e.g. `~/src/github.com/yuuki/dotfiles`), you can run:

```sh
chezmoi -S ~/src/github.com/yuuki/dotfiles apply --mode symlink
```

Or set `sourceDir` in `~/.config/chezmoi/chezmoi.toml`:

```toml
sourceDir = "/absolute/path/to/dotfiles"
mode = "symlink"
```

## Adding new dotfiles

To start managing an existing file:

```sh
chezmoi add ~/.gitconfig
```

If the file is currently a symlink and you want to import its contents (recommended during migration):

```sh
chezmoi add --follow ~/.gitconfig
```

## Makefile helpers

If you are using this repository as the source directory, you can also use:

```sh
make apply
make diff
make verify
```
