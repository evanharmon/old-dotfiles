#!/bin/bash

set -xe

# HOMEBREW STAR RUNNER
if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# ZSH
if ! [[ $SHELL =~ .*zsh.* ]]; then
    brew install zsh
    echo "Configuring zsh as default shell"
    chsh -s /bin/zsh
fi

if ! git --version; then
    xcode-select --install
fi

if [ ! -f $HOME/.zplug/run.sh ]; then
    echo "installing zplug, a plugin manager for zsh - http://zplug.sh"
    git clone https://github.com/zplug/zplug ~/.zplug
fi

if [ ! -d /Applications/iTerm.app ]; then
  brew tap caskroom/cask
  brew cask install iterm2
fi

if [ ! -f $HOME/.cache/hss-fonts/README.md ]; then
    echo "installing fonts"
    git clone \
        https://git-codecommit.us-east-1.amazonaws.com/v1/repos/hss-fonts \
        $HOME/.cache/hss-fonts
    cp $HOME/.cache/hss-fonts/*.otf $HOME/Library/Fonts/
fi

if git config --global user.name != "Evan Harmon"; then
    git config --global user.name "Evan Harmon"
fi

if git config --global user.email != "evan.p.harmon@gmail.com"; then
    git config --global user.email "evan.p.harmon@gmail.com"
fi
