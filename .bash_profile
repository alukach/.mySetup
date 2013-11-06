#!/bin/bash

# .bash_profile is typically run when you login (type username 
# and password) via console, either sitting at the machine or
# via ssh.
#
# An exception to the terminal window guidelines is Mac OS X’s
# Terminal.app, which runs a login shell by default for each
# new terminal window, calling .bash_profile instead of .bashrc
#
# http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html

# Source .bashrc
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
