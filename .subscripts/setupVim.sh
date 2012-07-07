#!/bin/bash
# Install and Setup Vim

sudo apt-get -y install vim vim-doc

# .vim
if [ -e "`cd $1; pwd`/.vim" ];
then
  mv ~/.vim ~/.mySetup/.backups
fi
ln -s ~/.mySetup/.vim ~/

# .vimrc
if [ -e "`cd $1; pwd`/.vimrc" ];
then
  mv ~/.vimrc ~/.mySetup/.backups
fi
ln -s ~/.mySetup/.vim/.vimrc ~/.vimrc
