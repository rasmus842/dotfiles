# gruvbox-dark — shell colors
#
# Sourced by .zshrc via themes/current, and re-sourced in place by `theme`.
# Every fragment must set the same variables so switching leaves nothing behind.

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#98971a'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#689d6a'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#689d6a'
ZSH_HIGHLIGHT_STYLES[function]='fg=#689d6a'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#cc241d,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=#458588'

export BAT_THEME='gruvbox-dark'

# $FZF_EXTRA_OPTS carries non-color fzf options set in .zshrc, so re-sourcing
# this file on a theme switch recolors fzf without dropping them.
export FZF_DEFAULT_OPTS="\
--color=bg:#282828,bg+:#3c3836,fg:#ebdbb2,fg+:#fbf1c7 \
--color=hl:#83a598,hl+:#83a598,info:#d79921,border:#665c54 \
--color=prompt:#d79921,pointer:#cc241d,marker:#98971a,spinner:#689d6a,header:#928374 \
${FZF_EXTRA_OPTS}"
