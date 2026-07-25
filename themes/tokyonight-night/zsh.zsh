# tokyonight-night — shell colors
#
# Sourced by .zshrc via themes/current, and re-sourced in place by `theme`.
# Every fragment must set the same variables so switching leaves nothing behind.

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#7dcfff'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7dcfff'
ZSH_HIGHLIGHT_STYLES[function]='fg=#7dcfff'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=#7aa2f7'

# bat has no bundled tokyonight theme; Coldark-Dark is the closest blue-dark
# built-in. For the real thing, drop tokyonight.tmTheme into bat's themes dir
# and run `bat cache --build`.
export BAT_THEME='Coldark-Dark'

# $FZF_EXTRA_OPTS carries non-color fzf options set in .zshrc, so re-sourcing
# this file on a theme switch recolors fzf without dropping them.
export FZF_DEFAULT_OPTS="\
--color=bg:#1a1b26,bg+:#292e42,fg:#c0caf5,fg+:#c0caf5 \
--color=hl:#7aa2f7,hl+:#7aa2f7,info:#9d7cd8,border:#565f89 \
--color=prompt:#7dcfff,pointer:#f7768e,marker:#9ece6a,spinner:#b4f9f8,header:#565f89 \
${FZF_EXTRA_OPTS}"
