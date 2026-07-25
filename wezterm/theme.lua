local wezterm = require("wezterm")

local M = {}

function M.apply_to_config(config)
	-- see dotfiles/themes
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
end

return M
