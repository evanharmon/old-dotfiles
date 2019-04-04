# SOURCE ZSH FILES
export SHELL=zsh
export DOTFILES=$HOME
export CODE_DIR=$HOME/code
export ZSH=$HOME/.config/zsh
if [[ "$OSTYPE" == darwin* && -d $HOME/.zplug ]]; then
  export ZPLUGHOME=$HOME/.zplug
  source $HOME/.config/zsh/zplug.sh
fi


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
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.protoc/bin:$PATH
export PATH=$HOME/bin:/usr/local/sbin:$PATH

# PY
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
	export PYENV2_NAME=v2
	export PYENV3_NAME=v3
  export PYENV_VERSION='2.7.14'
  export PYENV_VERSION3='3.5.5'
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  export PYENV_SHELL=zsh
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

if [ -d "$PYENV_ROOT/completions" ]; then
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
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

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
export PATH=$HOME/.yarn/bin:$PATH
if [ -d "$HOME/.fnm" ]; then
  export PATH=$HOME/.fnm:$HOME/.fnm/current/bin:node_modules/.bin:$PATH
  eval `fnm env`
  fnm use v11.10.1
fi

# RUBY
export RBENV_VERSION=2.6.0
export PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH

# C
if [ -d "/usr/local/opt/llvm/bin/clangd" ]; then
  export PATH=/usr/local/opt/llvm/bin:$PATH
fi

# TERRAFORM
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/eharmon/bin/terraform terraform

# MUST BE LAST
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
