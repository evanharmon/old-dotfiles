#!/bin/bash

set -xe

# REQS
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

# SETUP PYENV
if ! which pyenv; then
	curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
	export PATH="/Users/evan/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi
