local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.term = "xterm-256color"
config.enable_tab_bar = false
config.scrollback_lines = 10000

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 19
config.line_height = 1.1

config.color_scheme = "tokyonight_night"
config.colors = {
	cursor_bg = "#7aa2f7",
	cursor_border = "#7aa2f7",
}

-- config.window_decorations = "RESIZE"

-- On macOS: left Option behaves as terminal Alt
-- right option remains available for composed characters.
-- (these are already WezTerm's macOS defaults; set explicitly because
--  smart-splits.nvim's M-hjkl resize bindings depend on them)
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

config.default_prog = {
	"tmux",
	"new-session",
	"-A",
	"-s",
	"main",
}

return config
