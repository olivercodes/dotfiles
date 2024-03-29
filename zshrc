plugins=(git tmux golang docker terraform kubectl)
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS

javamon() {
  nodemon -e java -w src -x 'javac --class-path ./src -d ./bin src/**/'$1'.java; java -XX:ErrorFile=/var/log/java/java_error%p.log --class-path ./bin -XX:ErrorFile=java.log '$1 
}

export HISTSIZE=25000
export SAVEHIST="$HISTSIZE"
export HISTFILE="$HOME/.zsh_history"

export CLICOLOR="1"

export GPG_TTY=$(tty)

if [[ -n "$(command -v nvim)" ]]; then
    export EDITOR="nvim"
    export VISUAL="nvim"
    alias vim="nvim"
else
    export EDITOR="vim"
    export VISUAL="vim"
fi

export GOPATH="$HOME/go"
export VIRTUAL_ENV_DISABLE_PROMPT="1"

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
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey '^R' history-incremental-pattern-search-backward

if [[ -f ~/.gnupg/.gpg-agent-info ]] && [[ -n "$(pgrep gpg-agent)" ]]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    INFO=$(gpg-agent --daemon 2> /dev/null)
    eval $INFO
    echo $INFO > ~/.gnupg/.gpg-agent-info
fi

if [[ -d "$HOME/.nvm" ]]; then
    # https://github.com/creationix/nvm/issues/1277#issuecomment-345878237
    alias nvm='unalias nvm && source "$HOME"/.nvm/nvm.sh && nvm'
fi

alias ll="ls -alh"
alias l="ll"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias dc="docker-compose"
alias dcprod="docker-compose -f docker-compose.yml -f docker-compose.prod.yml"
alias df="df -h"
alias du="du -h"

if [[ -d "$GOROOT" ]]; then
    PATH="$GOROOT/bin:$PATH"
fi

if [[ -d "$GOPATH" ]]; then
    PATH="$GOPATH/bin:$PATH"
fi

if [[ -d "$HOME/bin" ]]; then
    PATH="$HOME/bin:$PATH"
fi

if [[ -d "$HOME/.rvm" ]]; then
    PATH="$HOME/.rvm/bin:$PATH"
fi

if [[ -d "$HOME/.cargo" ]]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

if [[ -d "$HOME/.yarn/bin" ]]; then
    PATH="$HOME/.yarn/bin:$PATH"
fi

if [[ -d "$HOME/Library/Android/sdk" ]]; then
    PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
    PATH="$HOME/Library/Android/sdk/emulator:$PATH"
fi

export fpath=( "$HOME/.zsh/autoload" $fpath )

autoload -Uz promptinit; promptinit
prompt pure

autoload -Uz compinit; compinit -u
COMPAUDIT_RESULT=$(compaudit 2> /dev/null)

complete -o nospace -C /usr/local/bin/terraform terraform
compdef tf='terraform'

if [[ -n "$COMPAUDIT_RESULT" ]]; then
  echo "\n[!] compaudit found insecure directories:"
  echo $COMPAUDIT_RESULT
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

source "$HOME/.zsh/tmux.zsh"
_Z_DATA=$HOME/.z.sh_data
source "$HOME/.z/z.sh"

if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
