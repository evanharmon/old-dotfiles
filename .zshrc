export DOTFILES=$HOME
export ZSH=$HOME/.config/zsh
export ZPLUGHOME=$HOME/.zplug

# SOURCE ZSH FILES
source ~/.config/zsh/zplug.sh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
for config ($ZSH/**/*.zsh) source $config

export TERM=xterm-256color
if [ -d "$HOME/.nvm" ]; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
fi

if [ -d "$HOME/.pyenv" ]; then
	export PATH="/Users/evan/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

# PATHS
export PATH="$HOME/.cargo/bin:$PATH"
#export PATH=$PATH:./node_modules/.bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export CC=clang
export GOPATH=$HOME/go

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
	  source /usr/local/bin/aws_zsh_completer.sh
fi

export ANSIBLE_VAULT_PASSWORD_FILE="$HOME/.vault_pass.txt"
