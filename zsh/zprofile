typeset -U path PATH fpath FPATH

# XDG base
export XDG_CONFIG_HOME="$HOME/.config"

# Homebrew (macOS ARM, macOS Intel, Linuxbrew)
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [[ -x "$brew_bin" ]]; then
    eval "$("$brew_bin" shellenv zsh)"
    break
  fi
done
unset brew_bin

# User bin paths — after brew so these take precedence
[[ -d "$HOME/bin" ]] && path=("$HOME/bin" $path)
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
[[ -d "$HOME/.bun/bin" ]] && path=("$HOME/.bun/bin" $path)

# asdf: shims must precede system tools (asdf >= 0.16 has no asdf.sh to source)
asdf_shims="${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
[[ -d "$asdf_shims" ]] && path=("$asdf_shims" $path)
unset asdf_shims

# JetBrains Toolbox
for jb in "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" \
          "$HOME/.local/share/JetBrains/Toolbox/scripts"; do
  [[ -d "$jb" ]] && path+=("$jb")
done
unset jb

# Export PATH from `path` array
export PATH="${(j/:/)path}"

