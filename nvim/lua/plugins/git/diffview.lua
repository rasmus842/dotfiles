return {
	"sindrets/diffview.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.opt.fillchars:append({
			diff = "╱",
		})
	end,
	config = function()
		require("diffview").setup({
			use_icons = true,
			enhanced_diff_hl = true,
			view = {
				default = {
					layout = "diff2_horizontal",
				},
				merge_tool = {
					layout = "diff3_horizontal",
				},
				file_history = {
					layout = "diff2_horizontal",
				},
			},
			file_panel = {
				listing_style = "tree",
				win_config = {
					position = "left",
					width = 35,
				},
			},
		})
	end,
}
