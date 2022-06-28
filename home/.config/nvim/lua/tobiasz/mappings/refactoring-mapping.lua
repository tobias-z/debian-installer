local opts = { expr = false }

VMap.vmap("<leader>rm", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], opts)
VMap.vmap("<C-r>", require("telescope").extensions.refactoring.refactors, opts)
VMap.vmap("<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], opts)
VMap.vmap("<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], opts)

VMap.nmap("<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], opts)
VMap.nmap("<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], opts)

VMap.vmap("<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opts)
VMap.nmap("<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opts)
