#!/usr/bin/env bash
#
# setup.sh
# Copyright (C) 2017 KuoE0 <kuoe0.tw@gmail.com>
#
# Distributed under terms of the MIT license.
#

if [ "$#" != "1" ]; then
	echo "Usage: setup.sh [work dir]"
	exit
fi

WORK_DIR="$1"

OS="$(uname)"
echo "Platform: \x1b[0;32m$OS\x1b[0m"

# absolute path of current directory
if [[ "$OS" = "Darwin" ]]; then
	TMP_DIR="/tmp/$(date +%s | md5 | head -c 10)"
	SCRIPTPATH=$(realpath "$0" | xargs -0 dirname)
else
	TMP_DIR="/tmp/$(date +%s | md5sum | head -c 10)"
	SCRIPTPATH=$(readlink -f "$0" | xargs -0 dirname)
fi

echo "Installing gdb-dashboard..."
git clone --depth 1 https://github.com/cyrus-and/gdb-dashboard "$SCRIPTPATH/src/gdb-dashboard"
ln -s "$HOME/gdb-dashboard/.gdbinit" "$HOME/.gdbinit"

echo "Setting up Zsh environment..."
git clone git@github.com:KuoE0/KuoE0-zsh.git "$WORK_DIR/KuoE0-zsh"
cd "$WORK_DIR/KuoE0-zsh"
./setup.sh

echo "Settting up Vim environment..."
git clone git@github.com:KuoE0/KuoE0-vim.git "$WORK_DIR/KuoE0-vim"
cd "$WORK_DIR/KuoE0-vim"
./setup.sh

ln -s "$SCRIPTPATH/dot.gitconfig" "$HOME/.gitconfig"
