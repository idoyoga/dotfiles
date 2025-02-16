# Set Zsh as the default shell
export SHELL=$(which zsh)

# Enable Starship prompt
eval "$(starship init zsh)"

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory

# Aliases
alias ccc='cc -Wall -Wextra -Werror -g'
alias cf='cc -Werror -Wall -Wextra'
alias vgf='valgrind --leak-check=full --show-leak-kinds=all --trace-children=yes --track-fds=yes'
alias vg='valgrind'
alias fch='funcheck'
alias nor='norminette -R CheckForbiddenSourceHeader'
alias ll='ls -l'
alias lla='ls -al'
alias c='clear'
alias gst='git status'
alias gp='git push'
alias gl='git log'
alias gc='git commit -m'
alias ga='git add .'
alias gac='git add . && git commit -m'
alias gf='git fetch'
alias gpl='git pull'
alias gcl='git clone'
alias gch='git checkout'
alias gb='git branch'
alias gr='git remote'
alias gsw='git switch'
alias n='nvim'
alias v='vim'
alias chr='rm ~/.config/google-chrome/Singleton*'
alias t='tmux'
alias s='sudo shutdown -h now'
alias k='kitty tmux new-session -A -s 0'
alias ka='tmux kill-server && killall kitty'
alias mstest="bash /home/dp/42_minishell_tester/tester.sh"
alias sz='source ~/.zshrc'

# Environment variables
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:/home/dp/.local/bin"
export PATH=/home/dp/.local/funcheck/host:$PATH
export TERMINAL=kitty
export EDITOR=nvim

# Disable Zsh title handling
DISABLE_AUTO_TITLE="true"

# Precmd to show current directory in tmux window title
precmd() { print -Pn "\033]2;$(basename $PWD)\a" }

# eval "$(starship init zsh)"
