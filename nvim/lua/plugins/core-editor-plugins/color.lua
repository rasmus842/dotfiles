-- See dotfiles/themes/ for the fragments and the switcher.
local config_home = os.getenv("XDG_CONFIG_HOME") or (os.getenv("HOME") .. "/.config")

local theme_file = config_home .. "/themes/current/nvim.lua"

local ok, theme = pcall(dofile, theme_file)
if not ok then
	vim.notify("Could not load theme " .. theme_file .. ": " .. tostring(theme))
	return {}
end

return theme
