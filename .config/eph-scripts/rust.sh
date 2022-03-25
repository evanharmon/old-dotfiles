#!/bin/bash -xe

if [[ "$(uname -a)" != Darwin* ]]; then
    echo "This script only supports Mac"
    exit 1
fi

CACHE=$HOME/.cache

# DOWNLOAD RUSTUP
if ! [ -f $CACHE/rustup.sh ]; then
    echo "Downloading rustup script"
    curl -Lo $CACHE/rustup.sh \
        https://sh.rustup.rs -sSf
fi

# INSTALL RUSTUP
if ! [ "$(command -v rustup)" ]; then
    echo "Installing rustup via .cache script"
    cat $CACHE/rustup.sh | sh
fi

if ! [ "$(command -v universal-ctags)" ]; then
    brew install --HEAD universal-ctags/universal-ctags/universal-ctags
fi

# COMPONENTS
if [ "$(command -v rustup)" ]; then
    rustup component add rustfmt rls-preview rust-analysis rust-src
fi

# CARGO packages
rustup update
brew tap mike-engel/jwt-cli
brew install jwt-cli
