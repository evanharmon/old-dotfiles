#!/bin/bash

set -xe
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# REQS
if ! [ -x "$(command -v rg)" ]; then
    brew install ripgrep
fi

if ! [ -x "$(command -v fd)" ]; then
    brew install fd
fi

# Requires User Input To Prompts
if ! [ -x "$(command -v fzf)" ]; then
    brew install fzf
    /usr/local/opt/fzf/install
fi

if ! [ -x "$(command -v jq)" ]; then
    brew install jq
fi

if ! brew list readline; then
    brew install readline
fi

if ! [ -x "$(command -v xz)" ]; then
    brew install xz
fi

if ! brew list openssl; then
    brew install openssl
fi

if ! [ -x "$(command -v docker)" ]; then
    curl -Lo $HOME/.cache/Docker.dmg \
      https://download.docker.com/mac/stable/Docker.dmg
    open $HOME/.cache/Docker.dmg
    echo "Opening Docker.dmg... finish installing in Finder"
fi
