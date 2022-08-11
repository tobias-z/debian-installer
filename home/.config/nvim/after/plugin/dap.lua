local has_dap, dap = pcall(require, "dap")
if not has_dap then
  return
end

require("nvim-dap-virtual-text").setup({})

local dapui = require("dapui")

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7"),
  layouts = {
    {
      elements = {
        {
          id = "scopes",
          size = 0.70,
        },
        -- { id = "breakpoints", size = 0.35 },
        -- { id = "stacks", size = 0.35 },
        { id = "watches", size = 0.35 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        -- "repl",
        "console",
        -- { id = "console", size = 0.50 },
      },
      size = 10,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  },
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

require("tobiasz.debuggers")
