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

echo "#! Installing Python..."
sudo apt-get -y install python-dev python-setuptools build-essential python-virtualenv # Python Module installers

echo "#! Installing Postgres..."
sudo apt-get -y install postgresql postgresql-server-dev-all

echo "#! Installing PostGIS requirements..."
sudo apt-get install libxml2-dev proj libjson0-dev xsltproc docbook-xsl docbook-mathml libgdal1-dev libxslt-dev

echo "#! Installing common dev libraries..."
sudo apt-get -y install libgeos-dev # Needed for a lot of python packages (ex. Twisted)

sudo pip install ipython virtualenvwrapper
