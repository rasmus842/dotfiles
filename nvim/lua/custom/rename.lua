local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

function RenameSymbol(old_name, new_name)
	-- Search for all occurrences of old_name
	-- git aware
	local cmd = "git ls-files | xargs rg --files-with-matches --no-heading --color=never --fixed-strings '"
		.. old_name
		.. "' | xargs sed -i 's/"
		.. old_name
		.. "/"
		.. new_name
		.. "/g'"

	-- Execute rename command
	vim.fn.system(cmd)

	-- Refresh buffers to show changes
	vim.cmd("e!")
	print("Renamed '" .. old_name .. "' to '" .. new_name .. "' across the project.")
end

-- Create a Neovim command
vim.api.nvim_create_user_command("RenameSymbol", function(opts)
	local old_name = opts.fargs[1]
	local new_name = opts.fargs[2]
	if not old_name or not new_name then
		print("Usage: :RenameSymbol <old_name> <new_name>")
		return
	end
	RenameSymbol(old_name, new_name)
end, { nargs = "*" })

function RenameSymbolTelescope()
	require("telescope.builtin").grep_string({
		prompt_title = "Rename Symbol",
		search = vim.fn.expand("<cword>"), -- Auto-selects current word
		attach_mappings = function(_, map)
			map("i", "<CR>", function(prompt_bufnr)
				local old_name = action_state.get_current_line()
				actions.close(prompt_bufnr)
				local new_name = vim.fn.input("Rename " .. old_name .. " to: ")
				if new_name and new_name ~= "" then
					RenameSymbol(old_name, new_name)
				end
			end)
			return true
		end,
	})
end

vim.api.nvim_create_user_command("RenameSymbolTelescope", function(opts)
	RenameSymbolTelescope()
end, {})

vim.api.nvim_set_keymap("n", "<leader>R", ":lua RenameSymbolTelescope()<CR>", { noremap = true, silent = true })
