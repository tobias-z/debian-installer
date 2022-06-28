VMap.map("<C-p>", require("tobiasz.utils.telescope").project_files)
VMap.nmap("<leader>pa", require("telescope.builtin").builtin)

VMap.nmap("<leader>pw", function()
    require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end)
VMap.nmap("<leader>ps", function()
    require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ") })
end)

VMap.nmap("<leader>pls", require("telescope.builtin").live_grep)
VMap.nmap("<leader>pf", require("telescope.builtin").find_files)

VMap.map("<C-f>", require("telescope.builtin").current_buffer_fuzzy_find)

VMap.nmap("<leader>hh", require("telescope.builtin").help_tags)
VMap.nmap("<leader>man", require("telescope.builtin").man_pages)

-- git
VMap.nmap("<leader>gb", require("telescope.builtin").git_branches)
VMap.nmap("<leader>gl", require("telescope.builtin").git_commits)
VMap.nmap("<leader>gs", require("telescope.builtin").git_status)

-- lsp
VMap.nmap("gd", require("telescope.builtin").lsp_definitions)
VMap.nmap("gr", require("telescope.builtin").lsp_references)
VMap.nmap("gi", require("telescope.builtin").lsp_implementations)

-- custom
VMap.nmap("<leader>vrc", require("tobiasz.utils.telescope").search_vimrc)

-- extensions
VMap.nmap("<leader>pp", require("telescope").extensions.project.project)
VMap.nmap("<leader>nm", require("telescope").extensions.node_modules.list)
VMap.nmap("<leader>pb", require("telescope").extensions.bookmarks.bookmarks)
VMap.nmap("<leader>pe", require("telescope").extensions.emoji.emoji)
