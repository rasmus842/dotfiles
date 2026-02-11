local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local root_files = {
	"settings.gradle",
	"settings.gradle.kts",
	".git",
	"gradlew",
	"mvnw",
	"pom.xml",
}

local home = os.getenv("HOME")
local nvim_cache_dir = home .. "/.local/share/nvim"

local workspace_path = nvim_cache_dir .. "/jdtls-workspace"
local root_dir = jdtls.setup.find_root(root_files)
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = workspace_path .. "/" .. project_name

local jdtls_launcher = vim.fn.glob(nvim_cache_dir .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
local jdtls_config = nvim_cache_dir .. "/mason/packages/jdtls/config_linux"

local java_keymaps = function()
	-- Allow yourself to run JdtCompile as a Vim command
	vim.cmd(
		"command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
	)
	-- Allow yourself/register to run JdtUpdateConfig as a Vim command
	vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
	-- Allow yourself/register to run JdtBytecode as a Vim command
	vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
	-- Allow yourself/register to run JdtShell as a Vim command
	vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

	-- Set a Vim motion to <Space> + <Shift>J + o to organize imports in normal mode
	vim.keymap.set(
		"n",
		"<leader>Jo",
		"<Cmd> lua require('jdtls').organize_imports()<CR>",
		{ desc = "[J]ava [O]rganize Imports" }
	)
	-- Set a Vim motion to <Space> + <Shift>J + v to extract the code under the cursor to a variable
	vim.keymap.set(
		"n",
		"<leader>Jv",
		"<Cmd> lua require('jdtls').extract_variable()<CR>",
		{ desc = "[J]ava Extract [V]ariable" }
	)
	-- Set a Vim motion to <Space> + <Shift>J + v to extract the code selected in visual mode to a variable
	vim.keymap.set(
		"v",
		"<leader>Jv",
		"<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>",
		{ desc = "[J]ava Extract [V]ariable" }
	)
	-- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code under the cursor to a static variable
	vim.keymap.set(
		"n",
		"<leader>JC",
		"<Cmd> lua require('jdtls').extract_constant()<CR>",
		{ desc = "[J]ava Extract [C]onstant" }
	)
	-- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
	vim.keymap.set(
		"v",
		"<leader>JC",
		"<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>",
		{ desc = "[J]ava Extract [C]onstant" }
	)
	-- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
	vim.keymap.set(
		"n",
		"<leader>Jt",
		"<Cmd> lua require('jdtls').test_nearest_method()<CR>",
		{ desc = "[J]ava [T]est Method" }
	)
	-- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
	vim.keymap.set(
		"v",
		"<leader>Jt",
		"<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>",
		{ desc = "[J]ava [T]est Method" }
	)
	-- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
	vim.keymap.set("n", "<leader>JT", "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "[J]ava [T]est Class" })
	-- Set a Vim motion to <Space> + <Shift>J + u to update the project configuration
	vim.keymap.set("n", "<leader>Ju", "<Cmd> JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config" })
end

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
		"-jar",
		jdtls_launcher,
		"-configuration",
		jdtls_config,
		"-data",
		workspace_dir,
	},
	root_dir = root_dir,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			signatureHelp = { enabled = true },
			extendedClientCapabilities = jdtls.extendedClientCapabilities,
			import = {
				gradle = {
					enabled = true,
					wrapper = { enabled = true },
				},
			},
		},
	},

	-- This sets the `initializationOptions` sent to the language server
	-- If you plan on using additional eclipse.jdt.ls plugins like java-debug
	-- you'll need to set the `bundles`
	--
	-- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on any eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},
	on_attach = function(_, bufnr)
		java_keymaps()
	end,
}
jdtls.start_or_attach(config)
