#!/bin/bash

# author: Ioannis Petrousov
# email: petrousov@gmail.com

# This is a bootstrap script for managing mydot.
# Options:
#	- install and configure neovim
#	- install and configure tmux
#	- install and configure zsh
#	- install and configure oh-my-zsh
# All options are split up into functions.
# All options perform a backup of existing confirm before applying new one.
# Backup config is stored in $BACKUP_CONFIG_DIRECTORY


### Variables
BACKUP_CONFIG_DIRECTORY="$HOME/.config_backup"


### Functions

# Enable DEBUG if $1 == "DEBUG"
function enable_debug() {
	if [[ $1 == "DEBUG" ]]
	then
		echo "Debug enabled"
		set -x
	fi
}

# Clone mydot
function clone_mydot_into_home() {
	echo "Cloning mydot into $HOME/.mydot"
	git clone --bare git@github.com:gpetrousov/mydot.git $HOME/.mydot
}

# Add mydot alias to your .bashrc
function setup_mydot_aliases() {
	echo "alias mydot='/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME'" >> .bashrc
	echo "alias vim='nvim'" >> .bashrc
	source $HOME/.bashrc
	# Don't show untracked items
	mydot config status.showUntrackedFiles no
}

function apply_config_from_upstream() {
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

# Setup git-dir(repo path) and work-tree(tree path)
function setup_mydot_command {
	/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME
}

# Update apt cache
function update_apt_cache() {
	sudo apt-get update
}

# Install xclip and xsel utils (copy/past from clipboard)
function install_clipboard_utils() {
	sudo apt-get -y install xclip xsel
}

# Install ZSH
function install_zsh() {
	sudo apt-get -y install zsh
}

# Install TMUX
function install_tmux() {
	sudo apt-get -y install tmux
}

# Apply TMUX config from upstream
function apply_upstream_tmux_config() {

}


### Main process

clone_mydot_into_home
setup_mydot_aliases

# Create a menu with packages to install.
# Installation process:
# 	1. check if package is installed
# 	2. it if is, take backup of existing config
# 	3. apply upstream config
#	git checkout HEAD <filename>


#apply_config_from_upstream
#
#
#
## Upgrade to oh-my-zsh
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
#
## Change shell to zsh
#chsh -s $(which zsh)
#
#
#
## Install and configure tpm
#git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
#export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins/
#$HOME/.tmux/plugins/tpm/bin/install_plugins
#
## Install fresh neovim plugins using Plug
#nvim -u $HOME/.config/nvim/plug.vim -c "PlugInstall --sync" -c "qa"
#
#echo "#===================COMPLETED=======================#"
#
#
## Disable DEBUG on exit
#function disable_debug() {
#	if [[ $1 == "DEBUG" ]]
#	then
#		set +x
#		echo "Debug disabled"
#	fi
#}
