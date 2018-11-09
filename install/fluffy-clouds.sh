#!/bin/bash

set -xe
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# REQS
if ! [ -d $HOME/bin ]; then
  mkdir -p $HOME/bin
fi

# SETUP PYENV
## EVERYONE SHOULD HAVE A PRIVATE BOOTH AT THIS PY PARTY
if ! [ -x "$(command -v pyenv)" ]; then
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
  export PATH="/Users/evan/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# AWS CLI
if ! [ -x "$(pyenv activate aws)" ]; then
  pyenv install --skip-existing 3.5.5
  pyenv virtualenv 3.5.5 aws
  pyenv activate aws
fi

if ! [ -x "$(pyenv which aws)" ]; then
  curl \
    "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" \
    -o "$HOME/.cache/awscli-bundle.zip"
  unzip $HOME/.cache/awscli-bundle.zip -d $HOME/.cache
  sudo $HOME/.cache/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
  echo "Run aws configure afterwards"
fi

## Localstack CLI
if ! [ -x "$(pyenv which awslocal)" ]; then
  pip3 install awscli-local
fi

## Serverless Applications Manager
if ! [ -x "$(pyenv which sam)" ]; then
  pip3 install aws-sam-cli
fi

# INSTALL GCLOUD CLI
if ! [ -x "$(pyenv activate gcloud)" ]; then
  pyenv install --skip-existing 2.7.11
  pyenv virtualenv 2.7.11 gcloud
  pyenv activate gcloud
fi

if ! [ -x "$(pyenv which gcloud)" ]; then
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
if ! [ -x "$(command -v docker-machine-driver-hyperkit)" ]; then
  curl -Lo $HOME/.cache/docker-machine-driver-hyperkit \
    https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit
  chmod +x $HOME/.cache/docker-machine-driver-hyperkit
  sudo cp $HOME/.cache/docker-machine-driver-hyperkit /usr/local/bin/
  sudo chown root:wheel /usr/local/bin/docker-machine-driver-hyperkit
  sudo chmod u+s /usr/local/bin/docker-machine-driver-hyperkit
fi

# INSTALL KUBERNETES
if ! [ -x "$(command -v minikube)" ]; then
  curl -Lo $HOME/.cache/minikube \
    https://storage.googleapis.com/minikube/releases/v0.28.2/minikube-darwin-amd64
  chmod +x $HOME/.cache/minikube
  sudo mv $HOME/.cache/minikube /usr/local/bin/
fi

if ! [ -x "$(command -v kubectl)" ]; then
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

if ! [ "$(command -v terraform)" ]; then
  FNAME='terraform_0.11.8_darwin_amd64.zip'
  curl -Lo $HOME/.cache/$FNAME \
    https://releases.hashicorp.com/terraform/0.11.8/$FNAME
  unzip $HOME/.cache/$FNAME -d $HOME/bin
fi

unset GCLOUD_SDK_VERSION
unset K8S_VERSION
unset FNAME
