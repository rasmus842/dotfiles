-- Sync clipboard between OS and Neovim
vim.opt.clipboard = "unnamedplus"

if os.getenv("WAYLAND_DISPLAY") then
	vim.g.clipboard = {
		name = "wl-clipboard",
		copy = {
			["+"] = "wl-copy --type=clipboard",
			["*"] = "wl-copy --type=primary",
		},
		paste = {
			["+"] = "wl-paste --no-newline",
			["*"] = "wl-paste --no-newline --primary",
		},
		cache_enabled = false,
	}
end
