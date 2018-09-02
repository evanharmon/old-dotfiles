#!/bin/bash

set -xe
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# SETUP PYENV
## EVERYONE SHOULD HAVE A PRIVATE BOOTH AT THIS PY PARTY
if ! which pyenv; then
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
  export PATH="/Users/evan/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
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

# INSTALL GCLOUD CLI
if ! pyenv activate gcloud; then
  pyenv virtualenv 2.7.11 gcloud
  pyenv activate gcloud
fi
if ! pyenv which gcloud; then
  GCLOUD_SDK_VERSION='google-cloud-sdk-214.0.0-darwin-x86_64'
  curl -Lo $HOME/.cache/$GCLOUD_SDK_VERSION.tar.gz \
    https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/$GCLOUD_SDK_VERSION.tar.gz
  mkdir -p $HOME/.cache/google-cloud-sdk
  tar -C $HOME/.cache -xzf $HOME/.cache/$GCLOUD_SDK_VERSION.tar.gz
  sh $HOME/.cache/google-cloud-sdk/install.sh
  echo "gcloud available under pyenv activate gloud"
  echo "Run gcloud init afterwards"
fi

# INSTALL HYPERKIT FOR K8S
if ! which docker-machine-driver-hyperkit; then
  curl -Lo $HOME/.cache/docker-machine-driver-hyperkit \
    https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit
  chmod +x $HOME/.cache/docker-machine-driver-hyperkit
  sudo cp $HOME/.cache/docker-machine-driver-hyperkit /usr/local/bin/
  sudo chown root:wheel /usr/local/bin/docker-machine-driver-hyperkit
  sudo chmod u+s /usr/local/bin/docker-machine-driver-hyperkit
fi

# INSTALL KUBERNETES
if ! which minikube; then
  curl -Lo $HOME/.cache/minikube \
    https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-darwin-amd64
  chmod +x $HOME/.cache/minikube
  sudo mv $HOME/.cache/minikube /usr/local/bin/
fi
if ! which kubectl; then
  K8S_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
  curl -Lo $HOME/.cache/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/$K8S_VERSION/bin/darwin/amd64/kubectl
  chmod +x $HOME/.cache/kubectl
  sudo mv $HOME/.cache/kubectl /usr/local/bin/kubectl
fi

# INSTALL LOCALSTACK FOR AWS
## Avoid installing all the dependencies locally by using docker-compose in repo
if [ ! -d $HOME/code/localstack ]; then
  git clone https://github.com/localstack/localstack.git $HOME/code/localstack
fi
