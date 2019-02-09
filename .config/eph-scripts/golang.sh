#!/bin/bash

set -xe
CACHE=$HOME/.cache
GOLANG_VERSION='1.11'
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

# Idempotent
go get -u golang.org/x/oauth2
go get -u cloud.google.com/go/storage
go get -u google.golang.org/appengine/...
go get -u github.com/sourcegraph/go-langserver
go get -u github.com/golang/mock/gomock
go install github.com/golang/mock/mockgen
go get -u github.com/derekparker/delve/cmd/dlv

unset OS
unset ARCH
unset GOLANG_VERSION
unset GOLANG_DOWNLOAD
