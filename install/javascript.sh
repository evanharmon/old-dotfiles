#!/bin/bash

# Don't set -e as nvm install will then fail while multiple curls
set -x

# NVM
if ! [ -d "$HOME/.nvm" ]; then
    unset NVM_DIR
    NVM_VERSION=v0.33.11
    curl -o- \
      https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh |\
      bash
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
if [ -d "$HOME/.nvm" ]; then
    echo "install node via nvm"
    nvm install node
fi

if ! which yarn; then
    brew install yarn --without-node
fi

echo "Finished. Remember to source .zshrc before continuing"
