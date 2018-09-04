#!/bin/bash

set -xe
CACHE=$HOME/.cache
GOLANG_VERSION='1.11'
OS=''
ARCH=''

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
    "https://dl.google.com/go/go$GOLANG_VERSION.$OS-$ARCH.tar.gz" \
    -o "~/.cache/go$GOLANG_VERSION.$OS-$ARCH.tar.gz"
  sudo tar -C /usr/local -xzf go$GOLANG_VERSION.$OS-$ARCH.tar.gz
fi

# INSTALL TOOLS
if [ ! -d $HOME/.protoc ]; then
  mkdir -p $HOME/.protoc
  go get -u github.com/golang/protobuf/protoc-gen-go
  curl -Lo $CACHE/protoc-3.6.1-osx-x86_64.zip \
    https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/protoc-3.6.1-osx-x86_64.zip
  unzip $CACHE/protoc-3.6.1-osx-x86_64.zip -d $HOME/.protoc
fi

unset OS
unset ARCH
unset GOLANG_VERSION
