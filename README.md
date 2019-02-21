# Git-Manager

Git manager is my personal bash script that aims to help developers manage their git repositories and multiple clones of the same repositories.
Sometimes, developers need to spin multiple instances of the same project. So instead of managing multiple repositories manually, Git Manager wants to do it for you!

## Commands

gitm **clone** <url> : clone a repo  
gitm **ls** : Display all git repos  
gitm **ls** <repo_name> : Display all copies of a repo  
gitm **checkout** <repo_name> <env_number> <branch_name> : will do a git checkout on that specific env  
gitm **dev** <repo_name> <env_number> : will execute `code .` on the proper repo  
gitm **pull** <repo_name> : will perform a pull on all copies of the repo

## To Install

1. `rename the variable gitRootManagerDir to the path you want` .
2. `create a dir at ~/User/<user>/bin` .
3. Add the following line to your `~/.profile` or `~/.zshrc` if you're using zshell.  
   `export PATH="$HOME/bin:$PATH"` .  
   `alias gitm="gitm.sh"` .

## command i want to implement

1. Automatically create a clone of a repo without the url  
   `gitm clone <repo_name>` .

## improvements todo

- Have the gitManagerRootDir be dynamic
- Have the script installable into /usr/bin
- Check that Dirs are git repos by checking .git files
- Display in table format
- Auto-completion
