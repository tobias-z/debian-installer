local set = vim.opt

vim.notify = require("notify")

vim.cmd([[set mouse=a]])
vim.cmd([[set backspace=indent,eol,start]])

set.expandtab = true
set.smarttab = true
set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4
set.hlsearch = false
set.signcolumn = "yes:1"
set.incsearch = true
set.hidden = true
set.errorbells = false
set.expandtab = true
set.ignorecase = true
set.smartcase = true
set.showmatch = true

set.splitbelow = true
set.splitright = true
set.wrap = false
set.swapfile = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.backup = false
set.undofile = true

set.scrolloff = 10
set.fileencoding = "utf-8"
set.termguicolors = true

set.relativenumber = true
set.number = true
set.cursorline = true
set.spell = false
set.updatetime = 1000

set.laststatus = 3
set.pumblend = 5
set.pumheight = 14
set.lazyredraw = true

set.autoindent = true
set.cindent = true
set.formatoptions = set.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  - "O" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

set.wildignore = "__pycache__"
set.wildignore = set.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }
