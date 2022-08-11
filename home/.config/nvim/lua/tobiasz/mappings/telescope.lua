local with_maker = require("tobiasz.config.telescope.entry-makers").with_entry_maker
local string_util = require("tobiasz.utils.string-util")

VMap.map("<C-p>", with_maker("file", require("tobiasz.config.telescope.pickers").project_files))
VMap.nmap("<leader>pc", with_maker("java", require("tobiasz.config.telescope.pickers").project_files))
VMap.nmap("<leader>pa", require("telescope.builtin").builtin)

VMap.nmap("<leader>pw", function()
  require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end)
VMap.nmap("<leader>ps", function()
  vim.ui.input({ prompt = "Grep For > " }, function(input)
    if not string_util.is_empty(input) then
      require("telescope.builtin").grep_string({ search = input })
    end
  end)
end)

VMap.nmap("<leader>pls", require("telescope.builtin").live_grep)
VMap.nmap("<leader>pf", with_maker("file", require("telescope.builtin").find_files))

VMap.map("<C-f>", require("telescope.builtin").current_buffer_fuzzy_find)

VMap.nmap("<leader>hh", require("telescope.builtin").help_tags)
VMap.nmap("<leader>man", require("telescope.builtin").man_pages)

-- git
VMap.nmap("<leader>gb", require("telescope.builtin").git_branches)
VMap.nmap("<leader>gl", require("telescope.builtin").git_commits)
VMap.nmap("<leader>gs", require("telescope.builtin").git_status)

-- lsp
VMap.nmap("gd", with_maker("references", require("tobiasz.config.telescope.pickers").definitions))
VMap.nmap("gr", with_maker("references", require("tobiasz.config.lsp-config.handlers").go_to_references))
VMap.nmap("gi", with_maker("references", require("telescope.builtin").lsp_implementations))

-- custom
VMap.nmap("<leader>vrc", require("tobiasz.config.telescope.pickers").search_vimrc)

-- extensions
VMap.nmap("<leader>pp", require("telescope").extensions.project.project)
VMap.nmap("<leader>nm", require("telescope").extensions.node_modules.list)
VMap.nmap("<leader>pb", require("telescope").extensions.bookmarks.bookmarks)
VMap.nmap("<leader>pe", require("telescope").extensions.emoji.emoji)

-- Git worktrees
VMap.nmap("<leader>.", require("telescope").extensions.git_worktree.git_worktrees)
VMap.nmap("<leader><leader>.", require("telescope").extensions.git_worktree.create_git_worktree)
