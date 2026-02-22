export COLORTERM=truecolor
export TERM=${TERM:-xterm-256color}

export PATH="$HOME/.asdf/shims:$PATH"
. "$HOME/.asdf/asdf.sh"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# flags necessary for Postgres ICU support
export LDFLAGS="-L/opt/homebrew/opt/icu4c/lib"
export CPPFLAGS="-I/opt/homebrew/opt/icu4c/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c/lib/pkgconfig"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_REDUCE_BLANKS

# --- Completions ---
# asdf completions
fpath+=("$HOME/.asdf/completions")

autoload -Uz compinit
compinit

setopt AUTO_MENU AUTO_LIST LIST_AMBIGUOUS COMPLETE_IN_WORD
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Aliases
alias ls='ls -G'
alias ll='ls -lh'
alias la='ls -lah'
alias grep='grep --color=auto'

# Enable colors
autoload -U colors && colors

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Path to spaceship config
export SPACESHIP_CONFIG="$HOME/.config/spaceship.zsh"

# Source spaceship prompt
source /opt/homebrew/opt/spaceship/spaceship.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
