vim.g.have_nerd_font = false -- Set to true if NerdFont installed

-- Line numbers
vim.opt.number = true -- Mark line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight cursor's line number
vim.opt.numberwidth = 4 -- Set number column width
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default (default: 'auto')

-- Line wrapping and spacing
vim.opt.wrap = false -- Diplay lines as one long line
vim.opt.linebreak = true -- Companion to wrap, don't split words
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 10 -- Minimal nubmer of screen columns either side of cursor if wrap is false
-- vim.opt.whichwrap = 'bs' -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
-- vim.opt.backspace = 'indent,eol,start' -- Allow backspace on (default: 'indent,eol,start')

-- Indentation and tabs
vim.opt.autoindent = true -- Copy indent from current line when starting new one
vim.opt.breakindent = true -- Enable break indent
vim.opt.smartindent = true -- Make indenting smarter (default: false)
vim.opt.shiftwidth = 4 -- Nr of spaces inserted for each indentation
vim.opt.tabstop = 4 -- Insert n spaces for a tab
vim.opt.softtabstop = 4 -- Nr of spaces that a tab counts for while performing editing operations
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.showtabline = 2 -- Always show tabs (default: 1)

-- Splitting
vim.opt.mouse = "a" -- Enable mouse mode. Can use mouse to resize splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Searching
vim.opt.hlsearch = true -- Set highlight on search
vim.opt.ignorecase = true -- Case insensitive serach UNLESS \C or capital letters in search string
vim.opt.smartcase = true

vim.opt.termguicolors = true -- Set termguicolors to enable highlight groups

vim.opt.pumheight = 10 -- Pop-up menu height (default: 0)

vim.opt.conceallevel = 0 -- So that `` is visible in markdown files (default: !)

vim.opt.showmode = false -- Unnecessary to show mode

vim.opt.undofile = true -- Save undo history (default: false)
vim.opt.swapfile = true -- Create swapfile (default: true)
vim.opt.backup = false -- Creates backup file (defualt: false)
vim.opt.writebackup = false -- Can files be concurrently edited by different program (default: true)

vim.opt.fileencoding = "utf-8" -- Default: 'utf-8'

vim.opt.cmdheight = 1 -- More space for Command line for displaying messages (default: 1)

-- Make updates and timeouts shorter
vim.opt.updatetime = 250 -- Update time (default: 4000)
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence to complete (default: 1000)

-- Sets how neovim will display certain whitespace characters in the editor.
-- Cannot use these if indent-blanklines is also used
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split" -- Preview substitutions live, as you type

vim.api.nvim_set_hl(0, "@comment", { fg = "#dd0000" })
