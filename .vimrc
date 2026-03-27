call plug#begin()
 Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
 Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
 Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'junegunn/fzf.vim'
call plug#end()
syntax on
set hlsearch
colorscheme PaperColor
set splitright
set cursorline
set number
set cc=100
filetype plugin indent on
set listchars=tab:\|_,trail:#,precedes:#,extends:#
set pastetoggle=<f5>
function! SetLinuxKernelPath()
    " 1. Find the potential root
    let l:kernel_root = finddir('.git/..', expand('%:p:h') . ';')

    " 2. Verify it's the Linux Kernel
    if l:kernel_root != '' && filereadable(l:kernel_root . '/MAINTAINERS')
        " Base includes
        execute 'setlocal path+=' . l:kernel_root . '/include'
        execute 'setlocal path+=' . l:kernel_root . '/include/uapi'

        " 3. Add ARM64 headers if the directory exists
        let l:arm64_path = l:kernel_root . '/arch/arm64/include'
        if isdirectory(l:arm64_path)
            execute 'setlocal path+=' . l:arm64_path
            execute 'setlocal path+=' . l:arm64_path . '/uapi'
        endif

        " 4. Add x86 headers if the directory exists (for cross-dev)
        let l:x86_path = l:kernel_root . '/arch/x86/include'
        if isdirectory(l:x86_path)
            execute 'setlocal path+=' . l:x86_path
            execute 'setlocal path+=' . l:x86_path . '/uapi'
        endif

        " Set suffixes to help 'gf' find files without extensions
        setlocal suffixesadd+=.h,.c
    endif
endfunction
nnoremap <leader>sp :call SetLinuxKernelPath()<CR>

set cscopeverbose
" Find symbol
set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-

function! MakeCscope()
    let l:root = finddir('.git/..', expand('%:p:h') . ';')
    if l:root == ''
        let l:root = findfile('MAINTAINERS', expand('%:p:h') . ';')
        let l:root = fnamemodify(l:root, ':h')
    endif

    if l:root == '' || l:root == '.'
        let l:root = getcwd()
    endif

    echo "Cleaning old database and generating new list..."

    " Remove old files to prevent 'cannot find file' errors from stale data
    call system('rm -f ' . l:root . '/cscope.out ' . l:root . '/cscope.files ' . l:root . '/cscope.in.out ' . l:root . '/cscope.po.out')

    " Updated Find:
    " 1. -L ensures we follow valid symlinks (common in kernel headers)
    " 2. -type f ensures we ONLY grab actual files
    " 3. We prune Documentation, scripts, AND tools (since your errors show selftests failing)
    let l:exclude = '-path "'.l:root.'/Documentation" -prune -o -path "'.l:root.'/scripts" -prune -o -path "'.l:root.'/tools" -prune -o'
    let l:find_cmd = 'find -L ' . l:root . ' ' . l:exclude . ' -name "*.[chS]" -type f -print > ' . l:root . '/cscope.files'

    execute 'silent !' . l:find_cmd

    " Ensure the file is written to disk
    sleep 500m

    echo "Building Cscope database (this may take a minute)..."
    " Use -k (kernel mode) which tells cscope not to look in /usr/include
    let l:csc_cmd = 'cscope -b -R  -k -i ' . l:root . '/cscope.files -f ' . l:root . '/cscope.out'

    execute 'silent !' . l:csc_cmd

    if filereadable(l:root . "/cscope.out")
        execute 'cs kill -1'
        execute 'cs add ' . l:root . '/cscope.out ' . l:root
    endif

    redraw!
    echo "Done! Index created (excluding Documentation, scripts, tools)."
endfunction

" Key mapping
nnoremap <leader>cs :call MakeCscope()<CR>

" Define key mappings for cscope-like functions
" Find symbol
" --- CSCOPE AUTO-LOADER ---
" Automatically find and add cscope.out when opening a file
function! LoadCscope()
    let l:db = findfile("cscope.out", expand("%:p:h") . ";")
    if filereadable(l:db)
        let l:db_dir = fnamemodify(l:db, ":h")
        " Avoid adding the same DB multiple times
        set nocscopeverbose
        execute "cs add " . l:db . " " . l:db_dir
        set cscopeverbose
    endif
endfunction

augroup CscopeAutoLoad
    autocmd!
    autocmd BufEnter *.[chS] call LoadCscope()
augroup END

augroup CscopeQuickfixAutoOpen
    autocmd!
    autocmd QuickFixCmdPost [^l]* copen 10
augroup END

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

nnoremap <Leader>ft :Tags <C-R><C-W><CR>
