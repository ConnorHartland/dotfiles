# Set a custom prompt
PS1=' @\h:\w\$ '

# Set up aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Set up environment variables
export EDITOR='nvim'
export PATH="$HOME/bin:$PATH"

# Custom functions
function mkcd() {
  mkdir -p "$@" && cd "$_";
}
