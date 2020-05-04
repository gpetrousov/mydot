# mydot - a personal dotfile collection


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

## Installing

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

