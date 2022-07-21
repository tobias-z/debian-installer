local M = {}

M.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

M.on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    if client.name == "tsserver" then
        require("tobiasz.config.lsp-config.ts-utils")(client)
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
    ]]   )
    end

    if client.server_capabilities.codeLensProvider then
        vim.cmd([[
        augroup lsp_document_codelens
          au! * <buffer>
          autocmd BufEnter ++once         <buffer> lua require("vim.lsp.codelens").refresh()
          autocmd BufWritePost,CursorHold <buffer> lua require("vim.lsp.codelens").refresh()
        augroup END
      ]] )
    end
end

return M
