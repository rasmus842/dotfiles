-- tokyonight-night — neovim colorscheme
--
-- dofile'd by plugins/core-editor-plugins/color.lua via themes/current, and
-- returned straight to lazy.nvim as a plugin spec. Only the active theme's
-- plugin is ever installed; lazy fetches it on the first start after a switch.
return {
	"folke/tokyonight.nvim",
	priority = 1000, -- load before any other start plugin
	config = function()
		require("tokyonight").setup({
			style = "night", -- night, storm, moon
			transparent = true,
		})
		vim.cmd.colorscheme("tokyonight-night")
	end,
}
