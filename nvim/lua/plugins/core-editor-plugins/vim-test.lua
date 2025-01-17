return {
	"vim-test/vim-test",
	dependencies = {
		"preservim/vimux",
	},
	config = function()
		-- Configure keybindings to run tests
		vim.keymap.set("n", "<leader>t", ":TestNearest<CR>")
		vim.keymap.set("n", "<leader>T", ":TestFile<CR>")
		vim.keymap.set("n", "<leader>a", ":TestSuite<CR>")
		vim.keymap.set("n", "<leader>l", ":TestLast<CR>")
		vim.keymap.set("n", "<leader>g", ":TestVisit<CR>")

		-- configure vim test to pipe tests into tmux pane through vimux
		vim.cmd("let test#strategy = 'vimux'")
	end,
}
