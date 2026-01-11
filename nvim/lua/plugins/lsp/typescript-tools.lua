return {
	"pmizio/typescript-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig", -- typescript-tools uses lspconfig under the hood
	},
	ft = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	opts = function()
		-- reuse cmp capabilities (same pattern you already use in lsp.lua)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		return {
			capabilities = capabilities,

			-- Nice defaults; tweak as you like
			settings = {
				-- spawn a separate diagnostics server so "go to definition" etc stays snappy
				separate_diagnostic_server = true,
				publish_diagnostic_on = "insert_leave",

				-- If you use prettier via conform, keep TS tools from formatting
				tsserver_format_options = {},
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = false,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		}
	end,
	config = function(_, opts)
		require("typescript-tools").setup(opts)
	end,
}
