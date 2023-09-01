#!/bin/bash

git config alias.lld 'log --pretty=format:"%C(yellow)%h%x20%C(cyan)%d%x20%C(green)%ad%x20%C(reset)%s%x20%C(red)(%an)" --graph --all --date=relative'
git config alias.ll 'log  --decorate --all --graph --oneline'
git config alias.lldo 'log --pretty=format:\"%C(yellow)%h%x20%C(cyan)%d%x20%C(green)%ad%x20%C(reset)%s%x20%C(red)(%an)\" --graph --date=relative'

export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR


cp git-* $HOME
cat bashrc4git >> $HOME/.bashrc
