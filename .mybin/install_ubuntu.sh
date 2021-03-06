#!/bin/bash

# author: Ioannis Petrousov
# email: petrousov@gmail.com

# This is a bootstrap script for managing mydot.
# Backup config is stored in $BACKUP_CONFIG_DIRECTORY

# Enable DEBUG if $1 == "DEBUG"
if [[ $1 == "DEBUG" ]]
then
	echo "Debug enabled"
	set -x
fi

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT



## Variables
BACKUP_CONFIG_DIRECTORY="$HOME/.config_backup"



## Functions

# Function to handle user interrupt
function ctrl_c() {
	echo ""
	echo ""
	echo ""
	echo "#=====-----=====#"
        echo "Caught CTRL-C from user"
	echo "Exiting"
	echo ""
	echo ""
	echo ""
	exit 9
}

# Define base mydot command
function mydot() {
	echo "$(/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME $@)"
}

function backup_and_apply_all_config_from_upstream() {
	# Checkout the actual content from the bare repository to your $HOME
	# Create a backup of existing config if necessary
	mydot checkout
	if [ $? = 0 ]; then
			echo "Checked out config.";
	else
			echo "Backing up pre-existing dot files."
			mkdir BACKUP_CONFIG_DIRECTORY
			mydot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $BACKUP_CONFIG_DIRECTORY/{}
	fi;
	mydot checkout
}

# Install docker
# I seem to roget the process of installing docker on Mint so here's a reminder.
# Reference: https://techviewleo.com/how-to-install-and-use-docker-in-linux-mint/
# Post installation: https://docs.docker.com/engine/install/linux-postinstall/
function install_docker_mint() {
		echo "Preparing to install docker on Mint"
		echo "Update apt cache"
		sudo apt-get update
		sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		# lsb_release does not contain teh Ubuntu base version, however os-release does
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
		sudo apt-get update
		sudo apt-get -y install docker-ce
		sudo usermod -aG docker $USER
		echo "=========================================================="
		echo "=========================================================="
		echo "Installation complete"
		echo "Restart your box for group membership to be re-evaluated."
		echo "=========================================================="
		echo "=========================================================="
}

# Install terraform on linux Mint
# Reference: https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started
function install_terraform_mint() {
		curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
		sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(cat /etc/os-release | grep UBUNTU_CODENAME | cut -d'=' -f 2) main" 
		sudo apt-get update && sudo apt-get install terraform
		echo "Setting autocomplete for terraform commands"
		terraform -install-autocomplete
		echo "Restart your shell"
}


## Main Run

# mydot
echo ""
echo ""
echo "---------------------MYDOT---------------------"
echo ""
echo ""
echo "Clone mydot"
if [ ! -d "$HOME/.mydot" ]
then
	echo "Cloning mydot into $HOME/.mydot"
	git clone --branch master --bare git@github.com:gpetrousov/mydot.git $HOME/.mydot 1>/dev/null
else
	echo "mydot already cloned"
fi

# Add mydot alias to your .bashrc
echo "Create mydot alias"
grep mydot=* $HOME/.bashrc 1>/dev/null
if [ $? -eq 0 ]
then
	echo "mydot alias already in $HOME/.bashrc"
else
	echo "Adding mydot alias to bashrc"
	echo "alias mydot='/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME'" >> $HOME/.bashrc
fi

# Don't show untracked items
echo "Configure mydot to not show untracked files"
mydot config status.showUntrackedFiles no


# Update APT cache
echo "Update APT cache"
sudo apt-get update 1>/dev/null


# TMUX
echo ""
echo ""
echo "---------------------TMUX---------------------"
echo ""
echo ""
echo "Installing tmux"
dpkg -l | grep tmux 1>/dev/null
if [ $? -eq 0 ]
then
	echo "Tmux already installed"
else
	echo "Installing tmux"
	sudo apt-get -y install tmux 1>/dev/null
fi

## TMUX - config
echo "Applying tmux config"
mydot status --porcelain | grep tmux
if [ $? -eq 0 ]
then
	echo "Applying tmux config from upstream"
	tmux_conf_file="$(mydot status --porcelain | grep tmux | sed s/^...//)"
	mydot checkout HEAD $tmux_conf_file
else
	echo "Tmux config already applied"
fi

## TMUX - TPM
echo "Installing tpm"

if [ -d $HOME/.tmux/plugins/tpm ]
then
	echo "TPM alraedy installed"
else
	echo "Cloning tpm"
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
	export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins/
	tmux source ~/.tmux.conf
	echo "Running tpm to install plugins"
	$HOME/.tmux/plugins/tpm/bin/install_plugins
fi

## TMUX - TPM plugins
tmux source ~/.tmux.conf
export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins/
echo "Running tpm to install plugins"
$HOME/.tmux/plugins/tpm/bin/install_plugins


# neovim
echo ""
echo ""
echo "---------------------neovim---------------------"
echo ""
echo ""
echo "Installing neovim"
dpkg -l | grep neovim 1>/dev/null
if [ $? -eq 0 ]
then
	echo "neovim already installed"
else
	echo "INstalling neovim"
	sudo apt-get -y install neovim 1>/dev/null
fi

# neovim - config
echo "Applying neovim config"
mydot status --porcelain | grep nvim
if [ $? -eq 0 ]
then
	echo "Applying neovim config from upstream"
	neovim_conf_file="$(mydot status --porcelain | grep nvim | sed s/^...//)"
	mydot checkout HEAD $neovim_conf_file
else
	echo "neovim config already applied"
fi

# neovim - plugins
echo "Installing neovim plugins using Plug"
nvim -u $HOME/.config/nvim/plug.vim -c "PlugInstall --sync" -c "qa"

# neovim - coc plugin dependency
echo "Installing neovim plugin dependencies"
echo "- neovim - coc : node"
echo "Installing node"
curl -sL install-node.now.sh/lts | sudo bash


# ZSH
echo ""
echo ""
echo "---------------------ZSH---------------------"
echo ""
echo ""
echo "Installing ZSH"
dpkg -l | grep zsh 1>/dev/null
if [ $? -eq 0 ]
then
	echo "ZSH already installed"
else
	echo "Installing ZSH"
	sudo apt-get -y install zsh
fi

# ZSH - config
echo "Applying ZSH config"
mydot status --porcelain | grep zsh
if [ $? -eq 0 ]
then
	echo "Applying ZSH config from upstream"
	zsh_conf_file="$(mydot status --porcelain | grep zsh | grep -v oh-my | sed s/^...//)"
	mydot checkout HEAD $zsh_conf_file
else
	echo "ZSH config already applied"
fi


# oh-my-zsh
echo ""
echo ""
echo "---------------------oh-my-zsh---------------------"
echo ""
echo ""
echo "Installing oh-my-zsh"
if [ -d $HOME/.oh-my-zsh ]
then
	echo "oh-my-zsh already installed"
else
	echo "Installing oh-my-zsh unattended"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# oh-my-zsh - config
mydot status --porcelain | grep oh-my-zsh
if [ $? -eq 0 ]
then
	echo "Applying oh-my-zsh config from upstream"
	omzsh_conf_file="$(mydot status --porcelain | grep zsh | sed s/^...//)"
	mydot checkout HEAD $omzsh_conf_file
else
	echo "oh-my-zsh config already present"
fi

# oh-my-zsh - default shell
echo "Enter root password to change default shell to ZSH"
chsh -s $(which zsh)



# Install xclip and xsel utils (copy/past from clipboard)
echo ""
echo ""
echo "---------------------xclip xsel---------------------"
echo ""
echo ""
echo "installing xclip and xsel plugins"
sudo apt-get -y install xclip xsel jq 1>/dev/null


# Disable DEBUG on exit
if [[ $1 == "DEBUG" ]]
then
	set +x
	echo "Debug disabled"
fi

