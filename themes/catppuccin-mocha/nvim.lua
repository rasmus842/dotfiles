-- catppuccin-mocha — neovim colorscheme
--
-- dofile'd by plugins/core-editor-plugins/color.lua via themes/current, and
-- returned straight to lazy.nvim as a plugin spec. Only the active theme's
-- plugin is ever installed; lazy fetches it on the first start after a switch.
return {
	"catppuccin/nvim",
	name = "catppuccin", -- repo dir is "nvim", which would collide with lazy's own paths
	priority = 1000, -- load before any other start plugin
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
