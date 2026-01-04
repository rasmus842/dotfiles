# XDG base
export XDG_CONFIG_HOME="$HOME/.config"

# User bin paths
[[ -d "$HOME/bin" ]] && path=("$HOME/bin" $path)
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

# Tmuxifier path
path=("$XDG_CONFIG_HOME/tmuxifier/bin" $path)

# Added by Toolbox App
path+=("$HOME/.local/share/JetBrains/Toolbox/scripts")

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
path+=("$HOME/.rvm/bin")

# Export PATH from `path` array
export PATH="${(j/:/)path}"

# Intialize tmuxifier
eval "$(tmuxifier init -)"
