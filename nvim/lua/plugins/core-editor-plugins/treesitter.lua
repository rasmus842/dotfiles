return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- On the `main` branch, setup() only configures the plugin itself
		-- (e.g. install_dir). Parser installation, highlighting and indent are
		-- handled separately below — there is no more `nvim-treesitter.configs`.
		require("nvim-treesitter").setup()

		local ensure_installed = {
			"go",
			"gomod",
			"gosum",
			"ruby",
			"c",
			"python",
			"java",
			"groovy",
			"elixir",
			"heex",
			"javascript",
			"typescript",
			"regex",
			"sql",
			"html",
			"css",
			"tsx",
			"xml",
			"json",
			"yaml",
			"toml",
			"make",
			"cmake",
			"vim",
			"vimdoc",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"bash",
			"query",
			"diff",
			"gitignore",
			"dockerfile",
		}

		-- Install any parsers from the list that aren't present yet.
		-- (Replaces the old `ensure_installed` + `auto_install` opts.)
		local installed = require("nvim-treesitter").get_installed("parsers")
		local to_install = vim.tbl_filter(function(lang)
			return not vim.tbl_contains(installed, lang)
		end, ensure_installed)
		if #to_install > 0 then
			require("nvim-treesitter").install(to_install)
		end

		-- Enable highlighting and treesitter-based indent per buffer.
		-- (Replaces the old `highlight = { enable = true }` / `indent` opts.)
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				-- Only start if a parser is actually available for this filetype.
				local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
				if lang and vim.treesitter.language.add(lang) then
					vim.treesitter.start(args.buf, lang)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
