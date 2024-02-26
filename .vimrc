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

set csto=0  " Use cscope first, then ctags
        set cst     " Only search cscope
        set csverb  " Make cs verbose

        nmap `<C-\>`s :cs find s `<C-R>`=expand("`<cword>`")`<CR>``<CR>`
        nmap `<C-\>`g :cs find g `<C-R>`=expand("`<cword>`")`<CR>``<CR>`
        nmap `<C-\>`c :cs find c `<C-R>`=expand("`<cword>`")`<CR>``<CR>`
        nmap `<C-\>`t :cs find t `<C-R>`=expand("`<cword>`")`<CR>``<CR>`
        nmap `<C-\>`e :cs find e `<C-R>`=expand("`<cword>`")`<CR>``<CR>`
        nmap `<C-\>`f :cs find f `<C-R>`=expand("`<cfile>`")`<CR>``<CR>`
        nmap `<C-\>`i :cs find i ^`<C-R>`=expand("`<cfile>`")`<CR>`$`<CR>`
        nmap `<C-\>`d :cs find d `<C-R>`=expand("`<cword>`")`<CR>``<CR>`
        nmap <F6> :cnext <CR>
        nmap <F5> :cprev <CR>

        " Open a quickfix window for the following queries.
        set cscopequickfix=s-,c-,d-,i-,t-,e-,g-

