#!/bin/bash

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

git config --global alias.lld 'log --pretty=format:"%C(yellow)%h%x20%C(cyan)%d%x20%C(green)%ad%x20%C(reset)%s%x20%C(red)(%an)" --graph --all --date=relative'
git config --global alias.ll 'log  --decorate --all --graph --oneline'
git config --global alias.lldo 'log --pretty=format:\"%C(yellow)%h%x20%C(cyan)%d%x20%C(green)%ad%x20%C(reset)%s%x20%C(red)(%an)\" --graph --date=relative'


cp git-* $HOME
cat bashrc4git >> $HOME/.bashrc
