# Set up the prompt

autoload -Uz promptinit
promptinit
#prompt adam1
PROMPT='%B%(?.%F{39}Daniel.%F{red}XxXxXxX)%f%b %B%F{4}%1~%f%b '

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ccc='cc -Wall -Wextra -Werror -g'
alias nvim='nvim'
alias r='cc && ./a.out'
alias cf='cc -Werror -Wall -Wextra'
alias nor='norminette -R CheckForbiddenSourceHeader'
alias ll='ls -l'
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
export PATH=$HOME/.brew/bin:$PATH
alias 42free='bash /home/dplotzl/.scripts/42free.sh'
export HOME_MAX_SIZE=5
export SGOINFRE_MAX_SIZE=30
