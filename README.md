# mydot - a personal dotfile collection

Export your dotfiles safely with just 4 commands.

```
git init --bare $HOME/.mydot
alias mydot='/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME'
mydot config --local status.showUntrackedFiles no
echo "alias mydot='/usr/bin/git --git-dir=$HOME/.mydot/ --work-tree=$HOME'" >> $HOME/.bashrc
```

Now you should be able to add and commit the files you want to track.

```
mydot add $HOME/.vimrc
mydot commit -m "Added my awesome vimrc config"
mydot push
```

### Showcase

![Look showcase](.showcase/img1 "Preview of TMUX, nvim")


### File structure

- github: a place to clone github projects
- .mybin directory contains OS specific bootstrap scripts
- .showcase: contains images showcasing the look

### Inspiration

A list of non-voluntary contributors.

- https://news.ycombinator.com/item?id=11070797
A simple way to export your dotfiles safely

- https://www.atlassian.com/git/tutorials/dotfiles
An expanded tutorial for the above method

- https://itnext.io/setup-git-with-multiple-configs-9b4111d6928c
A really cool solution to maintain multiple .gitconfig files

- https://zserge.com/posts/tmux/
A faster way of switching between panes and windows

- https://gist.github.com/william8th/faf23d311fc842be698a1d80737d9631
Opens new windows and panes in current path

## Installing

It's a bad practise to import the whole config into your system.
My suggestion is to try it in a safe environment which you can scrap later, say docker.
Only keep  the pieces of the config that you might actually find useful.

- Just feed the bootstrap script into bash and witness magic

#### Example: On a new Mint system

0. Install wget and git
1. Run

```
wget <github URL/mybin/install_X.sh>
/bin/bash install_X.s
```

#### Debugging

To debug execute the script with the 'DEBUG' option.

```
bash install_ubuntu.sh DEBUG
```

## Tutorials

#### Adding multiple github accounts
 
 - create `.ssh/config`

 ```
 # Personal github account
Host github_personal
   HostName github.com
   User git
   IdentityFile ~/.ssh/ssh_key_personal

# Work github account
Host github_work
   HostName github.com
   User git
   IdentityFile ~/.ssh/ssh_key_work
 ```

 - create separate dirs for 'personal' and 'work' development.

 ```
 mkdir $HOME/github_{personal,work}
 ```

 - add the corresponding `.gitconfig` files into each directory

 ```
 # $HOME/github_personal
 [user]
	name = gpetrousov
	email = petrousov@gmail.com

 # $HOME/github_work
 [user]
	name = tstark
	email = tony.stark@starkindustries.com
```

- create central `.gitconfig` file to rule them all

```
# This is Git's per-user configuration file.
[core]
	editor = vim

[alias]
	s = status
	d = diff
	a = add

# Specific config for personal github repos
[includeIf "gitdir:~/github_personal/"]
	path = ~/github_personal/.gitconfig

# Specific config for personal github repos
[includeIf "gitdir:~/github_work/"]
	path = ~/github_work/.gitconfig
```

- fix local repo remotes to reflect the corresponding config in `.ssh/config`

```
# For personal remotes
cd $HOME/github_personal/personal_repo
git remote set-url origin git@github_personal:gpetrousov/personal_repo.git

# For work remotes
cd $HOME/github_work/work_repo
git remote set-url origin git@github_work:tstark/personal_repo.git
```

** References **
1. https://www.freecodecamp.org/news/manage-multiple-github-accounts-the-ssh-way-2dadc30ccaca/
2. https://stackoverflow.com/questions/7927750/specify-an-ssh-key-for-git-push-for-a-given-domain

