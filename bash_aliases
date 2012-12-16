#!/bin/bash
alias hist='history | grep $1'            # search cmd history
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias ducks='du -cksh * |sort -rn |head -11' # disk hog
alias free='free -m'                      # show sizes in MB
alias ls='ls --color=auto -F'             # colourized list
alias ll='ls -lh'                         # list detailed with human-readable sizes
alias la='ls -a'                          # list all files
alias dir='ls -1'                         # windows-style list
alias f='find | grep'                     # quick search
alias cls='clear'                           # clear screen
#alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""' # get xprop CLASS and NAME
alias se='sudo emacs'                       # lazy
alias grep='grep --color=auto'            # colourized grep
alias egrep='egrep --color=auto'          # colourized egrep
alias pgrep='ps aux | grep -v grep | grep'  # search process
#alias fixres="xrandr --size 1680x1050"    # reset resolution
alias clam='clamscan --bell -i'           # clamav scan a file
alias clamt='clamscan -r --bell -i ~/tmp' # clamav scan ~/tmp
alias getip='wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1'
alias psm="echo '%CPU %MEM   PID COMMAND' && ps hgaxo %cpu,%mem,pid,comm | sort -nrk1 | head -n 10 | sed -e 's/-bin//' | sed -e 's/-media-play//'"
#unalias -a               # uncomment to unalias everything 



# sc - gnu screen function
# usage: lists screen sessions, otherwise
#        sc <name> reattaches to <name>, otherwise
#        sc <name> creates a new session <name>.
s()
{
  if [[ $1 ]]; then
    screen -dRR -S $HOSTNAME.$1
  else
    screen -ls
  fi
}


sc()
{
 screen -r
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