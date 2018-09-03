#!/bin/bash

set -xe
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# REQS
if ! which rg; then
    brew install ripgrep
fi

if ! which fd; then
    brew install fd
fi

# Requires User Input To Prompts
if ! which fzf; then
    brew install fzf
    /usr/local/opt/fzf/install
fi

if ! which jq; then
    brew install jq
fi

if ! brew list readline; then
    brew install readline
fi

if ! which xz; then
    brew install xz
fi

if ! brew list openssl; then
    brew install openssl
fi

if ! which docker; then
    curl -Lo \ $HOME/.cache
    https://download.docker.com/mac/stable/Docker.dmg
    echo "Opening Docker.dmg... finish installing in Finder"
fi
