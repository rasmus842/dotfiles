return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	config = function()
		-- Configure keybindings to run tests
		vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
		vim.keymap.set("n", "<leader>T", ":TestFile<CR>")
		vim.keymap.set("n", "<leader>ta", ":TestSuite<CR>")
		vim.keymap.set("n", "<leader>tl", ":TestLast<CR>")
		vim.keymap.set("n", "<leader>tg", ":TestVisit<CR>")

		-- configure vim test to pipe tests into tmux pane through vimux
		vim.cmd("let test#strategy = 'vimux'")

		-- custom runner for Nx monorepos with a mocha-wrapping test executor
		-- (see ~/.config/nvim/autoload/test/javascript/nxmocha.vim)
		vim.g["test#custom_runners"] = { JavaScript = { "Nxmocha" } }
	end,
}
