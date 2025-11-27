# Environment variables
export PATH="$HOME/mnt/veracrypt/syncthing/dotfiles/vps_scripts:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/sgoinfre/dplotzl/.brew/bin:$PATH"
export PATH=$HOME/.brew/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="$PATH:/home/dp/.local/bin"
export PATH=/home/dp/.local/funcheck/host:$PATH
export TERMINAL=kitty
export EDITOR=nvim

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
alias vf='valgrind --leak-check=full --show-leak-kinds=all --trace-children=yes --track-fds=yes --track-origins=yes'
alias wd='sudo sg_raw -s 40 -i ~/.config/WD-Decrypte/pw.bin /dev/sdb c1 e1 00 00 00 00 00 00 28 00'
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
alias gra='git remote add'
alias gsw='git switch'
alias n='nvim'
alias v='vim'
alias s='sudo shutdown -h now'
alias r='sudo reboot'
alias ra='ranger'
alias rm='rm -i'
alias u='sudo apt update && sudo apt upgrade'
alias k='kitty tmux new-session -A -s 0'
alias ka='tmux kill-server && killall kitty'
alias s42='syncthing --no-browser --logflags=0'
alias syncvps='ssh -NL 8385:127.0.0.1:8384 vps'
alias se='sudoedit'
alias sz='source ~/.zshrc'

# Tailscale shortcuts
alias tsu='sudo tailscale up'
alias tsu42='tailscaled --tun=userspace-networking --socket=$HOME/tailscaled.sock &
tailscale --socket=$HOME/tailscaled.sock up --accept-dns=false'
alias tsd='sudo tailscale down'
alias tss='tailscale status'
alias tss42='tailscale --socket=$HOME/tailscaled.sock status'
alias vpn-on='sudo tailscale up --exit-node=100.65.0.7 --exit-node-allow-lan-access=true --accept-dns=false --login-server=https://hsapi.ploetzl.pro'
alias vpn-off='sudo tailscale up --exit-node= --exit-node-allow-lan-access=false --accept-dns=false --login-server=https://hsapi.ploetzl.pro'

# Headscale shortcuts
alias hs='sudo docker exec -it headscale headscale'
alias hslist='hs nodes list'
alias hslogs='sudo docker logs headscale --tail 50'
alias hsapprove='hs nodes approve-routes -i'

# Veracrypt shortcuts for Inspiron
alias vcu='sudo veracrypt -d /mnt/veracrypt'
alias vcm='veracrypt --text /media/dp/Seagate/seaCont.dev /media/veracrypt1'
alias vcd='sudo /usr/local/bin/veracrypt-unmount.sh'

# gocryptfs shortcuts
alias sec-on='gocryptfs secure.enc secure_plain'
alias sec-off='fusermount -u secure_plain'

# Restic shortcuts for vps
alias rcheck='sudo restic -r sftp:dp@100.65.0.2:/media/veracrypt1/Backup/01_System_Backups/Restic_vps --password-file /etc/restic/restic-pass.txt check'
alias rstats='sudo restic -r sftp:dp@100.65.0.2:/media/veracrypt1/Backup/01_System_Backups/Restic_vps --password-file /etc/restic/restic-pass.txt stats'
alias rsnap='sudo restic -r sftp:dp@100.65.0.2:/media/veracrypt1/Backup/01_System_Backups/Restic_vps --password-file /etc/restic/restic-pass.txt snapshots'

# Sec-related aliases
alias cleansh='env -i HOME="$HOME" TMPDIR=/dev/shm /bin/zsh --no-rcs --no-globalrcs'

# Disable Zsh title handling
DISABLE_AUTO_TITLE="true"

# Precmd to show current directory in tmux window title
precmd() { print -Pn "\033]2;$(basename $PWD)\a" }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

case "$(hostname)" in
  vps)
    export PATH="/mnt/veracrypt/syncthing/dotfiles/scripts/vps:$PATH"
    ;;
  inspiron*)
    export PATH="$HOME/Documents/dotfiles/scripts/inspiron:$PATH"
    ;;
  thinkpad*)
    export PATH="$HOME/Documents/dotfiles/scripts/thinkpad:$PATH"
    ;;
  *)
    export PATH="$HOME/Documents/dotfiles/scripts/common:$PATH"
    ;;
esac

# Host-specific overrides
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
