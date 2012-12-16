#!/bin/bash

# sc - gnu screen function
# usage: lists screen sessions, otherwise
#        sc <name> reattaches to <name>, otherwise
#        sc <name> creates a new session <name>.
sc ()
{
  if [[ $1 ]]; then
    screen -dRR -S $HOSTNAME.$1
  else
    screen -ls
  fi
}


# nohup - run command detached from terminal and without output
# usage: nh <command>
nh()
{
  nohup "$@" &>/dev/null &
}

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       rar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# roll - archive wrapper
# usage: roll <foo.tar.gz> ./foo ./bar
roll ()
{
  FILE=$1
  case $FILE in
    *.tar.bz2) shift && tar cjf $FILE $* ;;
    *.tar.gz) shift && tar czf $FILE $* ;;
    *.tgz) shift && tar czf $FILE $* ;;
    *.zip) shift && zip $FILE $* ;;
    *.rar) shift && rar $FILE $* ;;
  esac
}

# mktar - tarball wrapper
# usage: mktar <filename | dirname>
function mktar() { tar czf "${1%%/}.tar.gz" "${1%%/}/"; }

# calc - simple calculator
# usage: calc <equation>
function calc() { echo "$*" | bc; }

# define - fetch word defnition from google
# usage: define <word>
define ()
{
  lynx -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 5 -w "*"  | sed 's/;/ -/g' | cut -d- -f5 > /tmp/templookup.txt
  if [[ -s  /tmp/templookup.txt ]] ;then    
    until ! read response
      do
      echo "${response}"
      done < /tmp/templookup.txt
    else
      echo "Sorry $USER, I can't find the term \"${1} \""                
  fi    
  rm -f /tmp/templookup.txt
}


# search the vim reference manual for a keyword
# usage: :h <keyword>
#:h() {  vim --cmd ":silent help $@" --cmd "only"; }

# mkmine - recursively change ownership to $USER:$USER
# usage:  mkmine, or
#         mkmine <filename | dirname>
function mkmine() { sudo chown -R ${USER}:${USER} ${1:-.}; }

# sanitize - set file/directory owner and permissions to normal values (644/755)
# usage: sanitize <file>
sanitize()
{
  chmod -R u=rwX,go=rX "$@"
  chown -R ${USER}:users "$@"
}


# start, stop, restart, reload - simple daemon management
# usage: start <daemon-name>
start()
{
  for arg in $*; do
    sudo service $arg start
  done
}
stop()
{
  for arg in $*; do
    sudo service $arg stop
  done
}
restart()
{
  for arg in $*; do
    sudo service $arg restart
  done
}
reload()
{
  for arg in $*; do
    sudo service $arg reload
  done
}
status()
{
    foo=$*
    for arg in $*; do
	foo=$foo"|"$arg
    done
    service --status-all 2>&1 | grep -Ei --color $foo
    
}

initstart()
{
  for arg in $*; do
    sudo /etc/rc.d/$arg start
  done
}
initstop()
{
  for arg in $*; do
    sudo /etc/rc.d/$arg stop
  done
}
initrestart()
{
  for arg in $*; do
    sudo /etc/rc.d/$arg restart
  done
}
initreload()
{
  for arg in $*; do
    sudo /etc/rc.d/$arg reload
  done
}

# remind me, its important!
# usage: remindme <time> <text>
# e.g.: remindme 10m "omg, the pizza"
function remindme()
{
    nh sleep $1 2>&1>/dev/null &&
    echo "$2" | notifo --title "Don't forget to.. " ayd 2>&1>/dev/null
}