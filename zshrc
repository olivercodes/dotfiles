export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git tmux vi-mode golang gulp pass docker yarn terraform kubectl)
source $ZSH/oh-my-zsh.sh
ZSH_DISABLE_COMPFIX=true

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
DEFAULT_USER="$USER"
SPACESHIP_BATTERY_SHOW=true
SPACESHIP_BATTERY_THRESHOLD=100

# export JAVA_HOME=/usr/local/opt/openjdk@11

javamon() {
  nodemon -e java -w src -x 'javac --class-path ./src -d ./bin src/**/'$1'.java; java -XX:ErrorFile=/var/log/java/java_error%p.log --class-path ./bin -XX:ErrorFile=java.log '$1 
}

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Set the display value for x forwarding
export DISPLAY=:0

# ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="false"

# Android Setup
ANDROID_HOME=/Users/bo300646/Library/Android/sdk/tools:/Users/bo300646/Library/Android/sdk/platform-tools:/Users/bo300646/Android/sdk/build-tools
PATH=$ANDROID_HOME:$PATH

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/

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
alias    k=kubectl
alias    tf=terraform
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

autoload -U +X bashcompinit && bashcompinit
export PATH=$HOME/.service-mesh-hub/bin:$PATH

complete -o nospace -C /usr/local/bin/terraform terraform
compdef tf='terraform'
setopt complete_aliases
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# eval "$(pyenv init -)"
# symlink;

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# The next line updates PATH for the Google Cloud SDK.
if [ -f "/Users/$USER/tools/google-cloud-sdk/path.zsh.inc" ]; then . "/Users/$USER/tools/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "/Users/$USER/tools/google-cloud-sdk/completion.zsh.inc" ]; then . "/Users/$USER/tools/google-cloud-sdk/completion.zsh.inc"; fi

[ -s "/Users/$USER/.jabba/jabba.sh" ] && source "/Users/a6277/.jabba/jabba.sh"
