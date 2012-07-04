mySetup Profile
=================

Server
------
Server startup script!  Copy the following script into a file, run `chmod a+x script.sh`, and run the script!

    # Generate keys
    if [ ! -e "~/.ssh/id_rsa.pub" ]; # If there are no keys created
    then
      ssh-keygen -t rsa -C "anthonylukach@gmail.com" -N '' -f ~/.ssh/id_rsa # Generate key with no password, worried about the "-N ''" part, is password being set as the literal "''"?
    fi
    
    echo "Before we continue, register this key with your github account (https://github.com/settings/ssh), then press any key
    "
    cat ~/.ssh/id_rsa.pub
    read
    
    cd ~/
    git clone git@github.com:alukach/.mySetup.git
    
    if [ -e "~/.mySetup/backups" ];
    then
      mkdir ~/.mySetup/backups
    fi
    
    if [ -e "~/.vimrc" ]; # If there are no keys created
    then
      mv ~/.vimrc ~/.mySetup/backups
    fi
    ln -s ~/.mySetup/.vim/.vimrc ~/.vimrc
    
    if [ -e "~/.bash_profile" ];
    then
      mv ~/.bash_profile ~/.mySetup/backups
    fi
    ln -s ~/.mySetup/.bash_profile


Desktop
-------

Run desktopStartup.sh script!
