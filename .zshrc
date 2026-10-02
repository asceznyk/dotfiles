HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000
setopt extendedglob nomatch notify
bindkey -v

zstyle :compinstall filename '/home/asceznyk/.zshrc'

autoload -Uz compinit
compinit

autoload -U colors && colors
parse_git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  print -r -- "[$branch] → "
}

setopt PROMPT_SUBST
PROMPT='%F{white}$(parse_git_branch)%f%F{blue}[%~]%f# '

alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias nv='nvim'

