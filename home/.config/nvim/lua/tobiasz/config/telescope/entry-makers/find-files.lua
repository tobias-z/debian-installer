local devicons = require("nvim-web-devicons")
local entry_display = require("telescope.pickers.entry_display")
local string_util = require("tobiasz.utils.string-util")

return function(get_specific_filetype)
  local use_specific_file_type = get_specific_filetype ~= nil
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
    local dir_name = entry.dir_name
    if string_util.is_empty(dir_name) then
      dir_name = "."
    end
    return displayer({
      { entry.devicons, entry.devicons_highlight },
      entry.file_name,
      { dir_name, "SecondaryMark" },
    })
  end

  return function(entry)
    local bufname = entry ~= "" and entry or "[No Name]"
    local dir_name = string_util.remove_cwd(vim.fn.fnamemodify(bufname, ":p:h"))
    local file_name = vim.fn.fnamemodify(bufname, ":p:t")

    if use_specific_file_type then
      local specific_file_type = get_specific_filetype()
      if specific_file_type ~= nil then
        local ending = string.sub(
          bufname,
          string.len(bufname) - string.len(specific_file_type) + 1,
          string.len(bufname)
        )
        if ending ~= specific_file_type then
          return
        end
      end
    end

    local icons, highlight = devicons.get_icon(bufname, string.match(bufname, "%a+$"), { default = true })
    return {
      valid = true,
      value = bufname,
      ordinal = string.format("%s/%s", dir_name, file_name),
      display = make_display,
      devicons = icons,
      devicons_highlight = highlight,
      file_name = file_name,
      dir_name = dir_name,
    }
  end
end
