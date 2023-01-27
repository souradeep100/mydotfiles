sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo update-alternatives --install $(which vim) vim $(which nvim) 10
sudo update-alternatives --config vim
 mkdir -p ~/.config/nvim

curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt update
sudo apt install -y nodejs
#CocInstall coc-clangd
#CocCommand clangd.install
