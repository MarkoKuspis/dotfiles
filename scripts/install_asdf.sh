#!/usr/bin/env bash
set -euo pipefail

# Add asdf to zshrc if missing
if ! grep -q 'asdf.sh' ~/.zshrc 2>/dev/null; then
  {
    echo ''
    echo '# asdf'
    echo '. "$HOME/.asdf/asdf.sh"'
  } >> ~/.zshrc
fi

# Source for current shell
. "$HOME/.asdf/asdf.sh"

asdf plugin add awscli || true
asdf plugin add bun || true
asdf plugin add firebase || true
asdf plugin add nodejs || true
asdf plugin add postgres || true
asdf plugin add python || true
asdf plugin add ruby || true
asdf plugin add terraform || true
