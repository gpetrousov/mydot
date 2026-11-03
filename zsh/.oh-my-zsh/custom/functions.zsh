# ==================================== #
# Functions
# ==================================== #

# Colorized man pages, from:
# http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
man() {
        env \
                LESS_TERMCAP_md=$(printf "\e[1;36m") \
                LESS_TERMCAP_me=$(printf "\e[0m") \
                LESS_TERMCAP_se=$(printf "\e[0m") \
                LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
                LESS_TERMCAP_ue=$(printf "\e[0m") \
                LESS_TERMCAP_us=$(printf "\e[1;32m") \
                man "$@"
}

# Shrug if you don't know
shrug() { echo "¯\_(ツ)_/¯"; }

# What an alias does?
whichfunc() {
        whence -v $1
        type -a $1
}

# Squash commits on feature branch. Always forget that.
git_squash() {
		git rebase -i master
}

# List tmux keys for copy mode
tmux_copy_keys() {
		tmux list-keys | grep -- '-T copy-mode-vi'
}

# Remove USB drive
usb_safe_remove() {
    udisksctl power-off -b /dev/sda1
}

# Create standard Terraform structure
tfstruct() {
  touch {provider.tf,variables.tf,outputs.tf,main.tf,values.tfvars}
}
