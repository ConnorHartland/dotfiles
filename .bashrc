# Set a custom prompt
PS1=' @\h:\w\$ '

export EDITOR='nvim'
export TERM='xterm-256color'
export PATH="$HOME/bin:$PATH"

function mkcd() {
	mkdir -p "$@" && cd "$_";
}

# Enable color support for ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Enable color support for grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable Bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Set up aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gs='git status'
alias ga='git add'
alias gc='git commit'

# Set up environment variables
export EDITOR='nvim'
export PATH="$HOME/bin:$PATH"

# Custom functions
function mkcd() {
  mkdir -p "$@" && cd "$_";
}
