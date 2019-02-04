#!/bin/bash

set -xe

# EXPORTS
export PATH="/Users/evan/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if [[ ! -d $HOME/.local ]]; then
	mkdir $HOME/.local
fi

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

if [ ! -d $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if ! [ -f $HOME/bin/tflint ];then
    FNAME='tflint_darwin_amd64.zip'
    curl -LO $HOME/.cache/$FNAME \
        "https://github.com/wata727/tflint/releases/download/v0.7.2/$FNAME"
    unzip $HOME/.cache/$FNAME -d $HOME/bin
fi

unset FNAME
