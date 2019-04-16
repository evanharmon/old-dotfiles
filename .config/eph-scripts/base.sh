#!/bin/bash

set -xe

if [[ "$(uname -a)" != Darwin* ]]; then
    echo "This script only supports Mac"
    exit 1
fi

# HOMEBREW STAR RUNNER
if ! [ -x "$(command -v brew)" ]; then
    /usr/bin/ruby -e \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Will Prompt For SUDO
brew install bash
sudo -- sh -c "echo '/usr/local/bin/bash' >> /etc/shells"

# ZSH
if ! [[ $SHELL =~ .*zsh.* ]]; then
    brew install zsh
    echo "Configuring zsh as default shell"
    chsh -s /bin/zsh
fi

if ! git --version; then
    xcode-select --install
fi

if ! [ -d $HOME/.zplug ]; then
    echo "installing zplug, a plugin manager for zsh - http://zplug.sh"
    git clone https://github.com/zplug/zplug $HOME/.zplug
fi

if ! [ -d $HOME/zsh-syntax-highlighting ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
fi

if ! [ -d /Applications/iTerm.app ]; then
  brew tap caskroom/cask
  brew cask install iterm2
fi

if git config --global user.name != "Evan Harmon"; then
    git config --global user.name "Evan Harmon"
fi

if git config --global user.email != "evan.p.harmon@gmail.com"; then
    git config --global user.email "evan.p.harmon@gmail.com"
fi
