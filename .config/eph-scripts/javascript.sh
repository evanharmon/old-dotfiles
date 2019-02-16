#!/bin/bash

# Don't set -e as nvm install will then fail while multiple curls
set -x

# Node Manager
if ! [ -d "$HOME/.fnm" ]; then
    curl https://raw.githubusercontent.com/Schniz/fnm/master/.ci/install.sh | bash
fi

if [ -d "$HOME/.fnm" ]; then
    echo "install node via fnm"
    fnm install latest
    export PATH=$HOME/.fnm:$PATH
    eval `fnm env`
    fnm use latest
fi

if ! [ -x "$(command -v yarn)" ]; then
    brew install yarn --without-node
fi

# Idempotent
npm install -g add neovim \
  prettier \
  typescript \
  bash-language-server \
  javascript-typescript-langserver \
  serverless \
  dockerfile-language-server-nodejs

echo "Finished. Remember to source .zshrc before continuing"
