if [[ -z $commands[thefuck] ]]; then
    echo "No autocorrection"
    return 1
fi

fuck-command-line() {
    local FUCK="$(THEFUCK_REQUIRE_CONFIRMATION=0 thefuck $(fc -ln -1 | tail -n 1) 2> /dev/null)"
    [[ -z $FUCK ]] && echo -n -e "\a" && return
    BUFFER=$FUCK
    zle end-of-line
}
zle -N fuck-command-line
# Defined shortcut keys: [Esc] [Esc]
bindkey -M emacs '\e\e' fuck-command-line
bindkey -M vicmd '\e\e' fuck-command-line
bindkey -M viins '\e\e' fuck-command-line
