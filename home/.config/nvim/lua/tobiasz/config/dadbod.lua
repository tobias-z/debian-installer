vim.cmd([[
augroup dbui_overrides
    autocmd FileType dbui nmap <buffer> <C-j> <cmd>wincmd j<CR>
    autocmd FileType dbui nmap <buffer> <C-k> <cmd>wincmd k<CR>
augroup END
]])

vim.cmd([[
augroup db_completion
    autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
augroup END
]])
