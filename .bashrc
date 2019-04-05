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
    if [[ ":$PATH:" != *":$PYENV_ROOT/shims:$PYENV_ROOT/bin:"* ]]; then
        export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
    fi
	export PYENV2_NAME=v2
	export PYENV3_NAME=v3
    export PYENV_VERSION='2.7.14'
    export PYENV_VERSION3='3.5.5'
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export PYENV_SHELL=bash
    eval "$(pyenv init -)"
    source $PYENV_ROOT/completions/pyenv.bash
fi

if [ -d "$HOME/.fnm" ]; then
    if [[ ":$PATH:" != *":$HOME/.fnm:$HOME/.fnm/current/bin:node_modules/.bin:"* ]]; then
        export PATH=$HOME/.fnm:$HOME/.fnm/current/bin:node_modules/.bin:$PATH
    fi
    eval `fnm env`
    fnm use v11.10.1
fi
