#!/bin/bash -xe

if [[ "$(uname -a)" != Darwin* ]]; then
    echo "This script only supports Mac"
    exit 1
fi

CACHE=$HOME/.cache

# DOWNLOAD RUBY VERSION MANAGER
brew install rbenv ruby-build

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

rbenv install $RBENV_VERSION

if ! [ "$(gem list rake -i)" ]; then
    gem install rake fastlane
fi
