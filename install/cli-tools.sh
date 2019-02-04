#!/bin/bash -xe

# REQUIREMENTS

if ! [ -x "$(command -v rg)" ]; then
    brew install ripgrep
fi

if ! [ -x "$(command -v fd)" ]; then
    brew install fd
fi

if ! [ -x "$(command -v bat)" ]; then
    VERSION='bat-v0.9.0-x86_64-apple-darwin'
    curl -Lo $HOME/.cache/$VERSION.tar.gz \
        https://github.com/sharkdp/bat/releases/download/v0.9.0/$VERSION.tar.gz
    tar -xf $HOME/.cache/$VERSION.tar.gz -C $HOME/.cache
    cp $HOME/.cache/$VERSION/bat $HOME/bin
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

## docker command not available until app opened for the first time
if ! [ -d /Applications/Docker.app ]; then
    curl -Lo $HOME/.cache/Docker.dmg \
      https://download.docker.com/mac/stable/Docker.dmg
    open $HOME/.cache/Docker.dmg
    echo "Opening Docker.dmg... finish installing in Finder"
fi

if ! [ "$(command -v tree)" ]; then
  brew install tree
fi

if ! [ "$(command -v rename)" ]; then
  brew install rename
fi

if ! [ "$(command -v pyenv)" ]; then
  brew install pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
fi

if ! [ "$(command -v pipenv)" ]; then
  brew install pipenv
fi

if ! [ "$(command -v ansible)" ]; then
  brew install ansible
fi
