#!/bin/bash

set -xe

# EXPORTS
export PATH="/Users/evan/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if ! brew list editorconfig; then
    brew install editorconfig
fi

if [ ! -L $HOME/.pyenv/versions/neovim2 ]; then
    pyenv install --skip-existing 2.7.11
    pyenv virtualenv 2.7.11 neovim2
    pyenv activate neovim2
    pip install --upgrade pip
    pip install neovim
fi

if [ ! -L $HOME/.pyenv/versions/neovim3 ]; then
    pyenv install --skip-existing 3.7.0
    pyenv virtualenv 3.7.0 neovim3
    pyenv activate neovim3
    pip install --upgrade pip
    pip install neovim
fi

if ! which nvim; then
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
