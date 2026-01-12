return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		-- "jay-babu/mason-nvim-dap.nvim", -- TODO: fix this
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} }, -- Useful status updates for LSP
		"hrsh7th/cmp-nvim-lsp", -- Extra capabilities
	},
	config = function()
		require("plugins.lsp.attach").lsp_attach()

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		--
		local servers = {
			lua_ls = require("plugins.lsp.servers.lua_ls"),
			elixirls = require("plugins.lsp.servers.elixirls"),
			emmet_language_server = require("plugins.lsp.servers.emmet"),
			tailwindcss = require("plugins.lsp.servers.tailwindcss"),
			eslint = require("plugins.lsp.servers.eslint"),
		}

		-- you can add other tools here that you want mason to install
		-- for you, so that they are available from within neovim.
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- used to format lua code
			"prettierd", -- fast prettier daemon
			"eslint_d", -- eslint
		})

		-- Change diagnostic symbols in the sign column (gutter)
		if vim.g.have_nerd_font then
			local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
			local diagnostic_signs = {}
			for type, icon in pairs(signs) do
				diagnostic_signs[vim.diagnostic.severity[type]] = icon
			end
			vim.diagnostic.config({ signs = { text = diagnostic_signs } })
		end

		require("mason").setup()

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- require("mason-nvim-dap").setup({ ensure_installed = { "java-debug-adapter", "java-test" } })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- this handles overriding only values explicitly passed
					-- by the server configuration above. useful when disabling
					-- certain features of an lsp (for example, turning off formatting for ts_ls)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
