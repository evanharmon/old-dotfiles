# Dotfiles Configuration

My dotfiles configuration uses a bare git repo. This allows the user home
directory to keep files in their respective locations without the need for
linking.

With this power comes responsibility. NEVER BLANKET ADD aka `dotfiles add .`

# Setup
open terminal
```console
$ cd $HOME
```

## GIT Repo / ZSH
`$ git init --bare $HOME/.dotfiles`
If prompted to, install xcode developer tools

```console
$ alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
$ dotfiles config --local status.showUntrackedFiles no
$ dotfiles remote add origin https://github.com/evanharmon/dotfiles.git
$ dotfiles pull origin master
```

## Install Base
Sudo password will be requested as user input several times
```console
$ chmod -R a+x ./install/
$ ./install/base.sh
```

## Install General Tools
```console
$ ./install/cli-tools.sh
```
Close and re-open the shell

## Install Editors
Neovim setup relies on pyenv setup from `install/cli-tools.sh`
pyenv virtual environments and python versions are installed with this script
```console
$ ./install/editors.sh
```
After installing Neovim, open and run the following commands
```console
:UpdateRemotePlugins
:call dein#install()
```

## Install Cloud Tools
```console
$ ./install/fluffy-clouds.sh
```
Close and re-open the shell

## Install Language Specific Tools
```console
$ ./install/javascript.sh
$ ./install/golang.sh
```

## Install Apps
```console
$ ./install/apps.sh
```

## Setup iTerm
### AWS Git https git credentials required
In the `General` tab of iTerm preferences, check the box labelled
`load preferences from a custom folder or URL` and browse for the folder
`$HOME/iterm2`
Check the box below it marked `Save changes to folder when iTerm2 quits`.
Restart iTerm
