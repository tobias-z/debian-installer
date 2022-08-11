VMap.nmap("<leader><leader>s", ":w | luafile %<CR>")

VMap.imap("<C-BS>", "<C-w>")
VMap.imap("<C-h>", "<C-w>")
VMap.imap("<C-c>", "<Esc>")
VMap.imap("jk", "<Esc>")

VMap.nmap("<leader>+", "<cmd>vertical resize +5<CR>")
VMap.nmap("<leader>-", "<cmd>vertical resize -5<CR>")

VMap.nmap("<leader><leader>x", ":silent !chmod +x %<CR>")
VMap.nmap("Y", "yg$")

-- navigation
VMap.nmap("<C-l>", "<cmd>wincmd l<CR>")
VMap.nmap("<C-h>", "<cmd>wincmd h<CR>")
VMap.nmap("<C-j>", "<cmd>wincmd j<CR>")
VMap.nmap("<C-k>", "<cmd>wincmd k<CR>")

VMap.vmap("<Tab>", ">gv")
VMap.vmap("<S-Tab>", "<gv")
VMap.vmap("<C-J>", ":m '>+1<CR>gv=gv")
VMap.vmap("<C-K>", ":m '<-2<CR>gv=gv")

VMap.tmap("<Esc>", "<C-\\><C-n>")

VMap.vmap("<leader>y", '"+y')
