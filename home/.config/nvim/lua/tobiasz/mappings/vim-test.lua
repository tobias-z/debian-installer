local jdtls = require("jdtls")

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

VMap.nmap("<leader>tf", plenary_or("TestFile"))
VMap.nmap("<leader>tp", plenary_or("TestNearest"))

local coverage_commands = {
  go = "-coverpkg=./...",
  gomod = "-coverpkg=./...",
  java = "-P coverage",
}

VMap.nmap("<leader>tc", function()
  local command = coverage_commands[vim.o.filetype]
  if command ~= nil then
    vim.api.nvim_command(string.format("TestSuite %s", command))
  end
end)

local debug_test_commands = {
  java = {
    file = jdtls.test_class,
    nearest = jdtls.test_nearest_method,
  },
}

local function execute_test_command(cmd_name)
  return function()
    local language = debug_test_commands[vim.o.filetype]
    if language == nil then
      return
    end
    local callback = language[cmd_name]
    if callback ~= nil then
      callback()
    end
  end
end

VMap.nmap("<leader>stf", execute_test_command("file"))
VMap.nmap("<leader>stp", execute_test_command("nearest"))
