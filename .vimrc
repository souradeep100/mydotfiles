call plug#begin()
 Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
 Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
 Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'https://github.com/vim-utils/vim-man'
 Plug 'nordtheme/vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()
syntax on
set hlsearch
set sw=4
colorscheme lucius
set tabstop=4
set bg=dark
set splitright
set cursorline
set number
set listchars=tab:\|_,trail:#,precedes:#,extends:#
if has('cscope')
    set cscopetag
    set cscopeverbose

    " Define key mappings for cscope-like functions
    " Find symbol
    map <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    " Find global definition
    map <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    " Find calls/references
    map <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    " Find functions called by
    map <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    " Find files including the file under cursor
    map <C-@>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
    " Find definition (same as <C-]>)
    map <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    " Find files matching pattern
    map <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    " Find text string
    map <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
endif
