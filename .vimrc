set number
set background=dark
set hlsearch
set tabstop=4
set expandtab
set sw=4
set ruler
set backup
set backupdir=/home/souradeep/Dropbox/vim_backup/.backup/
set directory=/home/souradeep/Dropbox/vim_backup/.swap/
map <F5> :w<CR>:!git add %;git commit -m "commit" %<CR>
map <F3> :!git blame % > %.blame<CR>:vsplit %.blame<CR>
map <F4> :!git log --abbrev-commit % > %.log<CR>:vsplit %.log<CR>
map <F2> :w orig.%<CR>
