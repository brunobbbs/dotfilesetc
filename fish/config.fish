# path
set -g -x PATH /usr/local/bin $PATH 
set -g -x fish_greeting ''

# golang
set -g -x  GOPATH $HOME/go
set -g -x  GOROOT /usr/local/opt/go/libexec
set -g -x  PATH $GOPATH/bin $GOROOT/bin $PATH

# general purpose scripts
set -x PATH $HOME/bin $PATH
for dir in (basename (find $HOME/bin/ -type d -depth 1))
    set -x PATH $HOME/bin/$dir $PATH
end

# pyenv
# set -xg PYENV_ROOT $HOME/.pyenv
# set -xg PATH $PYENV_ROOT/bin $PATH

# Load aliases
source $HOME/.config/fish/aliases.fish

# Python stuff
set -xg PYTHONDONTWRITEBYTECODE 1  # Don't write bytecode files everywhere

# eval (python -m virtualfish)
