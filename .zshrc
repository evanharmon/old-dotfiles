# SOURCE ZSH FILES
export DOTFILES=$HOME
export ZSH=$HOME/.config/zsh
if [[ "$OSTYPE" == darwin* && -d $HOME/.zplug ]]; then
  export ZPLUGHOME=$HOME/.zplug
  source $HOME/.config/zsh/zplug.sh
fi

if [[ ! -d $HOME/code ]]; then
	mkdir $HOME/code
fi
export CODE_DIR=$HOME/code

if [[ "$OSTYPE" == darwin* ]]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
	export BROWSER='open'
fi

fpath=($HOME/zsh-completions/src $fpath)
for config ($ZSH/**/*.zsh) source $config

# OS SHELL SETTINGS
export TERM=xterm-256color
if ! [ "$(command -v nvim)" ]; then
	export EDITOR='vim'
	export VISUAL='vim'
else
	export EDITOR='nvim'
	export VISUAL='nvim'
fi
export PAGER='less'

# PATHS
export PATH=$HOME/.pyenv/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.protoc/bin:$PATH
export PATH=$HOME/bin:/usr/local/sbin:$PATH

# PY
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PYENV_VERSION='2.7.14'
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
  source $PYENV_ROOT/completions/pyenv.zsh
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

if [ -e $HOME/.pyenv/versions/aws/bin/aws_completer ]; then
  source $HOME/.pyenv/versions/aws/bin/aws_zsh_completer.sh
fi

# GOLANG
export GOPATH=$HOME/go
export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH
export GO111MODULE=off
export GOPROXY=http://127.0.0.1:3000

# NODEJS
if [ -d "$HOME/.fnm" ]; then
  export PATH=$HOME/.fnm:./node_modules/.bin:$PATH
  eval `fnm env`
fi

export AWS_DEFAULT_REGION='us-east-1'
export AWS_REGION='us-east-1'
