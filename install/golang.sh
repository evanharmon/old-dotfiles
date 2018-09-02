#!/bin/bash

set -xe
VERSION='1.11'

# SETUP
if [[ ! -d $HOME/go ]]; then
  mkdir $HOME/go
fi

# INSTALL GOLANG
if [[ "$OSTYPE" == darwin* ]]; then
  OS='darwin'
  ARCH='amd64'
fi

# password prompt
if [[ ! -d /usr/local/go ]]; then
  curl \
    "https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz" \
    -o "~/.cache/go$VERSION.$OS-$ARCH.tar.gz"
  sudo tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
fi

# INSTALL TOOLS
if [ ! -d $GOPATH/src/github.com/gomods/athens ]; then
  go get -u github.com/gomods/athens/cmd/proxy
fi
