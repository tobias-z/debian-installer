VMap.nmap("<leader>tt", "<cmd>TestVisit<CR>")
VMap.nmap("<leader>tl", "<cmd>TestLast<CR>")
VMap.nmap("<leader>ts", "<cmd>TestSuite<CR>")

local function plenary_or(command)
    return function()
        if vim.o.filetype == "lua" then
            vim.api.nvim_command(':execute "normal \\<Plug>PlenaryTestFile"')
        else
            vim.api.nvim_command(command)
        end
    end
end

VMap.nmap("<leader>tf", plenary_or("TestFile -v"))
VMap.nmap("<leader>tp", plenary_or("TestNearest -v"))

local coverage_commands = {
    go = "-coverpkg=./...",
    gomod = "-coverpkg=./...",
}

VMap.nmap("<leader>tc", function()
    local command = coverage_commands[vim.o.filetype]
    if command ~= nil then
        vim.api.nvim_command(string.format("TestSuite %s", command))
    end
end)
