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
set cscopeverbose
" Find symbol
set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-
"if filereadable("cscope.out")
"           cs add cscope.out
"endif
augroup CscopeQuickfixAutoOpen
    autocmd!
    autocmd QuickFixCmdPost [^l]* copen 10
augroup END
if filereadable("cscope.out")
    cs add cscope.out
endif
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>S :cs find t struct <C-R>=expand("<cword>")<CR> {<CR>
