export PATH="$HOME/.asdf/shims:$PATH"
. "$HOME/.asdf/asdf.sh"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# flags necessary for Postgres ICU support
export LDFLAGS="-L/opt/homebrew/opt/icu4c/lib"
export CPPFLAGS="-I/opt/homebrew/opt/icu4c/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c/lib/pkgconfig"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# --- Completions ---
# asdf completions
fpath+=("$HOME/.asdf/completions")

autoload -Uz compinit
compinit

setopt AUTO_MENU AUTO_LIST LIST_AMBIGUOUS COMPLETE_IN_WORD
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*'

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
