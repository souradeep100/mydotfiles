set number
set sw=4
set tabstop=4
set hlsearch
colorscheme delek
set bg=dark
set ic
set smartcase
syntax on
set dir=/datadrive/vimdir
set wildignore+=.pyc,.swp
set history=1000
map <F2> : set filetype=messages<CR>
set nocompatible
if &diff
    syntax off
endif

set statusline+=%F

