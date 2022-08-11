local M = {}

function M.remove_cwd(str)
  local cwd = vim.fn.getcwd()
  return string.sub(str, string.len(cwd) + 2)
end

function M.is_empty(str)
  return str == nil or str == ""
end

function M.first_to_upper(str)
  return str:gsub("^%l", string.upper)
end

function M.starts_with(str, pattern)
  return str:find("^" .. pattern) ~= nil
end

function M.last_index_of(str, pattern)
  return string.match(str, "^.*()" .. pattern)
end

return M
