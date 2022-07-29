local tobias_z = vim.api.nvim_create_augroup("TOBIAS_Z", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = tobias_z,
  callback = function()
    require("vim.highlight").on_yank({ timeout = 40 })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = tobias_z,
  callback = function()
    local save = vim.fn.winsaveview()
    local patterns = {
      [[%s/\s\+$//e]],
      [[%s/\($\n\s*\)\+\%$//]],
      [[%s/\%^\n\+//]],
      [[%s/\(\n\n\)\n\+/\1/]],
    }
    for _, v in pairs(patterns) do
      vim.api.nvim_exec(string.format("keepjumps keeppatterns silent! %s", v), false)
    end
    vim.fn.winrestview(save)
  end,
})

vim.api.nvim_create_autocmd("FileType *", {
  group = tobias_z,
  callback = function()
    local tabsize = Settings.get_config(vim.o.filetype).tab_size
    if vim.o.shiftwidth ~= tabsize then
      vim.cmd(string.format([[setlocal tabstop=%d softtabstop=%d shiftwidth=%d]], tabsize, tabsize, tabsize))
    end
  end,
})

vim.cmd([[
augroup choice_popup
au!
au User LuasnipChoiceNodeEnter lua Luasnip.choice_popup(require("luasnip").session.event_node)
au User LuasnipChoiceNodeLeave lua Luasnip.choice_popup_close()
au User LuasnipChangeChoice lua Luasnip.update_choice_popup(require("luasnip").session.event_node)
augroup END
]])
