## Commands
`git pull` - Pull latest code from git  
`git checkout -b onelove` - Create branch    
`git checkout onelove` - Change branch   
`git status` - Check difference between git branch and local files  
`git add .` - Adds all files in directory to be commited  
`git add jah.sh` - Adds specific file to be commited  
`git push -f origin branch_name ` - Force git push  

## Setting up a new git repo
```
git init .
git add init.vim
git commit -m "First step towards neovim"
git remote add origin git@github.com:Infinitetutts/dotfiles.git
git push origin master
```
