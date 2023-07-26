set number
syntax on
set tabstop=4
set sw=4
filetype indent off
set nocindent
set relativenumber
if has("cscope")
        set csprg=/usr/bin/cscope
        set csto=0
        set cst
        " add any database in current directory
        if filereadable("cscope.out")
            silent cs add cscope.out
        " else add database pointed to by environment
        elseif $CSCOPE_DB != ""
            silent cs add $CSCOPE_DB
        endif
endif
call plug#begin()

Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
set encoding=UTF-8
call plug#end()
:colorscheme hybrid_material
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-a><C-t> :NERDTreeToggle<CR>
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use <c-space> to trigger completion
if has('nvim')
inoremap <silent><expr> <c-space> coc#refresh()
else
inoremap <silent><expr> <c-@> coc#refresh()
endif
