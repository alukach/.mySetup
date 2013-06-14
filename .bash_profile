#!/bin/bash

#Check OS
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='mac'
elif [[ "$unamestr" == 'Debian' ]]; then
   platform='debian'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
fi

if [[ $platform == 'linux' ]]; then
    export WORKON_HOME=$HOME/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_RESPECT_VIRTUALENV=true
    
    source /usr/local/bin/virtualenvwrapper.sh
fi

# Rearrange Python path to point to newer Python install (http://www.thisisthegreenroom.com/2011/installing-python-numpy-scipy-matplotlib-and-ipython-on-lion/)
if [[ $platform == 'mac' ]]; then
    export PATH=/usr/local/Cellar:$PATH
    export PATH=/usr/local/bin:$PATH
    export PATH=/usr/local/sbin:$PATH
    export PATH=/usr/local/share/python:$PATH

    PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
    export PYTHONPATH

    # Mac Colors
    export CLICOLOR=1
    export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

    # EC2
    if [ -d "$HOME"/.ec2/ ]; then
        export JAVA_HOME="$(/usr/libexec/java_home)"
        export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
        export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
        export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
    fi

    #VirtualEnvWrapper
    # Setting up the VirtualEnv
    export WORKON_HOME=$HOME/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_RESPECT_VIRTUALENV=true

    if [[ -r /usr/local/share/python/virtualenvwrapper.sh ]]; then
        source /usr/local/share/python/virtualenvwrapper.sh
    else
        echo "WARNING: Can't find virtualenvwrapper.sh"
    fi

    # Tree Utility
    function tree(){
      ls -R $1 | grep ":" | sed -e 's/://' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/';
    }
    function fulltree(){
      find $1 -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
    }
fi


# aliases
alias cd..="cd .."
alias l="ls -lah"
alias lp="ls -p"
alias h=history
alias ramdisk='diskutil erasevolume HFS+ "ramdisk" `hdiutil attach -nomount ram://8165430`'
alias datafart='curl --data-binary @- datafart.com | xargs open'
alias reload='. $HOME/.bash_profile'
#alias grep='grep --color --line-number --no-messages'

# django
alias pm="python manage.py"

# virtualenv aliases
# http://blog.doughellmann.com/2010/01/virtualenvwrapper-tips-and-tricks.html
alias v='workon'
alias v.deactivate='deactivate'
alias v.mk='mkvirtualenv --no-site-packages'
alias v.mk_withsitepackages='mkvirtualenv'
alias v.rm='rmvirtualenv'
alias v.switch='workon'
alias v.add2virtualenv='add2virtualenv'
alias v.cdsitepackages='cdsitepackages'
alias v.cd='cdvirtualenv'
alias v.lssitepackages='lssitepackages'

# git
alias g.s='git status'
alias g.a='git add'
alias g.rm='git rm'
alias g.d='git diff'
alias g.b='git bisect'
alias g.ps='git push'
alias g.pl='git pull'
alias g.cm='git commit -m'
alias g.co='git checkout'
alias g.reset='git reset HEAD'
alias g.chout='git checkout --'

# CD is now silent pushd
cd()
{
  if [ $# -eq 0 ]; then
    DIR="${HOME}"
  else
    DIR="$1"
  fi

  builtin pushd "${DIR}" > /dev/null
}
# Take you back without popd
back()
{
  builtin pushd > /dev/null
  dirs
}
alias p='popd'
alias b='back' 

# Drop connections to DB
killdbcnxn() {
    echo "Dropping all active connections to $1"
    echo "SELECT pg_terminate_backend(pg_stat_activity.pid)
          FROM pg_stat_activity
          WHERE pg_stat_activity.datname = '$1'" | psql
}

#if [ -f `brew --prefix`/etc/bash_completion ]; then
#  . `brew --prefix`/etc/bash_completion
#fi

# Colors ---Take from .bashrc

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# Import local settings (i.e. things not to be placed on Github)
if [[ -a $HOME/.local_bash_profile ]]; then
    . $HOME/.local_bash_profile
fi
alias pythong='open "http://www.pythong.com"'
