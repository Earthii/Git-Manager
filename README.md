# Git-Manager
Git manager is a bash script that aims to help developers manage their git repositories and multiple clones of the same repositories.
Sometimes, developers need to spin multiple instances of the same project. So instead of managing multiple repositories manually, Git Manager wants to do it for you!

## Commands
gitm clone <url>    :  clone a repo  
gitm ls             : Display all git repos  
gitm ls <repo_name> : Display all copies of a repo  
  
## Want to implement
gitm <repo_name> <repo_num> exec "string command"  execute the command in the directory

## improvements
* Have the gitManagerRootDir be dynamic  
* Have the script installable into /usr/bin
* Check that Dirs are git repos by checking .git files
* Display in table format
* Auto-completion
