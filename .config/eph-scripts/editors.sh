#!/bin/bash

set -xe

# Should match $HOME/.zshrc in dotfiles
PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
PYENV2_NAME="${PYENV2_NAME:-v2}"
PYENV3_NAME="${PYENV3_NAME:-v3}"
PYENV_VERSION="${PYENV_VERSION:-2.7.14}"
PYENV_VERSION3="${PYENV_VERSION3:-3.8.5}"

if [[ "$(uname -a)" != Darwin* ]]; then
    echo "This script only supports Mac"
    exit 1
fi

# EXPORTS
export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if [[ ! -d $HOME/.local ]]; then
	mkdir $HOME/.local
fi

if [ ! -L $PYENV_ROOT/versions/$PYENV2_NAME ]; then
    pyenv install --skip-existing $PYENV_VERSION
    pyenv virtualenv $PYENV_VERSION $PYENV2_NAME
    pyenv activate $PYENV2_NAME
    pip install --upgrade pip
    pip install neovim pynvim
fi

if [ ! -L $PYENV_ROOT/versions/$PYENV3_NAME ]; then
    pyenv install --skip-existing $PYENV_VERSION3
    pyenv virtualenv $PYENV_VERSION3 $PYENV3_NAME
    pyenv activate $PYENV3_NAME
    pip install --upgrade pip
    pip install neovim pynvim
fi

## run ruby.sh first
if ! [ "$(command -v rbenv)" ]; then
    echo "Run `sh ruby.sh` before this script"
fi

if ! [ -x "$(gem list neovim -i)" ]; then
    gem install neovim
fi

# Always Grab Nightly
FNAME='nightly.tar.gz'
curl -fLo $HOME/.cache/$FNAME "https://github.com/neovim/neovim/archive/$FNAME"
tar xzvf $HOME/.cache/$FNAME -C $HOME

# Always Grab Latest Version
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if ! [ -f $HOME/bin/tflint ]; then
    FNAME='tflint_darwin_amd64.zip'
    curl -LO $HOME/.cache/$FNAME \
        "https://github.com/wata727/tflint/releases/download/v0.7.2/$FNAME"
    unzip $HOME/.cache/$FNAME -d $HOME/bin
fi

# clangd
if [ -d /usr/local/opt/llvm ]; then
    ln -sf "/usr/local/opt/llvm/bin/clangd" "/usr/local/bin/clangd"
    ln -sf "/usr/local/opt/llvm/bin/clang-tidy" "/usr/local/bin/clang-tidy"
fi

if ! brew list universal-ctags; then
    brew install --HEAD universal-ctags/universal-ctags/universal-ctags
fi

brew update

## VSCODE
## Must manually open vs code command palette and type `shell command`, do install code command
if [ -f $HOME/.config/vscode/settings.json ]; then
    ln -sf ~/.config/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
    ln -sf ~/.config/vscode/launch.json ~/Library/Application\ Support/Code/User/launch.json
fi

# install extensions
pkglist=(
alesiong.clang-tidy-linter
AndrsDC.base16-themes
esbenp.prettier-vscode
firefox-devtools.vscode-firefox-debug
golang.go
hashicorp.terraform
llvm-vs-code-extensions.vscode-clangd
ms-python.python
ms-vscode.cmake-tools
ms-vscode.cpptools
ms-vsliveshare.vsliveshare
vscodevim.vim
)

if [ "$(command -v code)" ]; then
    for i in ${pkglist[@]}; do
        code --install-extension $i
    done
fi

## Xcode
if ! [ "$(brew list swiftlint)" ]; then
    brew install swiftlint
fi

if ! brew list ccls; then
    brew install ccls
fi
