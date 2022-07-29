local lsp_handlers = require("tobiasz.config.lsp-config.handlers")

local M = {}

function M.search_vimrc()
  require("telescope.builtin").find_files({
    prompt_title = "VimRC",
    cwd = vim.env.DOTFILES,
    hidden = true,
  })
end

function M.project_files(opts)
  opts = opts or {}
  local ok = pcall(function()
    require("telescope.builtin").git_files(opts)
  end)
  if not ok then
    require("telescope.builtin").find_files(opts)
  end
end

function M.definitions(opts)
  opts = opts or {}
  lsp_handlers.go_to_definition(function()
    lsp_handlers.go_to_references(opts)
  end)
end

return M
