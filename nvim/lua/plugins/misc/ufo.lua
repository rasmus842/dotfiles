local ftMap = {
	go = { "indent" },
	python = { "indent" },
	git = "",
}

return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		-- See also core/folds.lua for fold options
		local ufo = require("ufo")

		--[[
		Notes:
		Opening and closing folds should be a toggle
		1) key to toggle either ufo.openAllFolds or ufo.closeAllFolds
			* Probably make a new command for it
			* checks global boolean
			* just a boolean switch, autocmd checks value
		2) toggle fold level up or down
			* foldlevel++ or foldlevel--
		--]]

		vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
		vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open folds of same level" })
		vim.keymap.set("n", "zm", function()
			ufo.closeFoldsWith(1)
		end, { desc = "Close inner folds" }) -- closeAllFolds == closeFoldsWith(0)
		vim.keymap.set("n", "K", function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, { desc = "Peek fold" })

		ufo.setup({
			preview = {
				mappings = {
					scrollU = "<C-U>",
					scrollD = "<C-D>",
				},
			},
			provider_selector = function(bufnr, filetype, buftype)
				return ftMap[filetype] or { "lsp", "indent" }
			end,
		})
	end,
}
