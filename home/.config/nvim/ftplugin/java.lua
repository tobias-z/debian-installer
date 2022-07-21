local jdtls = require("jdtls")
local handlers = require("tobiasz.config.lsp-config.handlers")
local home = os.getenv("HOME")
local sys_name = vim.fn.has("mac") == 1 and "mac" or "linux"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/share/jdtls/workspaces/" .. project_name

local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
if root_dir == "" then
	return
end

local config = {}

-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
config.cmd = {
	"java",

	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-javaagent:" .. home .. "/.local/share/nvim/lsp_servers/jdtls/lombok.jar",
	"-Xms1g",
	"--add-modules=ALL-SYSTEM",

	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",

	"-jar",
	vim.fn.glob(home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
	"-configuration",
	home .. "/.local/share/nvim/lsp_servers/jdtls/config_" .. sys_name,
	"-data",
	workspace_dir,
}

config.root_dir = root_dir

-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
config.settings = {
	java = {
		eclipse = {
			downloadSources = true,
		},
		configuration = {
			updateBuildConfiguration = "interactive",
			runtimes = {
				{
					name = "JavaSE-1.8",
					path = vim.fn.glob(home .. "/.sdkman/candidates/java/8.0.*"),
				},
				{
					name = "JavaSE-11",
					path = vim.fn.glob(home .. "/.sdkman/candidates/java/11.0.*"),
				},
			},
			maven = {
				userSettings = home .. "/.m2/settings.xml",
			},
		},
		errors = {
			incompleteClasspath = {
				severity = "error",
			},
		},
		autobuild = {
			enabled = true,
		},
		import = {
			gradle = {
				enabled = true,
			},
			maven = {
				enabled = true,
			},
			exclusions = {
				"**/node_modules/**",
				"**/.metadata/**",
				"**/archetype-resources/**",
				"**/META-INF/maven/**",
				"/**/test/**",
			},
		},
		maven = {
			downloadSources = true,
			updateSnapshots = true,
		},
		implementationsCodeLens = {
			enabled = false,
		},
		referencesCodeLens = {
			enabled = false,
		},
		references = {
			includeDecompiledSources = true,
		},
		progressReports = {
			enabled = false,
		},
		format = {
			enabled = false,
			-- Using google-java-format with null-ls
			settings = {
				profile = "GoogleStyle",
				url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
			},
		},
	},
	signatureHelp = { enabled = true },
	completion = {
		favoriteStaticMembers = {
			"org.hamcrest.MatcherAssert.assertThat",
			"org.hamcrest.Matchers.*",
			"org.hamcrest.CoreMatchers.*",
			"org.junit.jupiter.api.Assertions.*",
			"java.util.Objects.requireNonNull",
			"java.util.Objects.requireNonNullElse",
			"org.mockito.Mockito.*",
		},
		importOrder = {
			"java",
			"javax",
			"com",
			"org",
		},
		override = false,
	},
	contentProvider = { preferred = "fernflower" },
	sources = {
		organizeImports = {
			starThreshold = 0,
			staticStarThreshold = 0,
		},
	},
	codeGeneration = {
		toString = {
			listArrayContents = true,
			template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
		},
		useBlocks = true,
		generateComments = false,
	},
}

config.flags = {
	allow_incremental_sync = true,
	debounce_text_changes = 150,
}

local jar_patterns = {
	"/config/neovim/debuggers/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
	"/config/neovim/debuggers/vscode-java-test/server/*.jar",
	"/config/neovim/debuggers/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar",
	"/config/neovim/debuggers/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar",
	"/config/neovim/debuggers/vscode-java-test/java-extension/com.microsoft.java.test.runner/lib/*.jar",
}

local bundles = {}
for _, jar_pattern in ipairs(jar_patterns) do
	for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), "\n")) do
		if
			not vim.endswith(bundle, "com.microsoft.java.test.runner-jar-with-dependencies.jar")
			and not vim.endswith(bundle, "com.microsoft.java.test.runner.jar")
		then
			table.insert(bundles, bundle)
		end
	end
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
config.init_options = {
	bundles = bundles,
	extendedClientCapabilities = extendedClientCapabilities,
}

config.capabilities = handlers.capabilities

config.on_attach = function(client, bufnr)
	jdtls.setup_dap({ hotcodereplace = "auto" })
	jdtls.setup.add_commands()
	handlers.on_attach(client, bufnr)
	local opts = { silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>oi", jdtls.organize_imports)
	vim.keymap.set("v", "<leader>rv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
	vim.keymap.set("n", "<leader>rv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
	vim.keymap.set("v", "<leader>rc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
	vim.keymap.set("n", "<leader>rc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
	vim.keymap.set("v", "<leader>rm", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
	vim.keymap.set("n", "<leader>rm", [[<ESC><CMD>lua require('jdtls').extract_method()<CR>]], opts)
	require("jdtls.dap").setup_dap_main_class_configs()
end

jdtls.start_or_attach(config)
