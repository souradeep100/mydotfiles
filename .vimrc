 set number
 set cindent
 set hlsearch
 set ic
 set textwidth=100
 set cc=100
 set smartcase
 syntax on
 set wildignore+=.pyc,.swp
 set history=1000
 map <F2> : set filetype=messages<CR>
 set nocompatible
 if &diff
 syntax off
 endif
 set statusline+=%F
 call plug#begin()
 Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
 Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
 Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
 Plug 'prabirshrestha/asyncomplete.vim'
 if executable('ctags')
     Plug 'prabirshrestha/asyncomplete-tags.vim'
     Plug 'ludovicchabant/vim-gutentags'
 endif
 set encoding=UTF-8
 call plug#end()
 set bg=dark
 colorscheme hybrid_material
 set lcs=tab:>:,trail:#
 set list
 inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
 inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
 inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>" 

