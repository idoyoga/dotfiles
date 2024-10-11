set -x PATH $PATH /usr/bin/tmux 

if status is-interactive
alias r='cc && ./a.out'
alias cf='cc -Werror -Wall -Wextra'
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
alias n='nvim'
alias v='vim .'
alias chr='rm ~/.config/google-chrome/Singleton*'
function t
  if tmux has-session -t default
    set -l session_name "session"(date +%s)
    tmux new-session -s $session_name
  else
    tmux attach-session -t default || tmux new-session -s default
  end
end
  
alias ta='tmux attach-session -t session'
alias tk='tmux kill-session -t default'
alias francinette="$HOME"/francinette-image/run.sh
alias paco="$HOME"/francinette-image/run.sh

function fish_prompt
    set_color $fish_color_cwd
    # Display the current working directory
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

  #function fish_prompt
  #set_color $fish_color_cwd
  #echo -n (prompt_pwd)
  #set_color blue
  #echo -n ' ) '
  #end
end
alias 42free='bash /home/dplotzl/.scripts/42free.sh'
export HOME_MAX_SIZE=5
export SGOINFRE_MAX_SIZE=30
export SGOINFRE='/sgoinfre/dplotzl'

# add capt to PATH

set -p LD_LIBRARY_PATH /home/dplotzl/.capt/root/lib/x86_64-linux-gnu:/home/dplotzl/.capt/root/usr/lib/x86_64-linux-gnu
set -p PATH /home/dplotzl/.capt:/home/dplotzl/.capt/root/bin:/home/dplotzl/.capt/root/sbin:/home/dplotzl/.capt/root/usr/bin:/home/dplotzl/.capt/root/usr/sbin:/home/dplotzl/.capt/root/usr/games:/home/dplotzl/.capt/root/usr/local/bin:/home/dplotzl/.capt/root/usr/local/sbin:/home/dplotzl/.capt/root/usr/local/games:/home/dplotzl/.capt/snap/bin
