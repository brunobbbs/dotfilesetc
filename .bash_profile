export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export CLICOLOR="auto"

alias ls="ls -G"
alias ll="ls -l"
alias grep="grep --color=auto"

function parse_git_branch {
    git_branch=`git branch 2>/dev/null | grep -e '^*' | sed -E 's/^\* (.+)$/(\1) /'`
        echo $git_branch
}

RED="\[\033[1;31m\]"
GREEN="\[\033[1;32m\]"
YELLOW="\[\033[1;33m\]"
CLR_END="\[\033[0m\]"
export PS1="$GREEN\u$CLR_END@$YELLOW\W$RED\$(parse_git_branch)$CLR_END$ "

function _makefile_targets {
    local curr_arg;
    local targets;

    # Find makefile targets available in the current directory
    targets=''
    if [[ -e "$(pwd)/Makefile" ]]; then
        targets=$( \
            grep -oE '^[a-zA-Z0-9_-]+:' Makefile \
            | sed 's/://' \
            | tr '\n' ' ' \
        )
    fi

    # Filter targets based on user input to the bash completion
    curr_arg=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "${targets[@]}" -- $curr_arg ) );
}
complete -F _makefile_targets make

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

export PATH=$PATH:$HOME/bin

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source ~/.profile
