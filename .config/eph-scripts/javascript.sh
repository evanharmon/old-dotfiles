#!/bin/bash

# Don't set -e as nvm install will then fail while multiple curls
set -x

if [[ "$(uname -a)" != Darwin* ]]; then
    echo "This script only supports Mac"
    exit 1
fi

NODE_VERSION='v11.9.0'
# Node Manager
if ! [ -d "$HOME/.fnm" ]; then
    curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash -s -- --install-dir "./.fnm" --skip-shell
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
    pure-prompt \
    neovim \
    prettier \
    typescript \
    coc.nvim \
    bash-language-server \
    javascript-typescript-langserver \
    dockerfile-language-server-nodejs

echo "Finished. Remember to source .zshrc before continuing"
