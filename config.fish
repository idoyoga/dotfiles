set -Ux fish_user_paths /usr/bin/tmux $fish_user_paths

if status is-interactive
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
alias n='flatpak run io.neovim.nvim'
alias v='vim .'
alias t='tmux attach-session -t default || tmux new-session -s default'
alias francinette="$HOME"/francinette-image/run.sh
alias paco="$HOME"/francinette-image/run.sh

function fish_prompt
    set_color $fish_color_cwd
    # Display the current working directory
    echo -n (prompt_pwd)
    
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

  #function fish_prompt
  #set_color $fish_color_cwd
  #echo -n (prompt_pwd)
  #set_color blue
  #echo -n ' ) '
  #end
end
