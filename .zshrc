# SOURCE ZSH FILES
export DOTFILES=$HOME
export ZSH=$HOME/.config/zsh
export ZPLUGHOME=$HOME/.zplug

# Define the code directory
# This is where my code exists and where I want the `c` autocomplete to work from exclusively
if [[ ! -d $HOME/code ]]; then
	mkdir $HOME/code
fi
export CODE_DIR=~/code

source ~/.config/zsh/zplug.sh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
for config ($ZSH/**/*.zsh) source $config

# OS SHELL SETTINGS
export TERM=xterm-256color
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
export CC=clang

# PATHS
export PATH=$HOME/.cargo/bin:$PATH
#export PATH=$PATH:./node_modules/.bin
#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# GOLANG
export PATH=/usr/local/go/bin:$PATH
export PATH=$PATH:$GOPATH/bin
export GOPATH=$HOME/go
export GO111MODULE=auto
export GOPROXY=http://127.0.0.1:3000
if lsof -i :3000; then
  echo "Gomods Proxy already running"
elif which proxy; then
  proxy &
fi

# NODE
if [ -d "$HOME/.nvm" ]; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

# PY
if [ -d "$HOME/.pyenv" ]; then
	export PATH="/Users/evan/.pyenv/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

# TOOLS
## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

## AWS
if [ -e /usr/local/bin/aws_completer ]; then
  source /usr/local/bin/aws_zsh_completer.sh
fi
export ANSIBLE_VAULT_PASSWORD_FILE="$HOME/.vault_pass.txt"

## GCLOUD
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/evan/.cache/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/evan/.cache/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/evan/.cache/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/evan/.cache/google-cloud-sdk/completion.zsh.inc'; fi
