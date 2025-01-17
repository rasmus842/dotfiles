local tokyonight = {
	"folke/tokyonight.nvim",
	priority = 1000, -- Make sure to load this before all the other start plugins.
	config = function()
		require("tokyonight").setup({
			style = "night", -- night, storm, moon
		})
		vim.cmd.colorscheme("tokyonight-night")
	end,
}

local catppuccin = {
	"catppuccin/nvim",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
		})
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
	config = function()
		-- require("lush")
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
			-- OPTIONAL
			transparent = true, -- removes the background
			-- underline = false, -- disables underline fonts
			-- bold = false, -- disables bold fonts
		})
		vim.cmd.colorscheme("gruber-darker")
	end,
}
-- Change the name of the colorscheme plugin below, and then
-- change the command in the config to whatever the name of that colorscheme is.
--
-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
return tokyonight
