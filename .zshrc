export DOTFILES=$HOME/.dotfiles
export ZSH=$HOME/.config/zsh
export ZPLUGHOME=$HOME/.zplug

source ~/.config/zsh/zplug.sh
# SOURCE ZSH FILES
for config ($ZSH/**/*.zsh) source $config

export TERM=xterm-256color-italic
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH=$PATH:./bin/:./node_modules/.bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH="$HOME/.cargo/bin:$PATH"
export CC=clang
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# define the code directory
# This is where my code exists and where I want the `c` autocomplete to work from exclusively
if [[ -d ~/code ]]; then
    export CODE_DIR=~/code
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
