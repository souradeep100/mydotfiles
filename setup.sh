sudo apt update
sudo apt upgrade
sudo apt install build-essential python python3 ipython ipython3 python-pip \
 python3-pip vim cscope git tmux 
sudo apt install python3-venv
cd $HOME
python3 -m venv myvenv
source $HOME/myvenv/bin/activate
