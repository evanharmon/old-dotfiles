#!/bin/bash

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias dotfiles='/usr/bin/git --git-dir=/Users/evan/.dotfiles/ --work-tree=/Users/evan'

if [ -d "$HOME/.pyenv" ]; then
	export PATH="~/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi
