# ==================================== #
# Aliases
# ==================================== #
#
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim='nvim'
#
# Mirabeau Apache
alias prdweb1='ssh -i ~/.ssh/maxeda_vpn ipetrousov@10.227.136.10'
# Maxeda apache (Apache is no more;Long live webedge)
#alias httpd01prd01='ssh -i ~/.ssh/maxeda_vpn ipetrousov@172.31.131.113'

# Always use colordiff
alias diff="colordiff"

# Maxeda AWS prodnotprod account
alias awsmax-prodnotprod='unset AWS_PROFILE; aws-google-auth -p awsmax-prodnotprod ; export AWS_PROFILE=awsmax-prodnotprod'

# Tracking for mydotfiles
alias mydot='/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME' >> $HOME/.zshrc

# ==================================== #

