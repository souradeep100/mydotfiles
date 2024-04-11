#use source , to setup with this file :souradch@gmail.com
MYHOME=$HOME
BASE=$PWD
sudo apt update
sudo apt upgrade
sudo apt install build-essential python3  ipython3  \
 python3-pip vim cscope git tmux zsh curl -y
sudo apt install python3-venv -y
sudo apt install universal-ctags -y
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison dwarves cmake -y
cd $MYHOME

python3 -m venv myvenv
if [ ! -e ".gitconfig" ]
then
    cp -f $BASE/.gitconfig $MYHOME/
fi
if [ ! -e ".vimrc" ]
then
    cp -f $BASE/.vimrc $MYHOME/
fi
if [ ! -e ".tmux.conf" ]
then
    cp -f $BASE/.tmux.conf $MYHOME/
fi

sh -c "$(curl -esSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /usr/bin/zsh
if [ ! -e ".zshrc" ]
then
    cp -f $BASE/.zshrc $MYHOME/
fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

if [ ! -e "$MYHOME/.ssh/id_rsa.pub" ]
then
    ssh-keygen -t rsa -b 4096
fi
