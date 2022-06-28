local colorbuddy = require("colorbuddy")
colorbuddy.colorscheme("gruvbuddy")

require("colorizer").setup()

local Color = require("colorbuddy").Color
Color.new("darkgreen", "#779E69")
Color.new("string", "#989A24")

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

Group.new("GoTestSuccess", c.green, nil, s.bold)
Group.new("GoTestFail", c.red, nil, s.bold)

-- Group.new('Keyword', c.purple, nil, nil)

Group.new("TSPunctBracket", c.orange:light():light())

Group.new("StatuslineError1", c.red:light():light(), g.Statusline)
Group.new("StatuslineError2", c.red:light(), g.Statusline)
Group.new("StatuslineError3", c.red, g.Statusline)
Group.new("StatuslineError3", c.red:dark(), g.Statusline)
Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline)

Group.new("pythonTSType", c.red)
Group.new("goTSType", g.Type.fg:dark(), nil, g.Type)

Group.new("typescriptTSConstructor", g.pythonTSType)
Group.new("typescriptTSProperty", c.blue)

-- vim.cmd([[highlight WinSeparator guifg=#4e545c guibg=None]])
Group.new("WinSeparator", nil, nil)

Group.new("TSTitle", c.blue)
Group.new("TSType", c.darkgreen)
Group.new("TSString", c.string)

-- diagnostics
Group.new("DiagnosticUnderlineError", nil, nil, s.undercurl + s.bold, c.red)
Group.new("DiagnosticUnderlineWarn", nil, nil, s.undercurl + s.bold, c.orange)
Group.new("DiagnosticUnderlineHint", nil, nil, s.undercurl + s.bold, c.white)
Group.new("DiagnosticUnderlineInfo", nil, nil, s.undercurl + s.bold, c.blue:light())

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
