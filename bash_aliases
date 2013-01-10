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
alias c='clear'                           # clear screen
#alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""' # get xprop CLASS and NAME
alias se='sudo emacs'                       # lazy
alias grep='grep --color=auto'            # colourized grep
alias egrep='egrep --color=auto'          # colourized egrep
alias pgrep='ps aux | grep -v grep | grep'  # search process
alias fixres="xrandr --size 1680x1050"    # reset resolution
alias clam='clamscan --bell -i'           # clamav scan a file
alias clamt='clamscan -r --bell -i ~/tmp' # clamav scan ~/tmp
alias getip='wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1'
alias psm="echo '%CPU %MEM   PID COMMAND' && ps hgaxo %cpu,%mem,pid,comm | sort -nrk1 | head -n 10 | sed -e 's/-bin//' | sed -e 's/-media-play//'"
#unalias -a               # uncomment to unalias everything 

# if exists, load bash functions from .bash_functions
if [ -x ~/.bash_functions ]; then
    source ~/.bash_functions
fi