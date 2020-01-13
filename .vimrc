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
map <C-l> :!git log % > %.log<CR>:vsplit %.log<CR>
map <C-b> :!git blame % > %.blame<CR>:vsplit %.blame<CR>
map <C-g> :w<CR>:!git add %;git commit -m "commit" %<CR>
