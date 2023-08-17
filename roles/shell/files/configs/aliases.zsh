alias ls="$LSCMD --color=auto --classify"
alias ll="ls -l"
alias la="ls -la"
alias lss="ls --group-directories-first"
alias lart="ls -1Fcart"
alias lrt="ls -1ARFh"
alias lsr="ls -lARFh"

alias p=popd
alias gt=git
alias grep="grep --color"

if command -v batcat &> /dev/null; then
    alias bat=batcat
fi
