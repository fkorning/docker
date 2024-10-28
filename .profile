# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.2-4

# ~/.profile: executed by the command interpreter for login shells.


export PROFILE=1

if [ -f ~/.bashrc ]; then
  if [ -z "${BASHRC}" ]; then
    . ~/.bashrc
  fi
fi

if [ -f ~/.bash_profile ]; then
  if [ -z "${BASH_PROFILE}" ]; then
    . ~/.bash_profile
  fi
fi

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.profile

# Modifying /etc/skel/.profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benificial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .profile file

# Set user-defined locale
export LANG=$(locale -uU)

# Set TERM=cygwin for colours in cygwin mntty shell
if [ "$TERM" != "cygwin" ]; then
  export TERM=cygwin
fi
alias ls='ls --color=auto'


# This file is not read by bash(1) if ~/.bash_profile or ~/.bash_login
# exists.
#
# if running bash

if [ -f "${HOME}/.ssh.bash" ]; then
  . "${HOME}/.ssh.bash"
fi


if [ -f "${USERPROFILE}/.docker.bash" ]; then
  . "${USERPROFILE}/.docker.bash"
fi


#
# docker test container service aliases 
#
export RABBIT_HOST=rabbit

export MONGO_HOST=mongo
#export REDIS_HOST=redis
#export SCYLLA_HOST=scylla
#export CASSANDRA_HOST=cassandra

export MYSQL_HOST=mysql
export MYSQL_USER=mysql
export MYSQL_USERNAME=root



# Ruby
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

env | grep DOCKER

