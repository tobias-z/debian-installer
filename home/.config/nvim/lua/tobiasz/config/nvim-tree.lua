local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")

local function collapse_all()
  require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
  local action = "edit"
  local node = lib.get_node_at_cursor()

  if node == nil then
    return
  end

  if node.link_to and not node.nodes then
    require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
    view.close()
  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
    view.close()
  end
end

local function vsplit_preview()
  local action = "vsplit"
  local node = lib.get_node_at_cursor()

  if node == nil then
    return
  end

  if node.link_to and not node.nodes then
    require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
  end

  view.focus()
end

require("nvim-tree").setup({
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = { hint = "", info = "", warning = "", error = "" },
  },
  filters = {
    custom = {
      "node_modules",
      "\\.git$",
    },
  },
  git = {
    enable = false,
    ignore = false,
  },
  renderer = {
    group_empty = true,
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = " ",
          open = " ",
          empty = "  ",
          empty_open = " ",
          symlink = " ",
          symlink_open = " ",
        },
      },
    },
  },
  view = {
    hide_root_folder = false,
    width = 40,
    adaptive_size = true,
    mappings = {
      custom_only = false,
      list = {
        { key = "l", action = "edit", action_cb = edit_or_open },
        { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
        { key = "H", action = "collapse_all", action_cb = collapse_all },
      },
    },
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
})
