# Interactive shells. PATH and login-time env live in .zprofile.
typeset -U path PATH fpath FPATH   # idempotent: keeps nested shells from duplicating PATH entries

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=200000

setopt SHARE_HISTORY           # share across terminals (implies INC_APPEND_HISTORY)
setopt HIST_VERIFY             # show expansion before running it

# --- Useful interactive options ---
setopt AUTO_CD                 # cd by typing directory name
setopt INTERACTIVE_COMMENTS    # allow comments in interactive shell

# --- Keybinds: emacs, as used by most other terminals ---
bindkey -e
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-word
bindkey '^B' backward-word
bindkey '^W' backward-kill-word
bindkey '^O' kill-line
bindkey '^U' backward-kill-line

# Treat path segments as separate words
autoload -Uz select-word-style
select-word-style bash

# --- Completion ---
# brew's zsh-completions must join fpath before compinit
if [[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/share/zsh-completions" ]]; then
  fpath=("$HOMEBREW_PREFIX/share/zsh-completions" $fpath)
fi

autoload -Uz compinit
# If you ever get "insecure directories" warnings, run:
#   compaudit | xargs chmod g-w,o-w
compinit

# Optional: menu selection
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

zmodload zsh/complist
bindkey -M menuselect '^I'  forward-char            # Tab
bindkey -M menuselect '^[[Z' reverse-menu-complete  # Shift+Tab

if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
  export FZF_DEFAULT_COMMAND='rg --files'
  # export FZF_EXTRA_OPTS='--height 40% --layout=reverse'
  # check fzf --man or junegunn.github.io/fzf
fi

# --- Editor / pager ---
alias vim='nvim'
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='bat' # maybe delta instead?
export MANPAGER='nvim +Man!'
# export GIT_PAGER='delta'

# --- Colors / ls ---
autoload -Uz colors && colors

case "$OSTYPE" in
  darwin*)
    export CLICOLOR=1
    export LSCOLORS='ExGxFxdaCxDaDahbadeche' # gruvbox-like
    alias la='ls -lahGo'
    alias ll='ls -lahG'
    ;;
  linux*)
    # dircolors sets LS_COLORS for GNU ls
    command -v dircolors >/dev/null 2>&1 && eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias la='ls -lahgo --color=auto'
    alias ll='ls -lah --color=auto'
    ;;
esac

# --- Terminal title ---
case "$TERM" in
  xterm*|rxvt*|alacritty*|wezterm*|tmux*|screen*)
    precmd() { print -Pn "\e]0;%n@%m: %~\a" }
    ;;
esac

# --- Color theme ---
# Shell colors (syntax highlighting, fzf, bat) for the active theme.
# Must come before zsh-syntax-highlighting is sourced, as the styles did.
source "${XDG_CONFIG_HOME:-$HOME/.config}/themes/current/zsh.zsh"

# --- Syntax highlighting (must be near end) ---
for zsh_hl in "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
              /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; do
  if [[ -r "$zsh_hl" ]]; then
    source "$zsh_hl"
    break
  fi
done
unset zsh_hl

eval "$(starship init zsh)"
