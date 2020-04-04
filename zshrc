#!/bin/zsh

# global zsh settings
autoload -Uz compinit && compinit
autoload -U colors && colors
setopt prompt_subst
setopt extended_glob

# terminal colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# prompt
[[ -a /usr/local/etc/bash_completion.d/git-prompt.sh ]] && source /usr/local/etc/bash_completion.d/git-prompt.sh
GIT_PS1_SHOWUPSTREAM="git"
GIT_PS1_SHOWDIRTYSTATE=true
export RPROMPT=$'$(__git_ps1 "%s")'
export PROMPT="%{$fg[red]%}%~ %#%{$reset_color%} "

# terminal settings
export TERM=xterm-256color
export LANG="en_US.UTF-8"
export LC_ALL=$LANG
export LC_COLLATE="C"

# editors and display options
export GREP_OPTIONS='--color=auto'
export EDITOR='nvim'
export VISUAL='nvim'
export MYVIMRC='~/.config/nvim/init.vim'

# homebrew
export HOMEBREW_NO_ANALYTICS=1

# c
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# golang settings
export GOPATH=$HOME/Projects/GOLANG
export GOROOT=/usr/local/opt/go/libexec
export GO15VENDOREXPERIMENT=1

# path settings
export PATH=/usr/local/opt/llvm/bin:/usr/local/sbin:$GOPATH/bin:$GOROOT/bin:$PATH
export CDPATH=.:~:$GOPATH/src:~/Projects

# virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=~/Projects
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

# passwords
[[ -a ~/.access ]] && source ~/.access

# helpers
[[ -a /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh
[[ -a /usr/libexec/path_helper ]] && eval `/usr/libexec/path_helper -s`

# fuzzy search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'

# aliases
alias g=git
alias brw=brew
alias ll='ls -alph'
alias scp='noglob scp'
alias gorun='go run $(find . -name "*.go" -and -not -name "*_test.go" -maxdepth 1)'
alias gorace='go run -race $(find . -name "*.go" -and -not -name "*_test.go" -maxdepth 1)'
alias vim=nvim
alias vi=nvim
alias dc=docker-compose
alias dce='docker-compose exec'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 

# opam configuration
#test -r /Users/bx2/.opam/opam-init/init.zsh && . /Users/bx2/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
