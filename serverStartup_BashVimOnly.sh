#!/bin/bash
# Server Startup Script
# Author: Anthony Lukach <anthonylukach@gmail.com>, <https://github.com/alukach>
# Description: Install the essentials to get my preferred server setup going
# Notes: Intended to be run after initial script included in Readme.md

# .backups folder
if [ ! -d "`cd $1; pwd`/.mySetup/.backups" ];
then
  echo "#! Creating .backups..."
  mkdir ~/.mySetup/.backups
fi

# Setup Vim
echo "#! Running setupVim.sh..."
`cd $1; pwd`/.mySetup/.subscripts/setupVim.sh

# Setup Bash
echo "#! Running setupBash.sh..."
`cd $1; pwd`/.mySetup/.subscripts/setupBash.sh
