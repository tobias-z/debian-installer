local builders = {}

local search_theme = "dropdown"
local action_theme = "cursor"

function builders.with_layout(table)
  -- table.borderchars = {
  --     { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  --     prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
  --     results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
  --     preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  -- }
  table.prompt_title = false
  table.preview_title = false
  return table
end

function builders.search(with_preview)
  local search_no_preview = {
    theme = search_theme,
    layout_strategy = "vertical",
    layout_config = {
      width = 0.4,
      height = 0.6,
      preview_cutoff = 10,
      preview_height = 0.4,
      prompt_position = "top",
      -- mirror = true,
    },
  }

  if not with_preview then
    search_no_preview.previewer = false
  end

  return builders.with_layout(search_no_preview)
end

function builders.search_with_preview(_opts)
  return vim.tbl_deep_extend("force", builders.search(true), _opts or {})
end

function builders.search_no_preview(_opts)
  return vim.tbl_deep_extend("force", builders.search(false), _opts or {})
end

function builders.cursor_theme()
  return builders.with_layout({
    theme = action_theme,
    layout_config = {
      width = 0.65,
      preview_width = 0.45,
      height = 0.4,
    },
  })
end

return builders
