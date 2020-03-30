# ==================================== #
# Exports
# ==================================== #

export HOMEBREW_GITHUB_API_TOKEN=1cf81cac8be33d1727af36a67c506ac5842f595f

# This fixes the warning I got from pip3 when installing awscli
export PATH=$PATH:$HOME/Library/Python/3.7/bin:$HOME/Library/Python/2.7/bin

# This includes openvpn binary
export PATH=$PATH:/usr/local/Cellar/openvpn/2.4.7/sbin

# This fixes the errors I got from perl when using the Ack plugin in vim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Export GOPATH
export GOPATH=$HOME/go

# Remove thread safety
# http://sealiesoftware.com/blog/archive/2017/6/5/Objective-C_and_fork_in_macOS_1013.html
# Some scripting languages use fork() without exec() as a substitute for threads.
# Python's multiprocessing module is one example. The OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
# environment variable described above may temporarily get your scripts running again.
#OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# ==================================== #
