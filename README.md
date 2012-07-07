mySetup Profile
=================

Server
------
Server startup script!  Copy the following script into a file, run `chmod a+x script.sh`, and run the script!

    sudo apt-get -y update
    sudo apt-get -y upgrade
    
    if [ ! -e "~/.ssh/id_rsa.pub" ]; # If there are no keys created 
    then 
      ssh-keygen -t rsa -C "anthonylukach@gmail.com" -N '' -f ~/.ssh/id_rsa # Generate key with no password, worried about the "-N ''" part, is password being set as the literal "''"? 
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
     
    # .backups folder 
    if [ -e "~/.mySetup/.backups" ]; 
    then 
      mkdir ~/.mySetup/.backups 
    fi 
     
    # .vimrc
    if [ -e "~/.vimrc" ]; # If there are no keys created
    then
      mv ~/.vimrc ~/.mySetup/.backups
    fi
    ln -s ~/.mySetup/.vim/.vimrc ~/.vimrc

    # .bashrc
    if [ -e "~/.bashrc" ];
    then
      mv ~/.bashrc ~/.mySetup/.backups
    fi
    ln -s ~/.mySetup/.bashrc ~/

    # .bash_profile
    if [ -e "~/.bash_profile" ];
    then
      mv ~/.bash_profile ~/.mySetup/.backups
    fi
    ln -s ~/.mySetup/.bash_profile ~/

Desktop
-------

Run desktopStartup.sh script!
