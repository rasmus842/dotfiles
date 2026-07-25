-- Colorscheme specs kept for reference. Nothing requires this file, so none of
-- these are installed.
--
-- The active colorscheme is chosen by the theme system instead: color.lua reads
-- the spec from themes/current/nvim.lua (see dotfiles/themes/). To promote one
-- of these, create a theme directory for it with matching tmux/zsh/wezterm
-- fragments and move the spec into its nvim.lua.
--
-- gruvbox, tokyonight and catppuccin already live there.

local gruvbox_material = {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_foreground = "original"
		vim.g.gruvbox_material_background = "medium"
		vim.g.gruvbox_material_enable_italic = true
		-- vim.g.gruvbox_material_better_performance = 1
		vim.cmd.colorscheme("gruvbox-material")
	end,
}

local darcula_solid = {
	"briones-gabriel/darcula-solid.nvim",
	dependencies = {
		"rktjmp/lush.nvim",
	},
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("darcula-solid")
	end,
}

local darcula = {
	"doums/darcula",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("darcula")
	end,
}

local gruber_darker = {
	"blazkowolf/gruber-darker.nvim",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("gruber-darker")
	end,
}

local gruber_darker2 = {
	"thimc/gruber-darker.nvim",
	priority = 1000,
	config = function()
		require("gruber-darker").setup({
			transparent = true, -- removes the background
			-- underline = false, -- disables underline fonts
			-- bold = false, -- disables bold fonts
		})
		vim.cmd.colorscheme("gruber-darker")
	end,
}

return {
	gruvbox_material = gruvbox_material,
	darcula_solid = darcula_solid,
	darcula = darcula,
	gruber_darker = gruber_darker,
	gruber_darker2 = gruber_darker2,
}
