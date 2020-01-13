#use source , to setup with this file :souradch@gmail.com
MYHOME=$HOME
sudo apt update
sudo apt upgrade
sudo apt install build-essential python python3 ipython ipython3 python-pip \
 python3-pip vim cscope git tmux zsh curl
sudo apt install python3-venv
cd $MYHOME
python3 -m venv myvenv
if [ -e .gitconfig ]
then
    cp -f .gitconfig $MYHOME/
fi
if [ -e .vimrc ]
then
    cp -f .vimrc $MYHOME/
fi
if [ -e .tmux.config ]
then
    cp -f .tmux.config $MYHOME/
fi
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo chsh -s /usr/bin/zsh
if [ -e .zshrc ]
then
    cp -f .zshrc $MYHOME/
fi
