ZSH_DISABLE_COMPFIX=true
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"
DEFAULT_USER="$USER"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="false"

# Android Setup
ANDROID_HOME=/Users/bo300646/Library/Android/sdk/tools:/Users/bo300646/Library/Android/sdk/platform-tools:/Users/bo300646/Android/sdk/build-tools
PATH=$ANDROID_HOME:$PATH

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git tmux vi-mode heroku golang gulp pass docker docker-compose yarn terraform)

export GPGKEY=6B4B0C48

export EDITOR="vim"
export VISUAL="vim"

up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}

down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}

# bind to whatever keys you want for local-hist movement
bindkey '^p' up-line-or-local-history
bindkey '^n' down-line-or-local-history

zle -N up-line-or-local-history
zle -N down-line-or-local-history

umask 002
bindkey '^R' history-incremental-pattern-search-backward
bindkey -M viins 'jk' vi-cmd-mode

if [[ -f ~/.gnupg/.gpg-agent-info ]] && [[ -n "$(pgrep gpg-agent)" ]]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    INFO=$(gpg-agent --daemon)
    eval $INFO
    echo $INFO > ~/.gnupg/.gpg-agent-info
fi

export GOPATH=$HOME/go

export VIRTUAL_ENV_DISABLE_PROMPT='1'

if [[ -d "$HOME/.nvm" ]]; then
    source ~/.nvm/nvm.sh
fi

# shortcuts
if [[ -x "$(which nvim)" ]]; then
    alias vi=nvim
else
    alias vi=vim
fi

alias    ll="ls -alh"
alias    l="ll"
alias    ....="cd ../../.."
alias    .....="cd ../../../.."
alias    dc="docker-compose"
alias    df="df -h"
alias    du="du -h"
alias    nr="npm run --silent"
function vman() { man "$*" | vi -; }

function s() {
    if [[ -d "$PWD/venv" ]]; then
        source "$PWD/venv/bin/activate"
    fi

    if [[ -f "$PWD/.env" ]]; then
        source "$PWD/.env"
    fi
}

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

source $ZSH/oh-my-zsh.sh

if [[ -d "$GOROOT" ]]; then
    PATH=$GOROOT/bin:$PATH
fi

if [[ -d "$GOPATH" ]]; then
    PATH=$GOPATH/bin:$PATH
fi

if [[ -d "$HOME/bin" ]]; then
    PATH=$HOME/bin:$PATH
fi

if [[ -d "$HOME/.rvm" ]]; then
    PATH=$HOME/.rvm/bin:$PATH
fi

if [[ -d "$HOME/.cargo" ]]; then
    PATH=$HOME/.cargo/bin:$PATH
fi

#if [[ -d "$HOME/dev/tools/istio-1.5.1" ]]; then
#  PATH=$HOME/dev/tools/istio-1.5.1/bin:$PATH
#fi

autoload -U +X bashcompinit && bashcompinit

complete -o nospace -C /usr/local/bin/terraform terraform
compdef tf='terraform'
setopt complete_aliases
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias k=kubectl

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/a6277/dev/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/a6277/dev/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/a6277/dev/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/a6277/dev/google-cloud-sdk/completion.zsh.inc'; fi

echo -e "$(nvm use 12)"

eval "$(pyenv init -)"
