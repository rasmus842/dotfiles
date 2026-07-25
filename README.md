## Setup:

1. Add following to ~/.bashrc:
   `    alias vim='nvim'
alias tmuxifier='tmx'
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$XDG_CONFIG_HOME/tmuxifier"`

- also check $TERM environment variable (should be `xterm-color256` ?)

## Nerd fonts:

1. Download an archive for example https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
2. extract and place into `~/.local/share/fonts/` directory
3. Select `JetBrainsMono Nerd Font` in system
   - gnome tweaks -> Fonts -> Mono ..
   - Settings -> Fonts -> Mono ..

## Starship:

1. Install: `curl -sS https://starship.rs/install.sh`
2. Add to .bashrc: `eval (starship init bash)`
3. see [starship.rs](https://starship.rs) for help on configs and available presets

## Z-shell (zsh):

1. Install:
   - Debian: `sudo apt install zsh zsh-syntax-highlighting`
   - macOS: `brew install zsh zsh-syntax-highlighting zsh-completions`
2. Verify:
   - `which zsh`
   - `zsh --version` should output 5.9 or higher
3. Set as default shell: `chsh -s $(which zsh)`
4. Wire up the configs. `~/.zshrc` and `~/.zprofile` stay in `$HOME` as thin,
   machine-local shims that source the portable config from this repo. Keep
   machine-specific things (tokens, work paths) in the shim, not in the repo.

   `~/.zprofile`:

   ```zsh
   source "$HOME/dotfiles/zsh/.zprofile"
   # machine-specific PATH below, e.g.
   # [[ -d "$HOME/work/bin" ]] && path=("$HOME/work/bin" $path)
   ```

   `~/.zshrc`:

   ```zsh
   source "$HOME/dotfiles/zsh/.zshrc"
   # machine-specific env below
   ```

   Use the literal `$HOME/dotfiles/...` path, not `$dotfiles` — `~/.zshrc` runs
   in non-login shells where `.zprofile` never ran. Put any `bindkey` or ZLE
   widget additions _before_ the `source` line so zsh-syntax-highlighting still
   initializes last.

   Deliberately **not** using `ZDOTDIR`: it would relocate `.zcompdump`,
   `.zcompcache` and Terminal.app's `.zsh_sessions` into this repo, and would
   silently neuter installers that append to `~/.zshrc`.

5. Load changes, either restart or `exec zsh -l`
6. Make checks:
   - starship: currently commented out in `zsh/.zshrc`; re-enable once `which starship` resolves
   - `echo $options[login]` -> prints 'on' if login shell (login shell sources ~/.zprofile and then ~/.zshrc)
   - `echo $ZSH_VERSION`
   - `echo $0` -> `zsh`
   - `echo $TERM` -> `xterm-256color`
   - `echo $PATH` or `echo $path`, `which nvim`, `which starship`, etc
   - ```

     ```

7. Some gotchas:
   - terminal emulator commonly starts non-login shell (ignores `~/.zprofile` and reads `~/.zshrc`)
   - SSH commonly starts login shell (reads `~/.zprofile` and then `~/.zshrx`)

## Alacritty

1. Install: `sudo apt install alacritty`
2. Verify: `which alacritty` and `alacritty --version`
3. Config file `alacritty/alacritty.toml`

## Tmux and tmuxifier:

1. sudo apt install tmux
2. clone tmux config to `~/.config/tmux`
3. add tpm to `~/.tmux` directory
   - `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
4. tmuxifier
   - `git clone https://github.com/jimeh/tmuxifier.git $XDG_CONFIG_HOME/tmuxifier`
   - Add to ~/.profile, ~/.bash_profile or equivalent: `eval "$(tmuxifier init -)"`

## Installing neovim:

see https://github.com/neovim/neovim and https://github.com/neovim/neovim/blob/master/BUILD.md

1. Install [build prerequisites](#build-prerequisites) on your system
   - sudo apt-get install ninja-build gettext cmake curl build-essential
2. `git clone https://github.com/neovim/neovim`
3. `cd neovim`
   - If you want the **stable release**, also run `git checkout stable`.
4. `make CMAKE_BUILD_TYPE=RelWithDebInfo`
   - If you want to install to a custom location, set `CMAKE_INSTALL_PREFIX`. See also [INSTALL.md](./INSTALL.md#install-from-source).
   - On BSD, use `gmake` instead of `make`.
   - To build on Windows, see the [Building on Windows](#building-on-windows) section. _MSVC (Visual Studio) is recommended._
5. `sudo make install`
   - Default install location is `/usr/local`
   - On Debian/Ubuntu, instead of `sudo make install`, you can try `cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb` to build DEB-package and install it. This helps ensure clean removal of installed files. Note: This is an unsupported, "best-effort" feature of the Nvim build.

## Using neovim:

1. elixir development:
   - install elixir and erlang using asdf
   - install elixir-ls

2. emmet-language-server
   - need npm installed for mason to automatically fetch it

3. For java development:
   - Inside neovim install jdtls using Mason: `:MasonInstall jdtls`

## Color themes:

One command recolors the whole stack:

```
theme                    # show the active theme and what else is available
theme catppuccin-mocha   # switch
```

Each theme is a directory of fragments under `themes/`, one file per tool,
written in that tool's own config language — no templating, no build step:

```
themes/
  current -> tokyonight-night   # git-tracked symlink: the active theme
  tokyonight-night/
    tmux.conf      wezterm.lua
    zsh.zsh        nvim.lua
  gruvbox-dark/
  catppuccin-mocha/
```

## After:

1. clone repo to `~/dotfiles`, then symlink into `~/.config` (starship, nvim, tmux, alacritty, themes).
   zsh is the exception: it is sourced from the repo by the `~/.zshrc` / `~/.zprofile` shims above.

   ```
   ln -s ~/dotfiles/themes ~/.config/themes
   ```

2. Run neovim to install plugins via Lazy
   - also download and setup required lsp-s
3. run tmux and press <prefix>-I to install tmux plugins
4. Create preconfigured tmux sessions with tmuxifier
