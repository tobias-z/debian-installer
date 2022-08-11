VMap.nmap("<leader>gg", "<cmd>G<CR>")
VMap.nmap("<leader>ga", "<cmd>G add -A<CR>")
VMap.nmap("<leader>gc", "<cmd>G commit <CR>")
VMap.nmap("<leader>gp", "<cmd>G push<CR>")

VMap.nmap("<leader>gv", "<cmd>!gh repo view --web<CR>")

-- Merging

VMap.nmap("<leader>gd", "<cmd>Gdiffsplit<CR>")
VMap.nmap("<leader>gh", "<cmd>diffget //3<CR>")
VMap.nmap("<leader>gu", "<cmd>diffget //2<CR>")
