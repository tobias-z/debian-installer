local builder = Snip.create_snippet_builder("lua")
local h = builder.helpers

builder.vscode_snip(
  "func",
  [[
local function $1($2)
  $0
end]]
)

builder.vscode_snip(
  "mfunc",
  [[
function M.$1($2)
  $0
end]]
)

builder.vscode_snip(
  "class",
  [[
local $1 = {}

function $1:new($2)
  $0
  return self
end
]]
)

builder.vscode_snip(
  "method",
  [[
function $1:$2($3)
  $0
end]]
)

builder.snip(h.snippet(
  "req",
  h.fmt([[local {} = require("{}")]], {
    h.f(function(name)
      local parts = vim.split(name[1][1], ".", true)
      return parts[#parts] or ""
    end, { 1 }),
    h.i(1),
  })
))

builder.vscode_snip(
  "module",
  [[
local $1 = {}

function $1.$2($3)
  $0
end

return $1
    ]]
)

-- testing

builder.vscode_snip(
  "testcase",
  [[
it("$1", function()
  $0
end)]]
)

builder.vscode_snip(
  "nested",
  [[
describe("$1", function()
  $0
end)]]
)

builder.vscode_snip(
  "before",
  [[
before_each(function()
  $0
end)]]
)

builder.vscode_snip(
  "after",
  [[
after_each(function()
  $0
end)]]
)

builder.build()
