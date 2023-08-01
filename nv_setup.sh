#!/bin/bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

# Optional: exposing nvim globally.
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#sudo update-alternatives --install $(which vim) vim $(which nvim) 10
#sudo update-alternatives --config vim
set -x
if [[ -d $HOME/.config/nvim/ ]]
then
	echo "cont"
else
	mkdir -p ~/.config/nvim
fi
if [[ -f $HOME/.config/nvim/init.vim ]]
then
	cp init.vim  $HOME/.config/nvim/
else 
cat > $HOME/.config/nvim/init.vim <<EOL
set number
syntax on
set tabstop=4
set sw=4
filetype indent off
set nocindent
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
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
EOL
fi

curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt update
sudo apt install -y nodejs
# To understand coc.nvim https://github.com/neoclide/coc.nvim/wiki/Language-servers
# run the following from vim command prompt , escape then : to get the vim command prompt
# PlugInstall
# then restart vim again
#CocInstall coc-clangd
#CocCommand clangd.install

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
