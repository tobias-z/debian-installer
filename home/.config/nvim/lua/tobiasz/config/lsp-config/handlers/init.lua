local pickers = require("telescope.pickers")
local make_entry = require("telescope.make_entry")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local builders = require("tobiasz.config.telescope.builders")
local java = require("tobiasz.config.lsp-config.handlers.java-handlers")

local handlers = {}

local function jump_to_result(result)
  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], "utf-8")
  else
    vim.lsp.util.jump_to_location(result, "utf-8")
  end
end

function handlers.go_to_definition(on_no_result)
  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result)
    local flattened_results = {}
    if result then
      if not vim.tbl_islist(result) then
        flattened_results = { result }
      end

      vim.list_extend(flattened_results, result)
    end

    if not result then
      on_no_result()
      return
    end

    if vim.tbl_count(result) == 1 then
      local res = result[1]
      local uri = res.uri ~= nil and res.uri or res.targetUri
      local range = res.range ~= nil and res.range or res.targetSelectionRange
      local is_same_file = uri == params.textDocument.uri
      local is_same_pos = range.start.line == params.position.line
      if is_same_file and is_same_pos then
        on_no_result()
        return
      end
    end

    if vim.tbl_isempty(result) then
      on_no_result()
      return
    end

    jump_to_result(result)
  end)
end

function handlers.go_to_references(opts)
  opts = opts or {}
  opts = vim.tbl_deep_extend("force", opts, require("telescope.themes").get_cursor(builders.cursor_theme()))
  local bufnr = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local params = vim.lsp.util.make_position_params(0)
  params.context = { includeDeclaration = false }

  vim.lsp.buf_request(bufnr, "textDocument/references", params, function(_, result, ctx, _)
    local visited = {}
    local locations = {}
    if result then
      local results = vim.lsp.util.locations_to_items(result, vim.lsp.get_client_by_id(ctx.client_id).offset_encoding)
      locations = vim.tbl_filter(function(v)
        local key = string.format("%s%d", v.filename, v.lnum)
        if visited[key] then
          return false
        end
        visited[key] = true
        return not (v.filename == filepath and v.lnum == lnum)
      end, vim.F.if_nil(results, {}))
    end

    if vim.tbl_isempty(locations) then
      return
    end

    if vim.tbl_count(locations) == 1 then
      local location = locations[1]
      jump_to_result({
        range = {
          start = {
            character = location.col - 1,
            line = location.lnum - 1,
          },
        },
        uri = string.format("file://%s", location.filename),
      })
      return
    end

    pickers.new(opts, {
      prompt_title = "LSP References",
      finder = finders.new_table({
        results = locations,
        entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts),
      }),
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(opts),
      push_cursor_on_edit = true,
      push_tagstack_on_edit = true,
    }):find()
  end)
end

function handlers.rename(new_name, opts)
  opts = opts or {}
  if vim.o.filetype == "java" then
    -- TODO: And is renaming field
    java.field_rename(new_name, opts)
  else
    vim.lsp.buf.rename(new_name, opts)
  end
end

return handlers
