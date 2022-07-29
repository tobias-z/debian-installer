require("notify").setup({
  level = "WARN",
  stages = "static",
  on_open = nil,
  on_close = nil,
  render = "default",
  timeout = 5000,
  max_width = 100,
  max_height = nil,
  -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
  background_colour = "Normal",
  minimum_width = 50,
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
})
