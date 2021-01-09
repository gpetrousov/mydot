#!/bin/bash

# author: Ioannis Petrousov
# email: petrousov@gmail.com

# This is a bootstrap script for managing mydot.
# Backup config is stored in $BACKUP_CONFIG_DIRECTORY

### Variables
BACKUP_CONFIG_DIRECTORY="$HOME/.config_backup"


### Functions

# Enable DEBUG if $1 == "DEBUG"
if [[ $1 == "DEBUG" ]]
then
	echo "Debug enabled"
	set -x
fi


# Clone mydot
function clone_mydot_into_home() {
	if [ ! -d "$HOME/.mydot" ]
	then
		echo "Cloning mydot into $HOME/.mydot"
		git clone --bare git@github.com:gpetrousov/mydot.git $HOME/.mydot
	else
		echo "mydot already cloned"
	fi
}

# Define base mydot command
function mydot() {
	echo "$(/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME $@)"
}

# Add mydot alias to your .bashrc
function setup_mydot_aliases() {
	echo "alias mydot='/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME'" >> .bashrc
	echo "alias vim='nvim'" >> .bashrc
	# Don't show untracked items
	mydot config status.showUntrackedFiles no
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

# Apply ZSH config from upstream
function apply_upstream_zsh_config() {
	zsh_conf_file=mydot status --porcelain | grep zsh | sed s/^...//
	mydot checkout $zsh_conf_file
}

# Install TMUX
function install_tmux() {
	sudo apt-get -y install tmux
}

# Apply TMUX config from upstream
function apply_upstream_tmux_config() {
	tmux_conf_file=mydot status --porcelain | grep tmux | sed s/^...//
	mydot checkout $tmux_conf_file
}

# Install neovim
function install_neovim() {
	sudo apt-get -y install neovim
}

# Apply neovim config from upstream
function apply_upstream_neovim_config() {
	neovim_conf_file=mydot status --porcelain | grep neovim | sed s/^...//
	mydot checkout $neovim_conf_file
}

### Main process

clone_mydot_into_home
setup_mydot_aliases

select main_menu_choice in "Install packages" "Backup and apply all config from upstream" "Quit";
do
	case $main_menu_choice in
		"Install packages")
			select install_package_choice in "tmux" "neovim" "ZSH" "oh-my-zsh" "Quit";
			do
				case $install_package_choice in
					"tmux")
						install_tmux
						apply_upstream_tmux_config
						;;
					"neovim")
						install_neovim
						apply_upstream_neovim_config
						;;
					"ZSH")
						install_zsh
						apply_upstream_zsh_config
						;;
					"oh-my-zsh")
						install_oh_my_zsh
						;;
					"Quit")
						echo "Exiting"
						exit 0
						;;
				esac
			done
			;;
		"Backup and apply all config from upstream")
			backup_and_apply_all_config_from_upstream
			;;
		"Quit")
			echo "Exiting"
			exit 0
			;;
	esac
done


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

# Disable DEBUG on exit
if [[ $1 == "DEBUG" ]]
then
	set +x
	echo "Debug disabled"
fi
