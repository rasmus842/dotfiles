local wezterm = require("wezterm")

local M = {}

function M.apply_to_config(config)
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
end

return M
