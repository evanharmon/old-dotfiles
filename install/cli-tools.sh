#!/bin/bash

set -xe
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# REQS
if ! which rg; then
  brew install ripgrep
fi

if ! which fd; then
	brew install fd
fi

if ! which fzf; then
	brew install fzf
fi

if ! which jq; then
	brew install jq
fi

if ! brew list readline; then
	brew install readline
fi

if ! which xz; then
	brew install xz
fi

if ! brew list openssl; then
	brew install openssl
fi

# AWS CLI
if [ ! -f $HOME/.cache/awscli-bundle.zip ]; then
  curl \
    "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" \
    -o "$HOME/.cache/awscli-bundle.zip"
fi
if ! which aws; then
  unzip $HOME/.cache/awscli-bundle.zip -d $HOME/.cache
  sudo $HOME/.cache/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
  echo "Run aws configure afterwards"
fi

# Install gcloud cli
if ! pyenv activate gcloud; then
	pyenv virtualenv 2.7.11 gcloud
  pyenv activate gcloud
fi
if ! which gcloud; then
  curl \
    "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-214.0.0-darwin-x86_64.tar.gz" \
    -o "$HOME/.cache/google-cloud-sdk-214.0.0-darwin-x86_64.tar.gz"
  mkdir -p $HOME/.cache/google-cloud-sdk
  tar -C $HOME/.cache -xzf $HOME/.cache/google-cloud-sdk-214.0.0-darwin-x86_64.tar.gz
  sh ~/.cache/google-cloud-sdk/install.sh
  echo "gcloud available under pyenv activate gloud"
  echo "Run gcloud init afterwards"
fi

# SETUP PYENV
if ! which pyenv; then
	curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
	export PATH="/Users/evan/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi
