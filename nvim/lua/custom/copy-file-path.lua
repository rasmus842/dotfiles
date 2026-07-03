-- Copy the current buffer's absolute file path to the system clipboard.
-- Usage: :CopyFilePath
vim.api.nvim_create_user_command("CopyFilePath", function()
	local path = vim.fn.expand("%:p")
	if path == "" then
		print("No file path for the current buffer")
		return
	end
	vim.fn.setreg("+", path)
	print("Copied: " .. path)
end, {})
