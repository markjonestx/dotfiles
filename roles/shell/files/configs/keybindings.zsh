# Navigate history
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Jump words
bindkey '^[[1;5C' forward-word
bindkey '^[^[[C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[^[[D' backward-word
