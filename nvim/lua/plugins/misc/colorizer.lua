return {
	-- High-performance color highlighter
	"norcalli/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			"*",
		}, {
			mode = "background",
		})
	end,
}
