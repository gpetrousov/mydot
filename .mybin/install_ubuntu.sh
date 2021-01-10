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

# neovim - plugin
echo "Installing neovim plugins using Plug"
nvim -u $HOME/.config/nvim/plug.vim -c "PlugInstall --sync" -c "qa"


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
chsh -s $(which zsh)



# Install xclip and xsel utils (copy/past from clipboard)
echo ""
echo ""
echo "---------------------xclip xsel---------------------"
echo ""
echo ""
echo "installing xclip and xsel plugins"
sudo apt-get -y install xclip xsel 1>/dev/null


# Disable DEBUG on exit
if [[ $1 == "DEBUG" ]]
then
	set +x
	echo "Debug disabled"
fi

