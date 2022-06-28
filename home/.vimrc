set ts=4 sw=4
set path+=**
set wildmenu

set autoindent
set cindent
inoremap (  ()<ESC>hli
inoremap [  []<ESC>hli
inoremap {  {}<ESC>hli
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

:set number
:syntax on
:set relativenumber

imap jk <Esc>

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set termguicolors



