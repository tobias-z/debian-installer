local find_files_entry_marker = require("tobiasz.config.telescope.entry-makers.find-files")
local find_references_entry_makers = require("tobiasz.config.telescope.entry-makers.find-references")

vim.cmd([[highlight! SecondaryMark guibg=NONE guifg=#808080]])

local makers = {}

function makers.with_entry_maker(maker, telescope_cb)
  return function()
    telescope_cb({
      entry_maker = makers[string.format("%s_entry_maker", maker)](),
    })
  end
end

function makers.file_entry_maker()
  return find_files_entry_marker()
end

function makers.java_entry_maker()
  return find_files_entry_marker(function()
    return "java"
  end)
end

function makers.references_entry_maker()
  return find_references_entry_makers()
end

return makers
