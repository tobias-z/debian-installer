local ls = require("luasnip")

VMap.imap("<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)
