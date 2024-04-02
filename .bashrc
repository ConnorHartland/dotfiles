# Set up environment variables
export EDITOR='nvim'
export TERM='xterm-256color'
export PATH="$HOME/bin:$PATH"

# Enable color support for ls
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
fi

parse_git_branch() {
	git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\]$(parse_git_branch)\[\033[00m\]\$ '

# Enable color support for grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Set up aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gs='git status'
alias ga='git add'
alias gc='git commit'

# Custom function to make directory and change into it
mkcd() {
	mkdir -p "$@" && cd "$_"
}

# Define a custom prompt
if [ "$SSH_CONNECTION" ]; then
	PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

# Echo current time on login
echo "Current time: $(date)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
