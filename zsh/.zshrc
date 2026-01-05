HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=20000

setopt HIST_IGNORE_DUPS        # don't record dupes
setopt HIST_IGNORE_SPACE       # ignore commands starting with space
setopt HIST_VERIFY             # show expansion before running it
setopt SHARE_HISTORY           # share across terminals
setopt INC_APPEND_HISTORY      # append as commands are run

# --- Useful interactive options ---
setopt AUTO_CD                 # cd by typing directory name
setopt CORRECT                 # command correction (optional; comment if annoying)
setopt INTERACTIVE_COMMENTS    # allow comments in interactive shell

# --- Completion ---
autoload -Uz compinit
# If you ever get "insecure directories" warnings, run:
#   compaudit | xargs chmod g-w,o-w
compinit

# Optional: menu selection
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

zmodload zsh/complist
bindkey -M menuselect '^I'  forward-char           # Tab
bindkey -M menuselect '^[[Z' reverse-menu-complete  # Shift+Tab

# Alacritty / tmux: nice terminal title
case "$TERM" in
  xterm*|rxvt*|alacritty*)
    precmd () { print -Pn "\e]0;%n@%m: %~\a"}
esac

# --- Colors / ls ---
autoload -Uz colors && colors
# Debian usually has dircolors available; this sets LS_COLORS for GNU ls
if command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi
alias ls='ls --color=auto'


alias vim='nvim'
alias tmx='tmuxifier'
export EDITOR='nvim'

# --- asdf (zsh version) ---
# Prefer asdf's zsh completion if present
if [[ -s "$HOME/.asdf/asdf.sh" ]]; then
  . "$HOME/.asdf/asdf.sh"
fi
# Newer asdf has zsh completions here:
if [[ -s "$HOME/.asdf/completions/asdf.zsh" ]]; then
  fpath=("$HOME/.asdf/completions" $fpath)
fi

# --- SDKMAN (works fine in zsh) ---
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# --- NVM (zsh) ---
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# --- RVM (if you actually use it interactively) ---
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# zsh autosuggestions
if [[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Accept just one word with Ctrl+Right
bindkey '^[OC' autosuggest-accept-word
bindkey '^[OF' autosuggest-accept-word  # fallback for some terms

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#98971a'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#689d6a'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#689d6a'
ZSH_HIGHLIGHT_STYLES[function]='fg=#689d6a'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#cc241d,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=#458588'

# zsh syntax highlighting (must be near end)
if [[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# --- Prompt: starship (zsh) ---
# Put this near the end so it sees env vars/paths
eval "$(starship init zsh)"

