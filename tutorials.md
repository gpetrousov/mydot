## Tutorials
Useful tutorials I found here and there.

### Adding multiple github accounts

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

**References**
1. https://www.freecodecamp.org/news/manage-multiple-github-accounts-the-ssh-way-2dadc30ccaca/
2. https://stackoverflow.com/questions/7927750/specify-an-ssh-key-for-git-push-for-a-given-domain

