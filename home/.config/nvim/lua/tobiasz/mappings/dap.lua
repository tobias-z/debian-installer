VMap.nmap("<leader>sn", require("dap").continue)
VMap.nmap("<leader>sa", require("dap").toggle_breakpoint)
VMap.nmap("<leader>sj", require("dap").step_over)
VMap.nmap("<leader>sk", require("dap").step_back)
VMap.nmap("<leader>sl", require("dap").step_into)
VMap.nmap("<leader>sh", require("dap").step_out)
VMap.nmap("<leader>sb", require("telescope").extensions.dap.list_breakpoints)
