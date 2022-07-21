require("nvim-lsp-installer").setup({})
local handlers = require("tobiasz.config.lsp-config.handlers")
local lspconfig = require("lspconfig")
local util = lspconfig.util

VMap.nmap("<leader>di", vim.diagnostic.open_float)
VMap.nmap("<leader>dk", vim.diagnostic.goto_prev)
VMap.nmap("<leader>dj", vim.diagnostic.goto_next)
VMap.nmap("<leader>q", vim.diagnostic.setloclist)

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
    texlab = true,
    lemminx = true,
}

local buf_format = vim.api.nvim_create_augroup("buf_format", { clear = true })

local default_opts = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
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
