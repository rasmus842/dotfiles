-- Seamless navigation and resizing across neovim splits and tmux panes.
-- The matching tmux bindings live in tmux/tmux.conf (search @pane-is-vim).
return {
	"mrjones2014/smart-splits.nvim",
	-- must load eagerly: tmux reads the @pane-is-vim option this plugin sets
	lazy = false,
	opts = {
		-- pinned rather than auto-detected: tmux's global environment still
		-- carries TERM_PROGRAM=WezTerm from the parent terminal, so detection
		-- can pick the wrong multiplexer when wezterm runs tmux
		multiplexer_integration = "tmux",
		-- only applies while resizing; neo-tree manages its own width
		ignored_filetypes = { "neo-tree" },
		at_edge = "wrap",
	},
	config = function(_, opts)
		local splits = require("smart-splits")
		splits.setup(opts)

		vim.keymap.set("n", "<C-h>", splits.move_cursor_left, { desc = "Go to left split/pane" })
		vim.keymap.set("n", "<C-j>", splits.move_cursor_down, { desc = "Go to split/pane below" })
		vim.keymap.set("n", "<C-k>", splits.move_cursor_up, { desc = "Go to split/pane above" })
		vim.keymap.set("n", "<C-l>", splits.move_cursor_right, { desc = "Go to right split/pane" })

		vim.keymap.set("n", "<A-h>", splits.resize_left, { desc = "Resize split/pane left" })
		vim.keymap.set("n", "<A-j>", splits.resize_down, { desc = "Resize split/pane down" })
		vim.keymap.set("n", "<A-k>", splits.resize_up, { desc = "Resize split/pane up" })
		vim.keymap.set("n", "<A-l>", splits.resize_right, { desc = "Resize split/pane right" })
	end,
}
