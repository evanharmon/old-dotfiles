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
fi

if ! which nvim; then
	echo "neovim already installed"
fi

brew tap caskroom/cask
brew tap caskroom/fonts
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
