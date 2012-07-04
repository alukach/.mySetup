#!/bin/bash

# Add Ubuntu-GIS repository. Install best of GIS apps
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable

# Update System
sudo apt-get update
sudo apt-get -y upgrade

# Create Backup Directory
mkdir ~/.scriptStartBackup

# Install Favorite Apps
sudo apt-get -y install dropbox # File synchronization
sudo apt-get -y install git git-core git-gui git-doc # Distributed Revision Control / Source Code Management
sudo apt-get -y install python-dev python-setuptools build-essential python-virtualenv # Python Module installers

sudo apt-get -y install postgresql postgresql-server-dev-all # Fave db
sudo apt-get -y install proj libgeos-dev libgdal-dev libxml2-dev libxslt-dev # Needed for a lot of python packages (ex. Twisted)
sudo apt-get -y install vim vim-doc

sudo apt-get -y install qgis
sudo apt-get -y install gnome-tweak-tool # More control about gnome's appearance
sudo apt-get -y install compiz compiz-plugins compizconfig-settings-manager # Additional window decoration
sudo apt-get -y install xclip # Easy copying from shell to clipboard
sudo apt-get -y install keepassx # Password storage
sudo apt-get -y install xchat # IRC Client
sudo apt-get -y install filezilla # FTP Client

sudo pip install ipython virtualenvwrapper
# Install Google Apps
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee -a /etc/apt/sources.list.d/google.list
sudo apt-get update
sudo apt-get -y install google-chrome-stable

# Generate SSH Keys - Done first so that you have time to register the key with Github and Bitbucket
if [ ! -e "~/.ssh/id_rsa.pub" ]; # If there are no keys created
then
  ssh-keygen -t rsa -C "anthonylukach@gmail.com" -N '' -f ~/.ssh/id_rsa # Generate key with no password, worried about the "-N ''" part, is password being set as the literal "''"?
fi
xclip -sel clip < ~/.ssh/id_rsa.pub # Copy key to clipboard
echo "SSH Key copied to the clipboard. Register this key with GitHub (https://github.com/settings/ssh) and BitBucket (https://bitbucket.org/account/user/alukach/ssh-keys/)"

# Setup Dropbox Folders
#sudo mv ~/Desktop ~/.scriptStartBackup
#sudo mv ~/Documents ~/.scriptStartBackup
#sudo mv ~/Pictures ~/.scriptStartBackup
#ln -s ~/Dropbox/Desktop ~/Desktop/Users/anthony/Dropbox/Documents
#ln -s ~/Dropbox/Documents ~/Documents
#ln -s ~/Dropbox/Photos ~/Pictures
#ln -s ~/Dropbox/Projects ~/Projects

# Install Windows Fonts
# http://www.oooninja.com/2008/01/calibri-linux-vista-fonts-download.html
sudo apt-get -y install msttcorefonts
sudo apt-get -y install cabextract
mkdir ~/.scriptStartBackup/WindowsFonts
cd ~/.scriptStartBackup/WindowsFonts
wget http://download.microsoft.com/download/f/5/a/f5a3df76-d856-4a61-a6bd-722f52a5be26/PowerPointViewer.exe
cabextract -F ppviewer.cab PowerPointViewer.exe
mkdir /usr/share/fonts/vista
sudo cabextract -F '*.TT?' -d /usr/share/fonts/vista ppviewer.cab
fc-cache -fv
rm -rf ~/.

# Setup Git
git config --global user.name "Anthony Lukach"
git config --global user.email "anthonylukach@gmail.com"
git config --global credential.helper 'cache --timeout=3600'

# Setup Vim
cd ~/
git clone git://github.com/alukach/.vim.git # read-only
ln -s ~/.vim/.vimrc ~/.vimrc

# Setup xchat
mv ~/.xchat2 ~/.scriptStartBackup
ln is ~/Dropbox/.Settings/.xchat2 ~/.xchat2

echo "Setup complete! The following backup files were created during the process:"
find ~/.scriptStartBackup
