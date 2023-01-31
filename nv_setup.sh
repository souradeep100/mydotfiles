curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
if [ $? -ne 0 ]
then
	./nvim.appimage --appimage-extract
	./squashfs-root/AppRun --version
	sudo mv squashfs-root /
	sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
fi

# Optional: exposing nvim globally.
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo update-alternatives --install $(which vim) vim $(which nvim) 10
sudo update-alternatives --config vim
mkdir -p ~/.config/nvim
if [[ -f ./init.vim ]]
then
	cp init.vim  ~/.config/nvim/
fi
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt update
sudo apt install -y nodejs
# To understand coc.nvim https://github.com/neoclide/coc.nvim/wiki/Language-servers
# run the following from vim command prompt , escape then : to get the vim command prompt
#CocInstall coc-clangd
#CocCommand clangd.install
