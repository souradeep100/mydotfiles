sudo apt update
sudo apt upgrade
sudo apt install build-essential python python3 ipython ipython3 python-pip \
 python3-pip vim cscope git tmux zsh curl
sudo apt install python3-venv
cd $HOME
python3 -m venv myvenv
if [ -e .gitconfig ]
then
    cp .gitconfig $HOME/
fi
if [ -e .vimrc ]
then
    cp .vimrc $HOME/
fi
if [ -e .tmux.config ]
then
    cp .tmux.config $HOME/
fi
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo chsh -s /usr/bin/zsh
if [ -e .zshrc ]
then
    cp .zshrc $HOME/
fi
source $HOME/myvenv/bin/activate
