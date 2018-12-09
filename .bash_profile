#!/bin/bash

if ! echo "$0" == "/bin/zsh"; then
    source $HOME/.bashrc
fi

export PATH="$HOME/.cargo/bin:$PATH"
