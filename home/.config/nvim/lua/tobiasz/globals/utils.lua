P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  return require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

Multiline_string = function(string, ...)
  local lines = { unpack({ ... } or {}) }
  if lines == nil then
    return string
  end
  for _, line in ipairs(lines) do
    string = string .. "\n" .. line
  end
  return string
end
