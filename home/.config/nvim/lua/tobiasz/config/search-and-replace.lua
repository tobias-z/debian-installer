require("nvim-search-and-replace").setup({
  -- file patters to ignore
  ignore = {
    "**/node_modules/**",
    "**/.git/**",
    "**/.gitignore",
    "**/.gitmodules",
    "build/**",
    "**/dist/**",
    "**/target/**",
  },

  -- save the changes after replace
  update_changes = false,

  replace_keymap = "",

  -- keymap for search and replace ( this does not care about ignored files )
  replace_all_keymap = "",

  -- keymap for search and replace
  replace_and_save_keymap = "<leader>rr",

  -- keymap for search and replace ( this does not care about ignored files )
  replace_all_and_save_keymap = "",
})
