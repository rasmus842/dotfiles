return {
	-- see https://github.com/elixir-lsp/elixir-ls
	-- see also github.com/elixir-tools/elixir-tools.nvim
	cmd = { "~/.elixir-ls/release/language_server.sh" },
	settings = {
		autoBuild = false, -- Trigger ElixirLS build when code is saved
		dialyzerEnabled = true, -- Run ElixirLS's rapid Dialyzer when code is saved
		-- incrementalDialyzer = false, -- Use OTP incremental dialyzer (available on OTP 26+)
		-- dialyzerWarnOpts = ? -- Dialyzer options to enable or disable warnings - See Dialyzer's documentation for options. Note that the race_conditions option is unsupported.
		-- dialyzerFormat = ?, -- use for Dialyzer warnings -- elixirLS.envVariables
		-- envVariables = ? -- Environment variables to use for compilation
		-- mixEnv = "" -- Mix environment to use for compilation
		-- mixTarget = "" -- Mix target to use for compilation
		-- projectDir = "" -- Subdirectory containing the Mix project, if it is not in the project root
		-- fetchDeps = false, -- Automatically fetch project dependencies when compiling.
		suggestSpecs = false, -- Suggest @spec annotations inline, using Dialyzer's inferred success typings (Requires Dialyzer).
		-- trace.server = ? -- Traces communication between VS Code and the Elixir language server.
		autoInsertRequiredAlias = true, -- Enable auto-insert required alias - By default, this option is true (enabled).
		-- signatureAfterComplete = false, -- Show signature help after confirming autocomplete.
		enableTestLenses = false,
		-- additionalWatchedExtensions = {}, -- Additional file types capable of triggering a build on change
		-- languageServerOverridePath = "", -- Absolute path to an alternative ElixirLS release that will override the packaged release
	},
}
