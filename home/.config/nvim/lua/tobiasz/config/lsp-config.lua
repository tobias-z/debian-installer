require("nvim-lsp-installer").setup({})
local lspconfig = require("lspconfig")
local util = lspconfig.util

local opts = { noremap = true, silent = true }

VMap.nmap("<leader>di", vim.diagnostic.open_float)
VMap.nmap("<leader>dk", vim.diagnostic.goto_prev)
VMap.nmap("<leader>dj", vim.diagnostic.goto_next)
VMap.nmap("<leader>q", vim.diagnostic.setloclist)

local on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		require("tobiasz.config.nvim-lsp-ts-utils")(client)
	end

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-n>", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

	-- Hightlight all references of same name
	if client.server_capabilities.documentHighlightProvider then
		vim.cmd([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
	end

	if client.server_capabilities.codeLensProvider then
		vim.cmd([[
        augroup lsp_document_codelens
          au! * <buffer>
          autocmd BufEnter ++once         <buffer> lua require("vim.lsp.codelens").refresh()
          autocmd BufWritePost,CursorHold <buffer> lua require("vim.lsp.codelens").refresh()
        augroup END
      ]])
	end
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
	bashls = true,
	pyright = true,
	vimls = true,
	sumneko_lua = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = runtime_path,
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	html = true,
	jsonls = true,
	cssls = true,
	cssmodules_ls = true,
	tsserver = true,
	eslint = true,
	yamlls = true,
	dockerls = true,
	tailwindcss = {
		root_dir = util.root_pattern(
			"tailwind.config.js",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.ts"
		),
	},
	rust_analyzer = true,
	gopls = {
		settings = {
			gopls = {
				codelenses = { test = true },
				analyses = { unusedparams = true },
				staticcheck = true,
			},
		},
	},
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local buf_format = vim.api.nvim_create_augroup("buf_format", { clear = true })

local default_opts = {
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	vim.api.nvim_create_autocmd("BufWritePre <buffer>", {
		group = buf_format,
		callback = function()
			vim.lsp.buf.format()
		end,
	}),
}

for name, val in pairs(servers) do
	local options = type(val) == "boolean" and {} or val
	lspconfig[name].setup(vim.tbl_deep_extend("force", default_opts, options))
end
