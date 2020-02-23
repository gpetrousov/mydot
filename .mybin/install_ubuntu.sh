# Ioannis Petrousov
# petrousov@gmail.com

# This script will install mydot files on a fresh Ubuntu system.

# Clone the mydot project
git clone --bare git@github.com:gpetrousov/mydot.git $HOME/.mydot

function mydot {
		/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME $@
}

# Requirements
sudo apt-get update && sudo apt-get -y install\
		neovim\
		git\
		tmux\
		zsh\

# Upgrade to oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Change shell to zsh
chsh -s $(which zsh)

# Add the alias to your .bashrc
echo "alias mydot='/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME'" >> .bashrc
echo "alias vim='nvim'" >> .bashrc

# Checkout the actual content from the bare repository to your $HOME
# Create a backup of existing config if necessary
mydot checkout
if [ $? = 0 ]; then
		echo "Checked out config.";
else
		echo "Backing up pre-existing dot files."
		mkdir .config-backup
		mydot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
mydot checkout

# Don't show untracked items
mydot config status.showUntrackedFiles no

# Install and configure tpm
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins/
$HOME/.tmux/plugins/tpm/bin/install_plugins

# Install fresh neovim plugins using Plug
nvim -u $HOME/.config/nvim/plug.vim -c "PlugInstall --sync" -c "qa"

echo "#===================COMPLETED=======================#"

