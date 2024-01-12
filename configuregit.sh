#!/bin/bash

# With no arguments, it will not modify global git config with 'name' and 'email'
# With two arguments: 'name' and 'email' will be updated:
# ./configurefit.sh myname myemail@email.com

if [ "$#" -ne 0 ] && [ "$#" -ne 2 ]; then
  echo "Usage: $0 [name email@email.com]" >&2
  exit 1
fi


export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

git config --global alias.lld 'log --pretty=format:"%C(yellow)%h%x20%C(cyan)%d%x20%C(green)%ad%x20%C(reset)%s%x20%C(red)(%an)" --graph --all --date=relative'
git config --global alias.ll 'log  --decorate --all --graph --oneline'
git config --global alias.lldo 'log --pretty=format:"%C(yellow)%h%x20%C(cyan)%d%x20%C(green)%ad%x20%C(reset)%s%x20%C(red)(%an)" --graph --date=relative'

if [ "$#" -eq 2 ]; then
	git config --global user.name "$1"
	git config --global user.email "$2"
fi

cp git-* $HOME
cat bashrc4git >> $HOME/.bashrc
