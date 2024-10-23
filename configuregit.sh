#!/bin/bash

# With no arguments, it will not modify global git config with 'name' and 'email'
# With two arguments: 'name' and 'email' will be updated:
# ./configurefit.sh myname myemail@email.com

# Requires curl or wget to donwload git-prompt.sh

if [ "$#" -ne 0 ] && [ "$#" -ne 2 ]; then
  echo "Usage: $0 [name email@email.com]" >&2
  exit 1
fi


export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

git config --global alias.lld 'log --pretty=format:"%C(yellow)%h%x20%C(cyan)%d%x20%C(green)%ad%x20%C(reset)%s%x20%C(red)(%an)" --graph --all --date=relative'
git config --global alias.ll 'log  --decorate --all --graph --oneline'
git config --global alias.lldo 'log --pretty=format:"%C(yellow)%h%x20%C(cyan)%d%x20%C(green)%ad%x20%C(reset)%s%x20%C(red)(%an)" --graph --date=relative'
git config --global alias.brc '!$HOME/git/git-brc.sh'

if [ "$#" -eq 2 ]; then
	git config --global user.name "$1"
	git config --global user.email "$2"
fi

mkdir -p $HOME/git && rm -rf $HOME/git/*
curl -f https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-prompt.sh > $HOME/git/git-prompt.sh 2>/dev/null || \
	wget https://raw.githubusercontent.com/git/git/refs/heads/master/contrib/completion/git-prompt.sh -O $HOME/git/git-prompt.sh 2>/dev/null || \
	{ echo "Failed to download git-prompt.sh. Aborting script"; exit 1; }
cp ./git/* $HOME/git/

sed -i '/bashrc4git/d' $HOME/.bashrc
echo ". ~/git/bashrc4git" >> $HOME/.bashrc
