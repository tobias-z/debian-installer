require("dressing").setup({
  input = {
    enabled = true,
    -- Can be 'left', 'right', or 'center'
    prompt_align = "left",

    -- When true, <Esc> will close the modal
    insert_only = false,

    -- When true, input will start in insert mode.
    start_in_insert = true,
  },
  select = {
    -- Set to false to disable the vim.ui.select implementation
    enabled = false,
  },
})
