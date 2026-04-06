#!/usr/bin/env zsh

set -e

DOTFILES="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo "==> Starting dotfiles install from $DOTFILES"

# --- Helpers ---

link() {
  local src="$DOTFILES/$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "    [skip] $dst already linked"
    return
  fi

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dst" "$BACKUP_DIR/"
    echo "    [backup] $dst -> $BACKUP_DIR/"
  fi

  ln -sf "$src" "$dst"
  echo "    [link] $dst -> $src"
}

# --- Homebrew ---

echo ""
echo "==> Homebrew"

if ! command -v brew &>/dev/null; then
  echo "    Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle --file="$DOTFILES/Brewfile"

# --- Symlinks ---

echo ""
echo "==> Symlinking configs"

# Shell
link "zsh/.zshrc"   "$HOME/.zshrc"
link "zsh/.zshenv"  "$HOME/.zshenv"
link "zsh/.zprofile" "$HOME/.zprofile"

# Git
link "git/.gitconfig"        "$HOME/.gitconfig"
link "git/.gitignore_global" "$HOME/.gitignore_global"

# Ghostty
link "ghostty/config" "$HOME/.config/ghostty/config"

# VS Code
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
link "vscode/settings.json" "$VSCODE_DIR/settings.json"

echo ""
echo "==> Done!"
[ -d "$BACKUP_DIR" ] && echo "    Backups saved to $BACKUP_DIR"
echo "    Restart your terminal for shell changes to take effect."
