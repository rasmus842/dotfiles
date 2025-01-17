## Setup:

1. Add following to ~/.bashrc:
    - `alias vim='nvim'`
    - `. "$HOME/.asdf/asdf.sh"`
    - `. "$HOME/.asdf/completions/asdf.bash"`
    - `export XDG_CONFIG_HOME="$HOME/.config"`
    - `export PATH="$XDG_CONFIG_HOME/tmuxifier"`
    - also check $TERM environment variable (should be `xterm-color256` ?)

## Nerd fonts:

1. Download an archive for example https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
2. extract and place into `~/.local/share/fonts/` directory

## tmux:

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

## Customizing terminal
1. install starship `curl -sS https://starship.rs/install.sh`
2. Add to .bashrc: `eval "$(starship init bash)"`
3. see [starship.rs](https://starship.rs) for help on configs and available presets 

## After:

1. clone nvim, tmux, tmuxifier config from github
2. Run neovim to install plugins via Lazy
    - also download and setup required lsp-s
3. run tmux and press <prefix>-I to install tmux plugins
4. Create preconfigured tmux sessions with tmuxifier

