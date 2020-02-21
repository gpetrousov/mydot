# Ioannis Petrousov
# petrousov@gmail.com

# This script will install mydot files on a fresh Ubuntu system.

# Requirements
sudo apt-get update && sudo apt-get -y install\
		neovim\
		git\

# Create mydot command
alias mydot='/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME'

# Clone the mydot project
git clone --bare git@github.com:gpetrousov/mydot.git $HOME/.mydot

# Checkout the actual content from the bare repository to your $HOME
`mydot checkout`

# Install fresh neovim plugins using Plug
alias vim='nvim'
vim -E .config/nvim/plug.vim +PlugInstall +qall

