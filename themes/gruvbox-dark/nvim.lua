-- gruvbox-dark — neovim colorscheme
--
-- dofile'd by plugins/core-editor-plugins/color.lua via themes/current, and
-- returned straight to lazy.nvim as a plugin spec. Only the active theme's
-- plugin is ever installed; lazy fetches it on the first start after a switch.
return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000, -- load before any other start plugin
	config = function()
		local p = require("gruvbox").palette
		local is_strings_italic = false
		require("gruvbox").setup({
			terminal_colors = true,
			contrast = "", -- "hard", "soft" or empty string
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = is_strings_italic,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			dim_inactive = false,
			transparent_mode = true,
			palette_overrides = {},
			overrides = {
				String = { fg = p.bright_yellow, italic = is_strings_italic },
				SignColumn = { bg = "NONE" },
				NormalFloat = { bg = p.dark1 },
			},
		})
		vim.cmd.colorscheme("gruvbox")
	end,
}
