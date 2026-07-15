vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldcolumn = "1"
vim.keymap.set("n", "<CR>", "za", { desc = "Toggle fold", noremap = true, silent = true })

vim.opt.fillchars = {
	fold = " ",
	foldopen = "▾",
	foldclose = "▸",
	foldinner = " ",
	foldsep = " ",
}

-- Folding imports (does not seem to work):
--[[
vim.api.nvim_create_autocmd("LspNotify", {
	callback = function(ev)
		if ev.data.method == "textDocument/didOpen" then
			vim.lsp.foldclose("imports", vim.fn.bufwinid(ev.buf))
		end
	end,
})
--]]

-- No plugin folds:
--[[
No need for plugins. Folding (particularly the display) was improved in 0.11 or so. Folding is just a matter of setting the relevant options.

vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.foldnestmax = 15
vim.o.foldtext = ""
vim.o.foldcolumn = "1"
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
Related fillchars are:

"fold: ,foldopen:-,foldsep:│,foldclose:+,foldinner:│"

This gives me VSCode-like folding display, with a single column showing expand (+) and collapse (-) markers and a vertical line to outline foldable regions.

Note that the foldsep and foldinner are Unicode symbols (0x2502) which usually result in vertical lines without gaps (as opposed to the pipe character |, which normally does not).

For persistent folds use `mkview` (on BufWinLeave) and `loadview` (on BufWinEnter) to save and restore folding states.
--]]

-- Persistent folds:
--[[
Use views. Set viewoptions to include "folds" and then use mkview (on BufWinLeave) and loadview (on BufWinEnter) to create and restore views
:h views
:h viewoptions
--]]

-- Automatically fold imports when opening a file:
--[[
vim.api.nvim_create_autocmd("LspNotify", {
	callback = function(ev)
		if ev.data.method == 'textDocument/didOpen' then
			vim.lsp.foldclose('imports', vim.fn.bufwinid(ev.buf))
		end
	end,
}
--]]

-- Set foldexpr based on filetype
--[[
vim.o.foldmethod = 'expr'

-- Default to treesitter:
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/foldingRange') then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
			-- vim.wo[win][0].foldtext = "v:lua.vim.lsp.foldtext()"
		end
	end,
})

--]]

-- Same but different:
--[[
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_config", { clear = true }),
	desc = "Setup on LspAttach",
	callback = function(ev)
		if client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldmethod = "expr"
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
			-- vim.wo[win][0].foldtext = "v:lua.vim.lsp.foldtext()"
		end
	end,
})
--]]
