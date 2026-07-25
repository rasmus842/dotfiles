# catppuccin-mocha — shell colors
#
# Sourced by .zshrc via themes/current, and re-sourced in place by `theme`.
# Every fragment must set the same variables so switching leaves nothing behind.

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#a6e3a1'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#94e2d5'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#94e2d5'
ZSH_HIGHLIGHT_STYLES[function]='fg=#94e2d5'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=#89b4fa'

export BAT_THEME='Catppuccin Mocha'

# $FZF_EXTRA_OPTS carries non-color fzf options set in .zshrc, so re-sourcing
# this file on a theme switch recolors fzf without dropping them.
export FZF_DEFAULT_OPTS="\
--color=bg:#1e1e2e,bg+:#313244,fg:#cdd6f4,fg+:#cdd6f4 \
--color=hl:#f38ba8,hl+:#f38ba8,info:#cba6f7,border:#6c7086 \
--color=prompt:#cba6f7,pointer:#f5e0dc,marker:#b4befe,spinner:#f5e0dc,header:#6c7086 \
${FZF_EXTRA_OPTS}"
