# mydot - a personal dotfile collection


### Inspiration

- https://www.atlassian.com/git/tutorials/dotfiles
- https://news.ycombinator.com/item?id=11070797
- https://itnext.io/setup-git-with-multiple-configs-9b4111d6928c

## Installing

- .mybin directory contains OS specific bootstrap scripts.
- Just feed the bootstrap script into bash and witness magic

#### Example: On a new Ubuntu system

0. Install curl and git
1. Generate a SSH key-pair for Github access
2. If repo is private, add pub part to repo in github
3. Run

```
curl -Lks <github URL> | /bin/bash
```

