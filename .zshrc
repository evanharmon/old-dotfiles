# SOURCE ZSH FILES
export SHELL=zsh DOTFILES=$HOME CODE_DIR=$HOME/code ZSH=$HOME/.config/zsh
if [[ "$OSTYPE" == darwin* && -d $HOME/.zplug ]]; then
    export ZPLUGHOME=$HOME/.zplug
    source $HOME/.config/zsh/zplug.sh
fi


if [[ "$OSTYPE" == darwin* ]]; then
    test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
    export BROWSER='none' ## avoid opening browsers on npm runs
fi

fpath=($HOME/zsh-completions/src $fpath)
for config ($ZSH/**/*.zsh) source $config

# OS SHELL SETTINGS
export TERM=xterm-256color
export PATH="$HOME/nvim-osx64/bin:$PATH"
if ! [ "$(command -v nvim)" ]; then
    export EDITOR='vim' VISUAL='vim'
else
    export EDITOR='nvim' VISUAL='nvim'
fi
export PAGER='less'

# PATHS
if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
    export PATH=$HOME/.cargo/bin:$PATH
fi

if [[ ":$PATH:" != *":$HOME/.protoc/bin:"* ]]; then
    export PATH=$HOME/.protoc/bin:$PATH
fi

if [[ ":$PATH:" != *":$HOME/bin:/usr/local/sbin:"* ]]; then
    export PATH=$HOME/bin:/usr/local/sbin:$PATH
fi

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH=$HOME/.local/bin:$PATH
fi

# PYTHON
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    if [[ ":$PATH:" != *":$PYENV_ROOT/shims:$PYENV_ROOT/bin:"* ]]; then
        export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
    fi
    export PYENV2_NAME=v2 PYENV3_NAME=v3
    export PYENV_VERSION='2.7.14' PYENV_VERSION3='3.8.5'
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1 PYENV_SHELL=zsh
    eval "$(pyenv init -)"
fi

if [ -d "$PYENV_ROOT/completions" ]; then
    source $PYENV_ROOT/completions/pyenv.zsh
fi

# TOOLS
## FZF / RG
## ripgre config causing errors on every rg run
export RIPGREP_CONFIG_PATH=~/.config/ripgreprc
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
    source /usr/local/opt/fzf/shell/key-bindings.zsh
    source /usr/local/opt/fzf/shell/completion.zsh
fi
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

## AWS
export AWS_DEFAULT_REGION='us-east-1' AWS_REGION='us-east-1'
if [ -e /usr/local/bin/aws_completer ]; then
    source /usr/local/bin/aws_zsh_completer.sh
fi

if [ -e $HOME/.pyenv/versions/aws/bin/aws_completer ]; then
    source $HOME/.pyenv/versions/aws/bin/aws_zsh_completer.sh
fi

# GOLANG
export GOPATH=$HOME/go
if [[ ":$PATH:" != *":/usr/local/go/bin:$GOPATH/bin:"* ]]; then
    export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH
fi
export GO111MODULE=on

# NODEJS
if [[ ":$PATH:" != *":$HOME/.yarn/bin:"* ]]; then
    export PATH=$HOME/.yarn/bin:$PATH
fi
NODE_VERSION=v12
if [ -d "$HOME/.fnm" ]; then
    if [[ ":$PATH:" != *":$HOME/.fnm:$HOME/.fnm/current/bin:node_modules/.bin:"* ]]; then
        export PATH=$HOME/.fnm:$HOME/.fnm/current/bin:node_modules/.bin:$PATH
    fi
    eval `fnm env`
    fnm use $NODE_VERSION
fi

# RUBY
export RBENV_VERSION=2.6.0
if [ "$(command -v rbenv)" ]; then
    eval "$(rbenv init -)"
fi

if [[ ":$PATH:" != *":$HOME/.rbenv/shims:$HOME/.rbenv/bin:"* ]]; then
    export PATH=$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH
fi

# C
if [ -d "/usr/local/opt/llvm/bin/clangd" ]; then
    if [[ ":$PATH:" != *":/usr/local/opt/llvm/bin:"* ]]; then
        export PATH=/usr/local/opt/llvm/bin:$PATH
    fi
fi

# Android
export PATH=$PATH:~/Library/Android/sdk/platform-tools # support for `adb devices` command

# DOCKER
export DOCKER_BUILDKIT=1

# MUST BE LAST
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
