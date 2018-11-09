#!/bin/bash

set -xe

# EXPORTS
export PATH="/Users/evan/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if ! brew list editorconfig; then
    brew install editorconfig
fi

if ! [ -x "$(command -v yamllint)" ]; then
	brew install yamllint
fi

if [ ! -L $HOME/.pyenv/versions/neovim2 ]; then
    pyenv install --skip-existing 2.7.11
    pyenv virtualenv 2.7.11 neovim2
    pyenv activate neovim2
    pip install --upgrade pip
    pip install neovim
fi

if [ ! -L $HOME/.pyenv/versions/neovim3 ]; then
    pyenv install --skip-existing 3.5.5
    pyenv virtualenv 3.5.5 neovim3
    pyenv activate neovim3
    pip install --upgrade pip
    pip install neovim
fi

if ! [ -x "$(gem list neovim -i)" ]; then
    gem install neovim --user-install
fi

if ! [ -x "$(command -v nvim)" ]; then
    brew tap neovim/neovim
    brew install --HEAD neovim
fi

if [ ! -d $HOME/.cache/dein ]; then
    mkdir $HOME/.cache/dein
    curl \
        https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh >\
        installer.sh
    sh installer.sh $HOME/.cache/dein
    rm installer.sh
fi

if ! [ -f $HOME/bin/tflint ];then
    FNAME='tflint_darwin_amd64.zip'
    curl -LO $HOME/.cache/$FNAME \
        "https://github.com/wata727/tflint/releases/download/v0.7.2/$FNAME"
    unzip $HOME/.cache/$FNAME -d $HOME/bin
fi

unset FNAME
