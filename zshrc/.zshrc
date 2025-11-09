# Enable Starship prompt
eval "$(starship init zsh)"

# Enable colors for ls
eval "$(dircolors -b)"

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory

# Aliases
alias ccc='cc -Wall -Wextra -Werror -g'
alias cf='cc -Werror -Wall -Wextra'
alias vf='valgrind --leak-check=full --show-leak-kinds=all --trace-children=yes --track-fds=yes --track-origins=yes'
alias v='valgrind'
alias wd='sudo sg_raw -s 40 -i ~/.config/WD-Decrypte/pw.bin /dev/sda c1 e1 00 00 00 00 00 00 28 00'
alias fch='funcheck'
alias nor='norminette -R CheckForbiddenSourceHeader'
alias ls='ls -h --color=auto'
alias ll='ls -l'
alias lla='ls -al'
alias c='clear'
alias gst='git status'
alias gp='git push'
alias gl='git log'
alias gc='git commit -m'
alias ga='git add .'
alias gac='git add . && cz c'
alias gf='git fetch --all --prune'
alias gpl='git pull'
alias gcl='git clone'
alias gch='git checkout'
alias gb='git branch'
alias gr='git remote'
alias gsw='git switch'
alias n='nvim'
alias v='vim'
alias s='sudo shutdown -h now'
alias r='sudo reboot'
alias ra='ranger'
alias u='sudo apt update && sudo apt upgrade'
alias k='kitty tmux new-session -A -s 0'
alias ka='tmux kill-server && killall kitty'
alias sz='source ~/.zshrc'
alias vm='valgrind --suppressions=suppression.txt --leak-check=full --show-leak-kinds=all --track-origins=yes --show-mismatched-frees=yes --track-fds=yes ./minishell'
alias vp='valgrind --trace-children=yes --track-fds=yes --leak-check=full --show-leak-kinds=all ./pipex infile "ls -l" "wc -l" outfile'

# Environment variables
export PATH="/usr/local/bin:$PATH"
export PATH=$HOME/.brew/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:/home/dp/.local/bin"
export PATH=/home/dp/.local/funcheck/host:$PATH
export TERMINAL=kitty
export EDITOR=nvim

# Disable Zsh title handling
DISABLE_AUTO_TITLE="true"

# Precmd to show current directory in tmux window title
precmd() { print -Pn "\033]2;$(basename $PWD)\a" }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
