return {
	-- High-performance color highlighter
	"norcalli/nvim-colorizer.lua",
	onfig = function()
		require("colorizer").setup()
	end,
}
