#!/bin/bash

export TERM=xterm-256color
export PATH=$HOME/.cargo/bin:$PATH

if [[ "$OSTYPE" == darwin* ]]; then
	export BROWSER='open'
fi

if ! which nvim; then
	export EDITOR='vim'
	export VISUAL='vim'
else
	export EDITOR='nvim'
	export VISUAL='nvim'
fi
export PAGER='less'

# GOLANG
export PATH=/usr/local/go/bin:$PATH
export PATH=$PATH:$GOPATH/bin
export GOPATH=$HOME/go
if [ -d $GOPATH/src/github.com/gomods/athens ]; then
  export GO111MODULE=on
  export GOPROXY=http://127.0.0.1:3000
  go get -u github.com/gomods/athens/cmd/proxy
  proxy &
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias dotfiles='/usr/bin/git --git-dir=/Users/evan/.dotfiles/ --work-tree=/Users/evan'

if [ -d "$HOME/.pyenv" ]; then
	export PATH="~/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

# Define the code directory
# This is where my code exists and where I want the `c` autocomplete to work from exclusively
if [[ -d ~/code ]]; then
	export CODE_DIR=~/code
else
	mkdir $HOME/code
	export CODE_DIR=~/code
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -e /usr/local/bin/aws_completer ]; then
  complete -C '/usr/local/bin/aws_completer' aws
fi

export ANSIBLE_VAULT_PASSWORD_FILE="$HOME/.vault_pass.txt"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/evan/.cache/google-cloud-sdk/path.bash.inc' ]; then source '/Users/evan/.cache/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/evan/.cache/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/evan/.cache/google-cloud-sdk/completion.bash.inc'; fi
