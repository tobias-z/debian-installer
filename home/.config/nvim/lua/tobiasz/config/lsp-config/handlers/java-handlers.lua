local string_util = require("tobiasz.utils.string-util")

local java = {}

local function with_name(new_name, callback)
  local old_name = vim.fn.expand("<cword>")
  if new_name ~= nil then
    callback(new_name, old_name)
  else
    vim.ui.input({ prompt = "New Name:", default = old_name }, function(n_name)
      if n_name then
        callback(n_name, old_name)
      end
    end)
  end
end

function java.field_rename(new_name, _)
  local params = vim.lsp.util.make_position_params(0)
  params.context = { includeDeclaration = true }

  vim.lsp.buf_request(vim.api.nvim_get_current_buf(), "textDocument/references", params, function(err, references)
    if err then
      vim.api.nvim_err_writeln("Error finding references: " .. err.message)
      return
    end

    with_name(new_name, function(name, old_name)
      for _, reference in ipairs(references) do
        local bufnr = vim.uri_to_bufnr(reference.uri)
        vim.fn.bufload(bufnr)
        local start = reference.range.start
        local the_end = reference.range["end"]
        local line =
          vim.api.nvim_buf_get_text(
            bufnr,
            start.line,
            start.character,
            the_end.line,
            the_end.character,
            {}
          )[1]
        local original_len = string.len(line)
        local uppercase_old_name = string_util.first_to_upper(old_name)
        if
          string_util.starts_with(line, string.format("%s%s", "get", uppercase_old_name))
          or string_util.starts_with(line, string.format("%s%s", "set", uppercase_old_name))
        then
          local beginning = string.sub(line, 0, 3)
          local ending = string.sub(line, string.len(string.format("%s%s", beginning, uppercase_old_name)) + 1)
          line = string.format("%s%s%s", beginning, string_util.first_to_upper(name), ending)
        else
          local ending = string.sub(line, string.len(old_name) + 1)
          line = string.format("%s%s", name, ending)
        end
        vim.api.nvim_buf_set_text(
          bufnr,
          start.line,
          start.character,
          start.line,
          start.character + original_len,
          { line }
        )
      end
    end)
  end)
end

return java
