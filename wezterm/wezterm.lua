local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.keys = {}
for _, module in ipairs({ "background", "theme" }) do
	local m = require(module)
	m.apply_to_config(config)
	for _, k in ipairs(m.keys or {}) do
		table.insert(config.keys, k)
	end
end

local keys = {
	{ key = "f", mods = "SUPER", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },
}
for _, k in ipairs(keys) do
	table.insert(config.keys, k)
end

config.term = "xterm-256color"
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.initial_rows = 48
config.initial_cols = 200
config.scrollback_lines = 10000

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 13
config.line_height = 1.05

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
