-- Sync clipboard between OS and Neovim
vim.opt.clipboard = 'unnamedplus'

if vim.fn.has("wayland") == 1 then
    vim.g.clipboard = {
        name = "wl-clipboard",
        copy = {
            ["+"] = "wl-copy --type=clipboard",
            ["*"] = "wl-copy --type=primary",
        },
        paste = {
            ["+"] = "wl-paste --no-newline",
            ["*"] = "wl-paste --no-neline --primary",
        },
        cache_enabled = false
    }
end
