# dotfiles

Personal configuration files for macOS.

## What's included

| Config | Location |
|---|---|
| Ghostty | `~/Library/Application Support/com.mitchellh.ghostty/config` |
| zsh (`.zshrc`, `.zshenv`, `.zprofile`) | `~/` |
| Git (`.gitconfig`, `.gitignore_global`) | `~/` |
| VS Code `settings.json` | `~/Library/Application Support/Code/User/` |

## Install

```sh
git clone https://github.com/mattiel/dotfiles ~/.dotfiles
~/.dotfiles/install.sh
```

The install script will:
- Install Homebrew if missing
- Run `brew bundle` to install packages and apps
- Symlink all configs to the correct locations
- Back up any existing files to `~/.dotfiles_backup/` before overwriting

It's safe to re-run — existing symlinks are skipped.

## Brewfile

| Type | Packages |
|---|---|
| CLI | `gh`, `git`, `node`, `pure`, `tree`, `zsh-syntax-highlighting` |
| Apps | Ghostty, Raycast |
