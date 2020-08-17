#!/bin/zsh

# enable colors
autoload -U colors && colors

setopt AUTO_CD        # if a command is issued that can’t be executed as a normal command, and the command is the name of a directory, perform the cd command to that directory.
setopt PROMPT_SUBST   # parameter expansion, command substitution and arithmetic expansion are performed in prompts
setopt EXTENDED_GLOB  # treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns for filename generation, etc.

# shell history
HISTSIZE=1000000000   # the number of lines the shell will keep within one session 
SAVEHIST=1000000000   # the number of lines of your history we want saved
HISTFILE=$HOME/.zsh_history   # the path to the file where the history is stored

setopt SHARE_HISTORY       # share history across multiple zsh sessions
setopt NO_HIST_BEEP        # scroll up or down beyond the end of the history list, the shell will NOT beep
setopt INC_APPEND_HISTORY  # each line is added to the history in this way as it is executed
setopt HIST_IGNORE_DUPS    # do not store a history line if it's the same as the previous one
setopt HIST_FIND_NO_DUPS   # searches backwards with editor commands don't show commands more than once
setopt HIST_REDUCE_BLANKS  # removes blank lines from history

# terminal colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# prompt
[[ -a /usr/local/etc/bash_completion.d/git-prompt.sh ]] && source /usr/local/etc/bash_completion.d/git-prompt.sh
GIT_PS1_SHOWUPSTREAM="git"
GIT_PS1_SHOWDIRTYSTATE=true
export RPROMPT=$'$(__git_ps1 "%s")'
export PROMPT="%{$fg[red]%}%~ %#%{$reset_color%} "

# basic auto/tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1
set editing-mode vi
set blink-matching-paren on

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# terminal settings
export TERM=xterm-256color
export LANG="en_US.UTF-8"
export LC_ALL=$LANG
export LC_COLLATE="C"

# editors and display options
export GREP_OPTIONS='--color=auto'
export EDITOR='nvim'
export VISUAL='nvim'
export MYVIMRC=$HOME/.config/nvim/init.vim

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
export PATH=$HOME/bin:/usr/local/opt/llvm/bin:/usr/local/sbin:$GOPATH/bin:$GOROOT/bin:$PATH
export CDPATH=.:$HOME:$GOPATH/src:$HOME/Projects

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

# passwords
[[ -a $HOME/.access ]] && source $HOME/.access

# helpers
[[ -a /usr/local/bin/virtualenvwrapper.sh ]] && source /usr/local/bin/virtualenvwrapper.sh
[[ -a /usr/libexec/path_helper ]] && eval `/usr/libexec/path_helper -s`

# fuzzy search
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag -g ""'

# aliases
alias g=git
alias brw=brew
alias ll='ls -alph'
alias scp='noglob scp'
alias gorun='go run $(find . -name "*.go" -and -not -name "*_test.go" -maxdepth 1)'
alias gorace='go run -race $(find . -name "*.go" -and -not -name "*_test.go" -maxdepth 1)'
alias tf=terraform
alias vim=nvim
alias vi=nvim
alias nb=newsboat
alias nm=neomutt
alias dc=docker-compose
alias dce='docker-compose exec'
alias py3=python3
alias py2=python2

autoload -U +X bashcompinit && bashcompinit

# hashicorp
export VAULT_ADDR=http://127.0.0.1:8200
complete -o nospace -C /usr/local/bin/terraform terraform
complete -o nospace -C /usr/local/bin/vault vault
complete -o nospace -C /usr/local/bin/nomad nomad
complete -o nospace -C /usr/local/bin/consul consul

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
