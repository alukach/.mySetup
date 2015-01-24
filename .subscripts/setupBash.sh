#!/bin/bash
# Setup Bash

# .bashrc
echo "#! Setting up .bashrc..."
if [ -e "`cd $1; pwd`/.bashrc" ];
then
  mv ~/.bashrc ~/.mySetup/.backups
fi
ln -s ~/.mySetup/.bashrc ~/
ln -s ~/.mySetup/.git-prompt.sh ~/


source `cd $1; pwd`/.bashrc

# .bash_profile
echo "#! Setting up .bash_profile..."
if [ -e "`cd $1; pwd`/.bash_profile" ];
then
  mv ~/.bash_profile ~/.mySetup/.backups
fi
ln -s ~/.mySetup/.bash_profile ~/
source `cd $1; pwd`/.bash_profile
