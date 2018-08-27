#!/bin/bash

set -xe
# HOMEBREW STAR RUNNER
if ! which brew; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! [[ $SHELL =~ .*zsh.* ]]; then
	brew install zsh
	echo "Configuring zsh as default shell"
	chsh -s /bin/zsh
fi

if [ ! -f $HOME/.zplug/run.sh ]; then
	echo "installing zplug, a plugin manager for zsh - http://zplug.sh"
	git clone https://github.com/zplug/zplug ~/.zplug

fi

if ! which python3; then
	brew install python3 reattach-to-user-namespace
else
	echo "python 3 already installed"
fi

if ! which nvim; then
	brew tap neovim/neovim
	brew install --HEAD neovim
else 
	echo "neovim already installed"
fi

brew tap caskroom/cask
if brew cask ls --versions iterm2 > /dev/null; then
	echo "iterm2 already installed"
else
	brew cask install iterm2

fi

if ! which fd; then
	echo "fd already installed"
else
	brew install fd
fi

if ! which fzf; then
	echo "fzf already installed"
else
	brew install fzf
fi

if [ ! -f $HOME/.config/hss-fonts/README.md ]; then
	echo "installing fonts"
	git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/hss-fonts $HOME/.config/hss-fonts
	cp $HOME/.config/hss-fonts/*.otf $HOME/Library/Fonts/
fi

if git config --global user.name != "Evan Harmon"; then
	git config --global user.name "Evan Harmon"
fi

if git config --global user.email != "evan.p.harmon@gmail.com"; then
	git config --global user.email "evan.p.harmon@gmail.com"
fi
