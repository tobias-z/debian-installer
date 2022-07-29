local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier.with({
      prefer_local = "node_modules/.bin",
    }),
    null_ls.builtins.formatting.google_java_format.with({
      extra_args = {
        "--aosp",
      },
    }),
    null_ls.builtins.formatting.xmllint,
  },
})

vim.env.XMLLINT_INDENT = "    "
