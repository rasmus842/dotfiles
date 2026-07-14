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

		-- Sticky fold level: <leader>z<nr> sets it, <leader>Z resets it.
		-- While set, it is re-applied on BufEnter/FocusGained.
		local fold_level = nil

		local function apply_fold_level()
			if not fold_level then
				return
			end
			-- ufo attaches asynchronously; skip buffers it hasn't processed yet
			vim.schedule(function()
				pcall(function()
					ufo.openFoldsExceptKinds()
					ufo.closeFoldsWith(fold_level)
				end)
			end)
		end

		for level = 0, 9 do
			vim.keymap.set("n", "<leader>z" .. level, function()
				fold_level = level
				vim.notify("Fold level: " .. level)
				apply_fold_level()
			end, { desc = "Set sticky fold level to " .. level })
		end

		vim.keymap.set("n", "<leader>Z", function()
			fold_level = nil
			vim.notify("Fold level: reset")
			ufo.openAllFolds()
		end, { desc = "Reset sticky fold level" })

		vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
			group = vim.api.nvim_create_augroup("UfoStickyFoldLevel", { clear = true }),
			callback = apply_fold_level,
		})

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
