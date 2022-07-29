return function(client)
  local ts_utils = require("nvim-lsp-ts-utils")
  ts_utils.setup({
    update_imports_on_move = true,
    require_confirmation_on_move = false,
    watch_dir = nil,
  })
  ts_utils.setup_client(client)
end
