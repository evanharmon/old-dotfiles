# Dotfiles Configuration

My dotfiles configuration uses a bare git repo. This allows the user home
directory to keep files in their respective locations without the need for
linking.

With this power comes responsibility. NEVER BLANKET ADD aka `dotfiles add .`

# Setup
open terminal
`$ cd $HOME`

## GIT repo / ZSH
`$ git init --bare $HOME/.dotfiles`
If prompted to, install xcode developer tools

```
$ alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
$ dotfiles config --local status.showUntrackedFiles no
$ dotfiles remote add origin https://github.com/evanharmon/dotfiles.git
$ dotfiles pull origin master
```

## Install Base
### Sudo password will be requested as user input several times
```
$ chmod -R a+x ./install/
$ ./install/brew.sh
```

## Install Tools
```
$ ./install/cli-tools.sh
```
Close and re-open the shell

## Install Editors
```
$ ./install/editors.sh
```
After installing Neovim, open and run the following commands
```
:UpdateRemotePlugins
:call dein#install()
```

## Setup iTerm
### AWS Git https git credentials required
In the `General` tab of iTerm preferences, check the box labelled
`load preferences from a custom folder or URL` and browse for the folder
`$HOME/iterm2`
Check the box below it marked `Save changes to folder when iTerm2 quits`.
Restart iTerm
