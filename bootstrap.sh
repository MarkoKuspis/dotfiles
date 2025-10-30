#!/usr/bin/env bash
set -euo pipefail

# ----- Xcode CLT -----
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install || true
  echo "Finish Xcode Command Line Tools install, then re-run bootstrap."
  exit 0
fi

# --- Rosetta for Apple Silicon ---
if [[ "$(uname -m)" == "arm64" ]]; then
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license || true
fi

# --- Homebrew ---
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ "$(uname -m)" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  grep -q '/opt/homebrew/bin/brew shellenv' ~/.zprofile 2>/dev/null || \
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
else
  eval "$(/usr/local/bin/brew shellenv)"
  grep -q '/usr/local/bin/brew shellenv' ~/.zprofile 2>/dev/null || \
    echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
fi

# --- Brewfile ---
brew update
brew bundle --file="$(pwd)/Brewfile"

# ----- Copy/symlink dotfiles -----
echo "Linking dotfiles..."
rsync -avh --no-perms --no-owner --no-group dotfiles/ "${HOME}/"

# Ensure XDG config dirs exist
mkdir -p "${HOME}/.config"

# ----- Install custom font from repo -----
echo "Installing CommitMono Nerd Font..."
cp -f "fonts/CommitMonoNerdFontMono-Regular.otf" "${HOME}/Library/Fonts/"

# ----- asdf -----
bash scripts/install_asdf.sh

# ----- Neovim Kickstart fork -----
NVIM_DIR="${HOME}/.config/nvim"
if [[ ! -d "$NVIM_DIR/.git" && ! -d "$NVIM_DIR/lua" ]]; then
  # set your fork URL here:
  KICKSTART_FORK_URL="https://github.com/MarkoKuspis/kickstart.nvim"
  git clone "$KICKSTART_FORK_URL" "$NVIM_DIR"
fi

# Headless plugin sync (Lazy)
if command -v nvim >/dev/null 2>&1; then
  nvim --headless "+Lazy! sync" +qa || true
fi
