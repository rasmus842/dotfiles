return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			indent = {
				char = { "│", "┆", "¦", "⎸" },
			},
			whitespace = { highlight = { "Whitespace", "NonText" } },
			exclude = {
				filetypes = {
					"help",
					"startify",
					"dashboard",
					"packer",
					"neogitstatus",
					"NvimTree",
					"Trouble",
				},
			},
			scope = {
				show_start = false,
				show_end = false,
				show_exact_scope = false,
			},
		})
	end,
}
