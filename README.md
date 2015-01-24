mySetup Script Set
==================

These scripts set up a Desktop or Server version of Ubuntu with preferred software and settings.

To run setup scripts, copy and paste the following script into your home directory (`~/`), run `chmod a+x script.sh`, and then execute the script.  This will clone this repo, from which you can run either the `serverStartup.sh` or the `desktopStartup.sh` scripts.

    #!/bin/bash

    sudo apt-get -y update
    sudo apt-get -y upgrade

    if [ ! -e "~/.ssh/id_rsa.pub" ]; # If there are no keys created
    then
      ssh-keygen -t rsa -C "anthonylukach@gmail.com" -N '' -f ~/.ssh/id_rsa # Generate key with no password
    fi

    sudo apt-get -y install git git-core git-gui git-doc # Distributed Revision Control / Source Code Management

    git config --global user.name "Anthony Lukach"
    git config --global user.email "anthonylukach@gmail.com"
    git config --global credential.helper 'cache --timeout=3600'

    echo "Before we continue, register this key with your github account (https://github.com/settings/ssh), then press any key
    "
    cat ~/.ssh/id_rsa.pub
    read

    cd ~/
    git clone git@github.com:alukach/.mySetup.git
    ./.mySetup/setup.sh
