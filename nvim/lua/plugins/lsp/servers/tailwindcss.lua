return {
	-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/tailwindcss.lua
	-- https://github.com/mhanberg/motchvim/blob/main/plugin/motchvim.lua#L164
	-- cmd = vim.lsp.rpc.connect("127.0.0.1", 9000),
	filetypes = {
		-- html
		"html",
		"aspnetcorerazor",
		"astro",
		"astro-markdown",
		"blade",
		"clojure",
		"django-html",
		"htmldjango",
		"edge",
		-- css
		"css",
		"less",
		"postcss",
		"sass",
		"scss",
		"stylus",
		"sugarss",
		-- js
		"javascript",
		"javascriptreact",
		"reason",
		"rescript",
		"typescript",
		"typescriptreact",
		-- elixir and phoenix
		"eelixir", -- vim ft
		"elixir",
		"heex",
		"html-eex",
		-- other
		"markdown",
		"mdx",
		"mustache",
		"njk",
		"nunjucks",
		"php",
		"razor",
		"slim",
		"twig",
		"vue",
		"svelte",
		"templ",
		"ejs",
		"erb",
	},
	init_options = {
		userLanguages = {
			elixir = "phoenix-heex",
			heex = "phoenix-heex",
			surface = "phoenix-heex",
		},
	},
	settings = {
		tailwindCSS = {
			validate = true,
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidScreen = "error",
				invalidVariant = "error",
				invalidConfigPath = "error",
				invalidTailwindDirective = "error",
				recommendedVariantOrder = "warning",
			},
			classAttributes = {
				"class",
				"className",
				"class:list",
				"classList",
				"ngClass",
			},
			experimental = {
				classRegex = {
					[[class:\s*"([^"]*)]],
				},
			},
		},
	},
}
