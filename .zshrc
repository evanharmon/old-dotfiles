# SOURCE ZSH FILES
export DOTFILES=$HOME
export ZSH=$HOME/.config/zsh
export ZPLUGHOME=$HOME/.zplug

# Used for FZF
if [[ ! -d $HOME/code ]]; then
	mkdir $HOME/code
fi
export CODE_DIR=$HOME/code

source ~/.config/zsh/zplug.sh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
for config ($ZSH/**/*.zsh) source $config

# OS SHELL SETTINGS
export TERM=xterm-256color
if [[ "$OSTYPE" == darwin* ]]; then
	export BROWSER='open'
fi

if ! [ "$(command -v nvim)" ]; then
	export EDITOR='vim'
	export VISUAL='vim'
else
	export EDITOR='nvim'
	export VISUAL='nvim'
fi
export PAGER='less'
export CC=clang

# PATHS
export PATH=/usr/local/go/bin:$PATH
export PATH=$HOME/.pyenv/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.protoc/bin
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:./node_modules/.bin
export PATH=$PATH:$HOME/.cache/dein/repos/github.com/juliosueiras/vim-terraform-completion/bin

# NODE
if [ -d "$HOME/.nvm" ]; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

# PY
if [ -d "$HOME/.pyenv" ]; then
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
  export PYENV_VERSION='2.7.11'
fi

# TOOLS
## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd . $CODE_DIR"
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
export GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/${USER}.json

# GOLANG
export GO111MODULE=auto
export GOPROXY=http://127.0.0.1:3000

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/evanharmon/.cache/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/evanharmon/.cache/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/evanharmon/.cache/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/evanharmon/.cache/google-cloud-sdk/completion.zsh.inc'; fi
