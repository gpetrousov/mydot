#!/bin/bash

# author: Ioannis Petrousov
# email: petrousov@gmail.com

# This is a bootstrap script for managing mydot.
# Backup config is stored in $BACKUP_CONFIG_DIRECTORY


cd $HOME

# Enable DEBUG if $1 == "DEBUG"
# TODO: Use getopts
if [[ $1 == "DEBUG" ]]
then
	print_message "Debug enabled"
	set -x
fi

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT


## Variables
BACKUP_CONFIG_DIRECTORY="$HOME/.config_backup"
BASE_PACKAGES="tmux neovim zsh xclip xsel jq yq pyenv ranger kubectl alacritty"
AUR_PACKAGES="pyenv-virtualenv alacritty-colorscheme tmux-plugin-manager urlview"


## Functions

# Function to handle user interrupt
function ctrl_c() {
  print_message "Caught CTRL-C from user"
	exit 140
}

function backup_and_apply_all_config_from_upstream() {
	# Checkout the actual content from the bare repository to your $HOME
	# Create a backup of existing config if necessary
	mydot checkout
	if [ $? = 0 ]; then
			print_message "Checked out config.";
	else
			print_message "Backing up pre-existing dot files."
			mkdir BACKUP_CONFIG_DIRECTORY
			mydot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $BACKUP_CONFIG_DIRECTORY/{}
	fi;
	mydot checkout
}

function install_docker() {
		print_message "Preparing to install docker"
		print_message "Update cache"
		pacman -S docker
		sudo usermod -aG docker $USER
}

function install_terraform() {
		sudo pacman -S terraform
		print_message "Setting autocomplete for terraform commands"
		terraform -install-autocomplete
}

function print_message() {
  echo "$(date +%H-%M-%S-%N)-[ mydot ]:---> $@"
}

### 1. mydot

## 1.1 Fetch
print_message "Fetching mydot"
git clone --branch master --bare https://www.github.com/gpetrousov/mydot.git $HOME/.mydot

## 1.2 Install
print_message "Installing mydot"
shopt -s expand_aliases
echo "alias mydot='/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME'" >> $HOME/.bashrc
alias mydot='/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME'

## 1.3 Configure
print_message "Configuring mydot"
mydot config status.showUntrackedFiles no


## 2. Install base packages
print_message "Installing base packages"
sudo pacman -Syq
sudo pacman -Sq --needed $BASE_PACKAGES
sudo pamac build $AUR_PACKAGES


## 3. Install additional packages
print_message "Installing additional packages"

# 3.1 Dependencies for neovim plugins
curl -sL install-node.now.sh/lts | sudo bash

# 3.2 Install neovim plugins
print_message "Installing neovim plugins using Plug"
nvim -u $HOME/.config/nvim/plug.vim -c "PlugInstall --sync" -c "qa"

# 3.3 Install oh-my-ZSH
print_message "Installing oh-my-ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# 3.4 oh-my-zsh - additional plugins
print_message "Cloning oh-my-ZSH plugins"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# 3.5 tmux plugin manager
print_message "Cloning tmux-plugin-manager"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

## 4. Checkout dotfiles
print_message "Apply dotfiles"
mydot checkout HEAD .


## 5 Apply additional configuration
print_message "Aply additional configuration"

# 5.1 Switch default shell to oh-my-zsh
print_message "Enter root password to change default shell to ZSH"
chsh -s $(which zsh)


## 6 Finalize installation
print_message "mydot was successfully installed, congrats!"

# Disable DEBUG on exit
if [[ $1 == "DEBUG" ]]
then
	set +x
	print_message "Debug disabled"
fi

