local devicons = require("nvim-web-devicons")
local entry_display = require("telescope.pickers.entry_display")
local make_entry = require("telescope.make_entry")

return function()
  local default_icons, _ = devicons.get_icon("file", "", { default = true })

  local displayer = entry_display.create({
    separator = " ",
    items = {
      { width = vim.fn.strwidth(default_icons) },
      {},
      { remaining = true },
    },
  })

  local make_display = function(entry)
    return displayer({
      { entry.devicons, entry.devicons_highlight },
      entry.stripped_name,
      { entry.text, "SecondaryMark" },
    })
  end

  return function(entry)
    local filename = entry.filename
    local icons, highlight = devicons.get_icon(filename, string.match(filename, "%a+$"), { default = true })
    local stripped_text = entry.text:gsub("^%s*(.-)%s*$", "%1")

    return make_entry.set_default_entry_mt({
      valid = true,
      value = entry,
      ordinal = string.format("%s %d %s", filename, entry.lnum, entry.text),
      display = make_display,
      stripped_name = vim.fn.fnamemodify(filename, ":p:t") .. " " .. entry.lnum,
      bufnr = entry.bufnr,
      filename = filename,
      lnum = entry.lnum,
      col = entry.col,
      text = stripped_text,
      start = entry.start,
      finish = entry.finish,
      devicons = icons,
      devicons_highlight = highlight,
    }, {})
  end
end
