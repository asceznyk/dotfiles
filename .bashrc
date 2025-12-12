# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

parse_git_branch() {
  git branch 2> /dev/null | sed -n -e "s/^\* \(.*\)/[\1] \xe2\x86\x92 /p"
}

PS1=$'\[\033[01;37m\]$(parse_git_branch)\[\033[01;34m\]${debian_chroot:+($debian_chroot)}[\w]\[\033[00m\]# ' 

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=/usr/lib/node-v14.15.4-linux-x64/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

#. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

alias nv="nvim"

export LOCAL_MOUNT_PATH="/home/aris/code/remote"

export EC2_SUPERCHAT="i-097082b9763aa09d5"
export EC2_DIAGENE="i-0d633b20acc2fc58e"
export GCPVM_DIAGENE="gcp-instance-20251111-111040"
export AWS_KEY="/home/aris/.ssh/awsx.pem"
export REMOTE_MOUNT_PATH="/home/ubuntu"

function start_ec2() {
  aws ec2 start-instances --instance-ids=$1 | jq
}

function stop_ec2() {
  aws ec2 stop-instances --instance-ids=$1 | jq
}

function get_ec2_addr() {
  aws ec2 describe-instances \
    --instance-ids "$1" \
    --query="Reservations[0].Instances[0].PublicIpAddress" \
    --output=text
}

function ec2ssh() {
  local addr=$(get_ec2_addr "$1")
  echo "connecting to $addr .."
  ssh -i "$AWS_KEY" -o IdentitiesOnly=yes ubuntu@"$addr"
}

function ec2_rclone_update() {
  local rclone_conf="$HOME/.config/rclone/rclone.conf"
  local new_ip=$(get_ec2_addr "$1")
  echo "Updating host for [$1] to $new_ip"
  awk -v remote="[$1]" -v new_ip="$new_ip" '
  $0 == remote { in_remote=1; print; next }
  in_remote && /^host =/ { print "host = " new_ip; in_remote=0; next }
  { print }
  ' "$rclone_conf" > "$rclone_conf.tmp" && mv "$rclone_conf.tmp" "$rclone_conf"
  echo "rclone.conf updated successfully!"
}

function ec2mount() {
  ec2_rclone_update "$1" &&
  nohup rclone mount \
    "$1":$2 "$3" \
    --vfs-cache-mode full \
    --vfs-cache-max-age 1m \
    --dir-cache-time 5s \
    -v & 
}

function gcp_mount() {
  nohup rclone mount \
    "$1":$2 "$3" \
    --vfs-cache-mode full \
    --vfs-cache-max-age 1m \
    --dir-cache-time 5s \
    -v & 
}

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  eval "$(ssh-agent -s)" >/dev/null
fi




