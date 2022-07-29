local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local function nav_to(id)
  return function()
    ui.nav_file(id)
  end
end

VMap.nmap("<leader>a", mark.add_file)
VMap.nmap("<leader>e", ui.toggle_quick_menu)
VMap.nmap("<leader>1", nav_to(1))
VMap.nmap("<leader>2", nav_to(2))
VMap.nmap("<leader>3", nav_to(3))
VMap.nmap("<leader>4", nav_to(4))
VMap.nmap("<leader>5", nav_to(5))
