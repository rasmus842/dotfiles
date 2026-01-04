## Setup:

1. Add following to ~/.bashrc:
`
    alias vim='nvim'
    alias tmuxifier='tmx'
    . "$HOME/.asdf/asdf.sh"
    . "$HOME/.asdf/completions/asdf.bash"
    export XDG_CONFIG_HOME="$HOME/.config"
    export PATH="$XDG_CONFIG_HOME/tmuxifier"
`
- also check $TERM environment variable (should be `xterm-color256` ?)


## Nerd fonts:

1. Download an archive for example https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
2. extract and place into `~/.local/share/fonts/` directory
3. Select `JetBrainsMono Nerd Font` in system
    - gnome tweaks -> Fonts -> Mono ..
    - Settings -> Fonts -> Mono ..


## Starship:

1. Install: ```curl -sS https://starship.rs/install.sh```
2. Add to .bashrc: ```eval (starship init bash)```
3. see [starship.rs](https://starship.rs) for help on configs and available presets


## Z-shell (zsh):

1. Install: ```sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting```
2. Verify:
    - ```which zsh```
    - ```zsh --version``` should output 5.9 or higher
3. Set as default shell: ```chsh -s $(which zsh)```
4. Make zsh reference `~/.config/zsh` -> ```echo 'export ZDOTDIR="$HOME/.config/zsh"' > ~/.zshenv```
6. Load changes, either restart or ```exec zsh -l```
7. Make checks:
    - is starship prompt working as expected? ```which starship```
    - ```echo $options[login]``` -> prints 'on' if login shell (login shell sources ~/.zprofile and then ~/.zshrc)
    - ```echo $ZSH_VERSION```
    - ```echo $0``` -> `zsh`
    - ```echo $PATH``` or ```echo $path```, ```which nvim```, ```which starship```, etc
    - ``````
8. Some gotchas:
    - terminal emulator commonly starts non-login shell (ignores `~/.zprofile` and reads `~/.zshrc`)
    - SSH commonly starts login shell (reads `~/.zprofile` and then `~/.zshrx`)

## Alacritty

1. Install: ```sudo apt install alacritty```
2. Verify: ```which alacritty``` and ```alacritty --version```
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


## After:

1. clone repo to import configs to `~/.config` (starship, zsh, alacritty, tmux configs)
2. Run neovim to install plugins via Lazy
    - also download and setup required lsp-s
3. run tmux and press <prefix>-I to install tmux plugins
4. Create preconfigured tmux sessions with tmuxifier

