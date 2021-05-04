# ==================================== #
# Aliases
# ==================================== #
#
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Always use neovim
alias vim='nvim'

# Always use colordiff
alias diff="colordiff"

# Tracking for mydotfiles
alias mydot='/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME' >> $HOME/.zshrc

# Git status
alias gs='git status'

# # This might be useful when you're generating random passwords
# Reference: https://www.redhat.com/sysadmin/creating-gpg-keypairs
# Check system entropy
alias sys_entropy='cat /proc/sys/kernel/random/entropy_avail'

# List tmux keybindings for copy mode.
# https://blog.sanctum.geek.nz/vi-mode-in-tmux/#:~:text=tmux%20offers%20a%20set%20of,window%20in%20the%20tmux%20session.
# TODO Turn into a keybinding itself.
alias tmkeys='tmux list-keys -T copy-mode-vi'

# SteamLink
alias steamlink='flatpak run com.valvesoftware.SteamLink'

# cd to workdir
alias work='cd $HOME/gh_work'
# ==================================== #

