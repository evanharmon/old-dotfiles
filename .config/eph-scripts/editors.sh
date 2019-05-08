#!/bin/bash

set -xe

# Should match $HOME/.zshrc in dotfiles
PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
PYENV2_NAME="${PYENV2_NAME:-v2}"
PYENV3_NAME="${PYENV3_NAME:-v3}"
PYENV_VERSION="${PYENV_VERSION:-2.7.14}"
PYENV_VERSION3="${PYENV_VERSION3:-3.5.5}"

if [[ "$(uname -a)" != Darwin* ]]; then
    echo "This script only supports Mac"
    exit 1
fi

# EXPORTS
export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if [[ ! -d $HOME/.local ]]; then
	mkdir $HOME/.local
fi

if ! brew list editorconfig; then
    brew install editorconfig
fi

if [ ! -L $PYENV_ROOT/versions/$PYENV2_NAME ]; then
    pyenv install --skip-existing $PYENV_VERSION
    pyenv virtualenv $PYENV_VERSION $PYENV2_NAME
    pyenv activate $PYENV2_NAME
    pip install --upgrade pip
    pip install neovim pynvim
fi

if [ ! -L $PYENV_ROOT/versions/$PYENV3_NAME ]; then
    pyenv install --skip-existing $PYENV_VERSION3
    pyenv virtualenv $PYENV_VERSION3 $PYENV3_NAME
    pyenv activate $PYENV3_NAME
    pip install --upgrade pip
    pip install neovim pynvim
fi

if ! [ -x "$(gem list neovim -i)" ]; then
    gem install neovim --user-install
fi

# Always Grab Nightly
if ! [ -x "$(command -v nvim)" ]; then
    FNAME='nvim-macos.tar.gz'
    curl -Lo $HOME/.cache/$FNAME "https://github.com/neovim/neovim/releases/download/nightly/$FNAME"
    tar xzvf $HOME/.cache/$FNAME -C $HOME
fi

# Always Grab Latest Version
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if ! [ -f $HOME/bin/tflint ];then
    FNAME='tflint_darwin_amd64.zip'
    curl -LO $HOME/.cache/$FNAME \
        "https://github.com/wata727/tflint/releases/download/v0.7.2/$FNAME"
    unzip $HOME/.cache/$FNAME -d $HOME/bin
fi

# clangd install
if ! brew list llvm; then
    brew install llvm
fi

unset FNAME
