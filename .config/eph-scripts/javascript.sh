#!/bin/bash

# Don't set -e as nvm install will then fail while multiple curls
set -x

if [[ "$(uname -a)" != Darwin* ]]; then
    echo "This script only supports Mac"
    exit 1
fi

NODE_VERSION='v12'
# Node Manager
if ! [ -d "$HOME/.fnm" ]; then
    curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh |
        bash -s -- --install-dir "./.fnm" --skip-shell --force-install
fi

if [ -d "$HOME/.fnm" ]; then
    echo "install node via fnm"
    fnm install $NODE_VERSION
    export PATH=$HOME/.fnm:$PATH
    eval `fnm env`
    fnm use $NODE_VERSION
fi

if ! [ -x "$(command -v yarn)" ]; then
    brew install yarn --without-node
fi

# Idempotent
npm install -g \
    add \
    bash-language-server \
    coc.nvim \
    dependency-cruiser \
    dockerfile-language-server-nodejs \
    graphql \
    ios-deploy \
    javascript-typescript-langserver \
    neovim \
    prettier \
    pure-prompt \
    serve \
    typescript \

echo "Finished. Remember to source .zshrc before continuing"
