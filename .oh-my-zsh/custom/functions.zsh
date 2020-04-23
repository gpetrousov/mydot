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

# ==================================== #

