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

# Force emcas (default) over vim
bindkey -e

# Powerlevel10k and Antidote requires a ZSH >= 5.01
if [[ "$(echo $ZSH_VERSION | awk -F. '{ printf("%d%03d", $1,$2)}')" -ge 5001 ]]; then

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

    # Required for instantaneous prompt
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    if [[ "$TERM" = "linux" ]]; then
        source "$HOME/.shell.d/p10k_fb_configuration"
    else
        source "$HOME/.shell.d/p10k_xterm_configuration"
    fi
fi

# Add support for iterm2 if the system has it installed
if [ -f "${HOME}/.iterm2_shell_integration.zsh" ]; then
    source "${HOME}/.iterm2_shell_integration.zsh"
fi

# Saving my home folder from all the ZCompDumps
if [[ ! -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump/" ]]; then
    mkdir "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump/"
fi
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump/${HOSTNAME}-${ZSH_VERSION}"
