-- Copy the current buffer's absolute file path to the system clipboard.
-- Usage: :FilePath
vim.api.nvim_create_user_command("FilePath", function()
	local path = vim.fn.expand("%:p")
	if path == "" then
		print("No file path for the current buffer")
		return
	end
	vim.fn.setreg("+", path)
	print("Copied: " .. path)
end, {})

-- Copy the current buffer's path relative to the working directory.
-- Usage: :RelativePath
vim.api.nvim_create_user_command("RelativePath", function()
	local path = vim.fn.expand("%:.")
	if path == "" then
		print("No file path for the current buffer")
		return
	end
	vim.fn.setreg("+", path)
	print("Copied: " .. path)
end, {})
