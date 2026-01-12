local status, jdtls = pcall("require", "jdtls")
if not status then
	return
end

local home = os.getenv("HOME")
local nvim_cache_dir = home .. "/.local/share/nvim"
local workspace_path = nvim_cache_dir .. "/jdtls-workspace"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name
local jdtls_launcher = vim.fn.glob(nvim_cache_dir .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
local jdtls_config = nvim_cache_dir .. "/mason/packages/jdtls/config_linux"
local extendedClientCapabilities = jdtls.extendedClientCapabilities

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
		"-jar " .. jdtls_launcher,
		"-configuration " .. jdtls_config,
		"-data " .. workspace_dir,
	},
	root_dir = jdtls.setup.find_root({ ".git", "gradlew", "build.gradle", "mvnw", "pom.xml" }),

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			signatureHelp = { enabled = true },
			extendedClientCapabilities = jdtls.extendedClientCapabilities,
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
}
require("jdtls").start_or_attach(config)
