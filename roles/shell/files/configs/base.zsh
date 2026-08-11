# The login nodes use their own special prompt
setopt prompt_subst
setopt auto_pushd
setopt multios
setopt long_list_jobs
setopt interactive_comments

setopt appendhistory
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
HISTORY_SUBSTRING_SEARCH_PREFIXED=true
HISTFILE=~/.zsh_history
HISTSIZE=25000
SAVEHIST=2500

PROMPT='%F{green}%*%f %F{magenta}${(%):-%m}%f %F{blue}%~%f $ '

if command -v direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi

if command -v rbenv > /dev/null; then
    eval "$(rbenv init - --no-rehash zsh)"
fi

# Force emcas (default) over vim
bindkey -e

# Antidote requires a ZSH >= 5.01
if [[ "$(echo $ZSH_VERSION | awk -F. '{ printf("%d%03d", $1,$2)}')" -ge 5001 ]]; then

    # Tell Spaceship where to load the configuration from
    export SPACESHIP_CONFIG="${HOME}/.shell.d/spaceship.zsh"
    if [[ -f "${HOME}/.shell.d/custom_spaceship_plugins.zsh" ]]; then
        source "${HOME}/.shell.d/custom_spaceship_plugins.zsh"
    fi

    # Setup Antidote and it's plugins
    zsh_plugins=$HOME/.shell.d/zsh_plugins
    zsh_plugins_path=$HOME/.shell.d/plugins/$HOSTNAME.zsh

    fpath=($HOME/.shell.d/antidote/functions $fpath)
    autoload -Uz antidote

    if ! [[ -d $HOME/.shell.d/plugins ]]; then
        mkdir $HOME/.shell.d/plugins
    fi

    if ! [[ -f $zsh_plugins_path ]]; then
        antidote bundle <$zsh_plugins >| $zsh_plugins_path
    fi

    source $zsh_plugins_path
    export HASANTIDOTE=true

fi

# Saving my home folder from all the ZCompDumps
if [[ ! -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump/" ]]; then
    mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump/"
fi
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump/${HOSTNAME}-${ZSH_VERSION}"
