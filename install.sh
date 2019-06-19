#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR
CURRENT_DIR=`pwd`

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}

echo "Step1: install plug.vim"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Step2: setting up symlinks"
lnif "$CURRENT_DIR/" "$HOME/.config/nvim"

echo "Step3: install Plugins with Plug"
nvim -u $HOME/.config/nvim/init.vim +PlugInstall! +PlugClean! +qall

echo "Step4: build YCM Core"

cd $CURRENT_DIR/plugged/youcompleteme/
git submodule update --init --recursive
python install.py --ts-completer --go-completer

echo "done"


