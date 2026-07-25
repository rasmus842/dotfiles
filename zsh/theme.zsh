# Color theme switcher for the wezterm -> tmux -> zsh/starship -> nvim stack.
#
# Each theme is a directory of fragments in one file per tool, written in that
# tool's own config language. `themes/current` is a git-tracked symlink to the
# active one, and every tool reads its colors through that symlink — so no
# consumer ever resolves a theme name or needs a fallback, and a fresh clone
# comes up in the committed theme with no setup.
#
# Starship is the exception: it has no include mechanism, so all palettes live
# in starship.toml and only the `palette` key gets rewritten.

CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
THEMES_DIR="$CONF_DIR/themes"

theme() {
  local dir="$THEMES_DIR"

  if [[ ! -d "$dir" ]]; then
    print -u2 "theme: $dir not found — symlink it to \$HOME/dotfiles/themes"
    return 1
  fi

  # No argument: report the active theme and what else is available.
  if (( $# == 0 )); then
    local current="${dir}/current"
    print -r -- "current: ${current:A:t}"
    print -r -- "available:"
    local t
    for t in "$dir"/*(/N:t); do
      print -r -- "  $t"
    done
    return 0
  fi

  local name="$1"
  if [[ ! -d "$dir/$name" ]]; then
    print -u2 "theme: unknown theme '$name' (run \`theme\` to list)"
    return 1
  fi

  # Relative target keeps the symlink valid wherever the repo is checked out.
  ln -sfn "$name" "$dir/current" || return 1

  # Starship reads its config afresh on every prompt, so rewriting the palette
  # key is enough — no reload. Resolve the symlink first: an in-place sed would
  # replace ~/.config/starship.toml with a regular file and break the link.
  local starship_cfg="${STARSHIP_CONFIG:-${CONF_DIR}/starship.toml}"
  starship_cfg="${starship_cfg:A}"
  if [[ -w "$starship_cfg" ]]; then
    if grep -q "^\[palettes\.${name}\]" "$starship_cfg"; then
      local tmp="${TMPDIR:-/tmp}/starship-theme.$$.toml"
      if sed "s/^palette = .*/palette = '${name}'/" "$starship_cfg" > "$tmp"; then
        cat "$tmp" > "$starship_cfg"   # truncate in place, so the symlink survives
      fi
      rm -f "$tmp"
    else
      print -u2 "theme: starship.toml has no [palettes.${name}] — prompt colors unchanged"
    fi
  fi

  # tmux applies this to every pane in every session immediately.
  if command -v tmux >/dev/null 2>&1 && tmux info &>/dev/null; then
    tmux source-file "$dir/current/tmux.conf"
  fi

  # zsh applies theme in precmd, see below

  # WezTerm watches only its main config file, not the files that config
  # dofile's — so bump its mtime to force a re-read. CTRL+SHIFT+R if it misses.
  [[ -e "$CONF_DIR/wezterm/wezterm.lua" ]] && touch "$CONF_DIR/wezterm/wezterm.lua"
}

_theme() {
  local -a themes
  themes=("${THEMES_DIR}"/*(/N:t))
  _describe 'theme' themes
}

# compdef only exists once compinit has run, which .zshrc does well before this.
(( $+functions[compdef] )) && compdef _theme theme

# Re-source shell colors when `theme`, possibly in another pane,
# moves the symlink
typeset -g _THEME_APPLIED=""

_theme_precmd() {
  local link="${THEMES_DIR}/current"
  local active="${link:A}"
  [[ "$active" == "${_THEME_APPLIED}" ]] && return
  _THEME_APPLIED="$active"
  source "$active/zsh.zsh"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _theme_precmd

