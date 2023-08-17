# Functions to make my life _slightly_ easier
show_status() {
    git status -s 2> /dev/null;
    ls;
}
chpwd_functions+=(show_status)

help() {
    "$@" --help 2>&1 | bat --plain --language=help
}

bdiff() {
    if [[ -n $1 ]]; then
        git diff --name-only --relative --diff-filter=d $1 | xargs bat --diff
    else
        git diff --name-only --relative --diff-filter=d | xargs bat --diff
    fi
}

fcd() {
    local dir
    if [[ -n $1 ]]; then
        if [[ -n $2 ]]; then
            dir=$(fd . $1 -t d --full-path | $PFZF -q $2 --prompt "Select directory: ")
        else
            dir=$(fd . $1 -t d --full-path | $PFZF --prompt "Select directory: ")
        fi
    else
        dir=$(fd -t d | $PFZF --prompt "Select directory: ")
    fi


    if [[ -n $dir ]]; then
        cd "$dir"
    else
        echo "Directory not found!"
    fi
}

fcdp() {
    fcd ~/Desktop $1
}

edit() {
    if [[ -f $1 ]]; then
        $EDITOR $1
    else
        if [[ -n $2 ]]; then
            dir=$(fd -t f $1 | $PFZF -q $2 --prompt "Select file: " --preview "bat --color=always --style=numbers --line-range :500 {}")
        else
            dir=$(fd -t f $1 | $PFZF --prompt "Select file: " --preview "bat --color=always --style=numbers --line-range :500 {}")
        fi

        if [[ -n $dir ]]; then
            $EDITOR $dir
        else
            echo "File not found!"
        fi
    fi
}
