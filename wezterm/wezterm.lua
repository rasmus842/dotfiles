local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.term = "xterm-256color"
config.enable_tab_bar = false
config.scrollback_lines = 10000

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 19
config.line_height = 1.1

-- Colors come from the active theme (see dotfiles/themes/), so `theme <name>`
-- recolors this alongside tmux, zsh, starship and neovim. WezTerm watches only
-- the config file it loaded and not the files that file pulls in, so `theme`
-- bumps this file's mtime to force the reload; CTRL+SHIFT+R if it ever misses.
local config_home = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")

local theme_file = config_home .. "/themes/current/wezterm.lua"

local ok, theme = pcall(dofile, theme_file)
if ok then
	for key, value in pairs(theme) do
		config[key] = value
	end
else
	wezterm.log_error("Could not load theme " .. theme_file .. ": " .. tostring(theme))
end

-- config.window_decorations = "RESIZE"

-- On macOS: left Option behaves as terminal Alt
-- right option remains available for composed characters.
-- (these are already WezTerm's macOS defaults; set explicitly because
--  smart-splits.nvim's M-hjkl resize bindings depend on them)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

-- Go through a login shell so PATH comes from the zsh profile: WezTerm
-- launched from Finder/Dock inherits launchd's minimal PATH, which does not
-- include Homebrew, so spawning tmux directly fails to resolve the binary.
config.default_prog = {
	"/bin/zsh",
	"-l",
	"-c",
	"exec tmux new-session -A -s main",
}

return config
