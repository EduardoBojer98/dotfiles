# Zsh config directory
export ZDOTDIR="$HOME/dotfiles/zsh"
export PATH="$HOME/.local/bin:$PATH"

# Plugin directory
ZSH_PLUGIN_DIR="$HOME/.zsh/plugins"

# Ensure plugin directory exists
mkdir -p "$ZSH_PLUGIN_DIR"

# Define plugin sources
declare -A plugins=(
  [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions.git"
  [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
  [pure]="https://github.com/sindresorhus/pure.git"
)

# Clone plugins if not present
for plugin in "${(@k)plugins}"; do
  local dir="$ZSH_PLUGIN_DIR/$plugin"
  if [[ ! -d "$dir" ]]; then
    echo "Installing $plugin..."
    git clone --depth=1 "${plugins[$plugin]}" "$dir"
  fi
done

# Load Pure prompt
fpath+="$ZSH_PLUGIN_DIR/pure"
autoload -U promptinit; promptinit
prompt pure

# Load plugins
source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Shell options
setopt CORRECT
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_GLOB

# Completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Aliases
alias ll='ls -lah'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

# Local overrides
[[ -f "$ZDOTDIR/.zsh_local" ]] && source "$ZDOTDIR/.zsh_local"
