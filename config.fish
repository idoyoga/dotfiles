# Set the PATH variable correctly
set -gx PATH /bin /usr/bin /usr/local/bin $PATH

#if status is-interactive
alias cc='cc -Werror -Wall -Wextra'
alias nor='norminette -R CheckForbiddenSourceHeader'
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
alias v='vim .'
alias n='nvim'
function n
	if test (count $argv) -eq 0
		nvim .
	else
		nvim $argv
	end
end
alias t='tmux attach-session -t default || tmux new-session -s default'
alias francinette="$HOME"/francinette/tester.sh
alias paco="$HOME"/francinette/tester.sh
function fish_prompt
        set user_color green
        set_color $user_color
        echo -n (whoami)
    # Display the current git branch if in a git repository
    if test -d .git
        set_color $fish_color_cwd
        echo -n ' ('
        set_color white
        echo -n (git symbolic-ref --short HEAD 2> /dev/null)
        set_color $fish_color_cwd
        echo -n ')'
    end
    
    set_color normal
    echo -n ' > '
end
set -gx PATH /home/dp/.local/funcheck/host $PATH

# Created by `pipx` on 2024-06-16 14:11:13
set PATH $PATH /home/dp/.local/bin
