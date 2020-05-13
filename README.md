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


### File structure

- github: a place to clone github projects
- .mybin: assistive scripts

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

- .mybin directory contains OS specific bootstrap scripts
- Just feed the bootstrap script into bash and witness magic

#### Example: On a new Ubuntu system

0. Install curl and git
1. Generate a SSH key-pair for Github access
2. If repo is private, add pub part to repo in github
3. Run

```
curl -Lks <github URL/mybin/install_X.sh> | /bin/bash
```

