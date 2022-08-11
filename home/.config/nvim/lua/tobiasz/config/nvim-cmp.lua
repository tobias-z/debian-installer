local luasnip = require("luasnip")
local ok, cmp = pcall(require, "cmp")

if not ok then
  return
end

local cmp_kinds = {
  Text = "",
  Method = "M",
  Function = "M",
  Constructor = "M",
  Field = "F",
  Variable = "V",
  Class = "C",
  Interface = "I",
  Module = "",
  Property = "P",
  Unit = "",
  Value = "",
  Enum = "E",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "F",
  Constant = "F",
  Struct = "S",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

-- if vim.env.HOME:find("Users") then
-- 	cmp_kinds = {
-- 		Text = "",
-- 		Method = "",
-- 		Function = "",
-- 		Constructor = "",
-- 		Field = "",
-- 		Variable = "",
-- 		Class = "ﴯ",
-- 		Interface = "",
-- 		Module = "",
-- 		Property = "ﰠ",
-- 		Unit = "",
-- 		Value = "",
-- 		Enum = "",
-- 		Keyword = "",
-- 		Snippet = "",
-- 		Color = "",
-- 		File = "",
-- 		Reference = "",
-- 		Folder = "",
-- 		EnumMember = "",
-- 		Constant = "",
-- 		Struct = "",
-- 		Event = "",
-- 		Operator = "",
-- 		TypeParameter = "",
-- 	}
-- end

cmp.setup({
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
  end,
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, vim_item)
      vim_item.kind = cmp_kinds[vim_item.kind] or ""
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- window = {
  -- 	completion = cmp.config.window.bordered(),
  -- 	documentation = cmp.config.window.bordered(),
  -- },
  mapping = cmp.mapping.preset.insert({
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
    ["<C-Space>"] = cmp.mapping.complete(),
    -- ["<CR>"] = cmp.mapping.confirm({
    --   -- behavior = cmp.ConfirmBehavior.Replace,
    --   select = true,
    -- }),
    ["<Esc>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({
          select = true,
          -- behavior = cmp.ConfirmBehavior.Replace,
        })
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-j>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "dap" },
  }, {
    { name = "git" },
    { name = "path" },
    { name = "buffer" },
  }),
})

require("cmp_git").setup()
