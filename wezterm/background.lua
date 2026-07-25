local wezterm = require("wezterm")

local M = {}

function M.apply_to_config(config)
	wezterm.on("decrease-opacity", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		local current = overrides.window_background_opacity or config.window_background_opacity
		overrides.window_background_opacity = math.max(0.00, current - 0.05)
		window:set_config_overrides(overrides)
	end)

	wezterm.on("increase-opacity", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		local current = overrides.window_background_opacity or config.window_background_opacity
		overrides.window_background_opacity = math.min(current + 0.05, 1.00)
		window:set_config_overrides(overrides)
	end)

	wezterm.on("toggle-window-decoration", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		local current = overrides.window_decorations or config.window_decorations
		if current ~= "RESIZE" then
			overrides.window_decorations = "RESIZE"
		else
			overrides.window_decorations = "TITLE | RESIZE"
		end
		window:set_config_overrides(overrides)
	end)

	config.window_background_opacity = 1.00
	config.macos_window_background_blur = 20
end

M.keys = {
	{ key = "I", mods = "SHIFT|CTRL", action = wezterm.action.EmitEvent("decrease-opacity") },
	{ key = "O", mods = "SHIFT|CTRL", action = wezterm.action.EmitEvent("increase-opacity") },
	{ key = "W", mods = "SHIFT|CTRL", action = wezterm.action.EmitEvent("toggle-window-decoration") },
	{ key = "F", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },
}

return M
