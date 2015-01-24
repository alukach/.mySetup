#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

    if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
        source /usr/local/bin/virtualenvwrapper.sh
    fi
fi

if [[ $platform == 'mac' ]]; then
    export PATH=/usr/local/Cellar:$PATH
    export PATH=/usr/local/bin:$PATH
    export PATH=/usr/local/sbin:$PATH

    # Ruby
    export PATH=$PATH:/usr/local/opt/ruby/bin

    # Postgresql
    export PGDATA=/usr/local/var/postgres

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

    # VirtualEnvWrapper
    export WORKON_HOME=$HOME/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
    export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_RESPECT_VIRTUALENV=true

    if [[ -r /usr/local/share/python/virtualenvwrapper.sh ]]; then
        source /usr/local/share/python/virtualenvwrapper.sh
    elif [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
        source /usr/local/bin/virtualenvwrapper.sh
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

    # Bash completion for brew?
    if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
    fi

    function ssh-mount(){
        if hash sshfs 2>/dev/null; then
            mkdir /Volumes/$1
            sshfs anthony@$1:/ /Volumes/$1/
            echo /Volumes/$1/
        fi
    }

    alias restart_airplay='sudo pkill coreaudiod'

fi

# Bash completion for git
if [ -f ~/.git-prompt.sh ]; then
  . ~/.git-prompt.sh
fi


# aliases
alias cd..="cd .."
alias l="ls -lah"
alias ll='ls -alF'
alias la='ls -A'
alias lp="ls -p"
alias h=history
alias ramdisk='diskutil erasevolume HFS+ "ramdisk" `hdiutil attach -nomount ram://8165430`'
alias datafart='curl --data-binary @- datafart.com | xargs open'
alias reload='. $HOME/.bash_profile'
alias whatsmyip='curl -s icanhazip.com'
alias clean_pyc="find . -name '*.pyc' -exec rm {} \;"
alias clean_orig="find . -name '*.orig' -exec rm {} \;"
alias grep='grep --color --no-messages'
highlight() {
    ack-grep $1 --passthru
}

# django
alias pm="python manage.py"
alias pmrs="python manage.py runserver_plus"
alias pmsp="python manage.py shell_plus"
thermonucleardestruction() {
    dropdb $1 &&
    createdb $1 &&
    psql $1 -x -c "CREATE EXTENSION postgis;" &&
    psql $1 -x -c "CREATE EXTENSION hstore;"  &&
    python manage.py syncdb &&
    python manage.py migrate
}

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
alias g.a='git add --all'
alias g.rm='git rm'
alias g.m='git merge'
alias g.mv='git mv'
alias g.d='git diff'
alias g.b='git branch'
alias g.bi='git bisect'
alias g.ps='git push'
alias g.pl='git pull'
alias g.cm='git commit -m'
alias g.co='git checkout'
alias g.reset='git reset HEAD'
alias g.chout='git checkout --'
alias g.f='git fetch origin'
alias g.t='git tag'
g.retag() {
  git tag -d $1 &&
  git tag $1
}
g.retag_remote() {
  git tag -d $1 &&
  git push origin :refs/tags/$1 &&
  git tag $1 &&
  git push --tags
}

# gist
# https://gist.github.com/caspyin/2288960
gist() {
    for arg
    do
        if [[ -z "$output" ]]; then
            output="{"
        else
            output="$output, "
        fi
        file=`cat $arg`
        # TODO: NEED TO SANITIZE FILE
        output="$output\"$arg\":{\"content\":\"$file\"}"
    done
    output="$output}"
    payload="{\"description\":\"Created via API\",\"public\":\"true\",        \"files\":$output}"
    #echo $payload | json_pp

    curl --data "$payload" https://api.github.com/gists | python -c 'import sys, json; print json.load(sys.stdin)[sys.argv[1]]'      "html_url"
    output=''
}
# mercurial
alias h.s='hg status'
alias h.a='hg add'
alias h.rm='hg remove'
alias h.pl='hg pull'
alias h.ps='hg push'
alias h.cm='hg commit'
alias h.b='hg branch'
alias h.d='hg diff'
alias h.mv='hg mv'

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

# Generic SQL runner for PSQL
pg_sql_runner() {
    echo " COMMAND"
    echo "------------------"
    echo -e ' ' $1 '\n'

    echo $1 | psql
}
# Drop connections to DB (Only works for Postgresql 9.2+
pg_killdbcnxn() {
    pg_sql_runner "SELECT pg_terminate_backend(pg_stat_activity.procpid)
          FROM pg_stat_activity
          WHERE pg_stat_activity.datname = '$1'"
}
# View activity of all DBs
pg_activity() {
    pg_sql_runner "SELECT datname,procpid,current_query FROM pg_stat_activity;"
}

# Pretty print JSON. To be piped to, such as: echo '{"foo": "lorem", "bar": "ipsum"}' | prettyjson
alias purtyjson='python -m json.tool'

# Import local settings (i.e. things not to be placed on Github)
if [[ -a $HOME/.local_bash_profile ]]; then
    . $HOME/.local_bash_profile
fi
alias pythong='open "http://www.pythong.com"'

##########################################################
#
# STANDARD BASHRC BIZ...
#
##########################################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

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
    get_sha() {
      git rev-parse --short HEAD 2>/dev/null
    }

    # ANSI color codes
    RS="\[\033[0m\]"    # reset
    HC="\[\033[1m\]"    # hicolor
    UL="\[\033[4m\]"    # underline
    INV="\[\033[7m\]"   # inverse background and foreground
    FBLK="\[\033[30m\]" # foreground black
    FRED="\[\033[31m\]" # foreground red
    FGRN="\[\033[32m\]" # foreground green
    FYEL="\[\033[33m\]" # foreground yellow
    FBLE="\[\033[34m\]" # foreground blue
    FMAG="\[\033[35m\]" # foreground magenta
    FCYN="\[\033[36m\]" # foreground cyan
    FWHT="\[\033[37m\]" # foreground white
    BBLK="\[\033[40m\]" # background black
    BRED="\[\033[41m\]" # background red
    BGRN="\[\033[42m\]" # background green
    BYEL="\[\033[43m\]" # background yellow
    BBLE="\[\033[44m\]" # background blue
    BMAG="\[\033[45m\]" # background magenta
    BCYN="\[\033[46m\]" # background cyan
    BWHT="\[\033[47m\]" # background white

    GIT_PS1_SHOWDIRTYSTATE=1      # Unstaged (*) and staged (+) changes will be shown next to the branch
    GIT_PS1_SHOWSTASHSTATE=       # If something is stashed, then a '$' will be shown next to the branch name
    GIT_PS1_SHOWUNTRACKEDFILES=1  # If there're untracked files, then a '%' will be shown next to the branch name

    # Explicitly unset color (default anyhow). Use 1 to set it.
    GIT_PS1_SHOWCOLORHINTS=1
    GIT_PS1_DESCRIBE_STYLE="branch"
    GIT_PS1_SHOWUPSTREAM=   # If difference between HEAD and its upstream, "<" indicates you are behind, ">" indicates you are ahead, "<>" indicates you have diverged and "=" indicates that there is no difference

    status_face="\`if [ \$? = 0 ]; then echo ${FGRN}^_^; else echo ${FRED}O_O; fi\`${RS}"
    git_branch="${FMAG}\$(__git_ps1 ' {%s $(get_sha)}')${RS}"
    user_machine="${HC}${FGRN}\u@\H${RS}"
    rel_path="${HC}${FBLE}\w${RS}"

    PS1="${user_machine}:${rel_path}${git_branch}\n${status_face}${RS} \\$ "
    PS2="  ... "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
