#!/bin/bash

if ! [ "$(command -v nvim)" ]; then
    export EDITOR='vim'
    export VISUAL='vim'
else
    export EDITOR='nvim'
    export VISUAL='nvim'
fi
export PAGER='less'

if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
	export PYENV2_NAME=v2
	export PYENV3_NAME=v3
    export PYENV_VERSION='2.7.14'
    export PYENV_VERSION3='3.5.5'
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export PYENV_SHELL=bash
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    source $PYENV_ROOT/completions/pyenv.bash
fi

if [ -d "$HOME/.fnm" ]; then
    export PATH=$HOME/.fnm:./node_modules/.bin:$PATH
    eval `fnm env`
fi
