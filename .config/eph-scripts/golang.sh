#!/bin/bash

set -xe

if [[ "$(uname -a)" != Darwin* ]]; then
    echo "This script only supports Mac"
    exit 1
fi

CACHE=$HOME/.cache
GOLANG_VERSION='1.13'
GOLANG_DOWNLOAD=''
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
GOLANG_DOWNLOAD=go$GOLANG_VERSION.$OS-$ARCH.tar.gz
if [[ ! -f $CACHE/$GOLANG_DOWNLOAD ]]; then
  curl -Lo $CACHE/$GOLANG_DOWNLOAD \
    "https://dl.google.com/go/$GOLANG_DOWNLOAD"
fi

if [[ ! -d /usr/local/go ]]; then
  sudo tar -C /usr/local -xzf $CACHE/$GOLANG_DOWNLOAD
fi

# INSTALL TOOLS
if [ ! -d $HOME/.protoc ]; then
  mkdir -p $HOME/.protoc
  go get -u google.golang.org/grpc
  go get -u github.com/golang/protobuf/protoc-gen-go
  curl -Lo $CACHE/protoc-3.6.1-osx-x86_64.zip \
    https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/protoc-3.6.1-osx-x86_64.zip
  unzip $CACHE/protoc-3.6.1-osx-x86_64.zip -d $HOME/.protoc
fi

## INSTALL PKG NOT SUPPORTING GO MODULES
GO111MODULE=off
go get -u github.com/derekparker/delve/cmd/dlv
go get golang.org/x/tools/...
GO111MODULE=auto

# Idempotent
go get golang.org/x/oauth2
go get cloud.google.com/go/storage
go get google.golang.org/appengine/...
go get github.com/golang/mock/gomock && go install github.com/golang/mock/mockgen

unset OS
unset ARCH
unset GOLANG_VERSION
unset GOLANG_DOWNLOAD
