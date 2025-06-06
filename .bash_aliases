# This file is read by .bashrc, so any command here is read at startup
# My aliases:

# Add an "alert" alias for long running commands. Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# control ls command
alias lh='ls -alh --time-style=long-iso'
alias lt='ls --human-readable --size -1 -S --classify'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# control cd command
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

# if there is color support, enable handy aliases for colors
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# create all parent directories in path
alias mkdir='mkdir -pv'

# control less command
alias lesss='less -S'

# become root
alias root='sudo -i'

# by default resume wget downloads if available
alias wget='wget -c'

# view only mounted drives
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

# check memory size of directories in a human readable way and with depth of just one directory
alias duh='du -hd 1 .'
alias duhs='du -hd 1 . | sort -h'

# find a command in history using grep
alias gh='history|grep'

# count files in directory
alias count='find . -type f | wc -l'

# easily source the .bashrc file
alias scbashrc='source ~/.bashrc'

# makeit easier to open R's fancier console
alias r="radian"

# print drive information with a focus on only useful drives
alias mydf='df -h -x squashfs -x tmpfs -x devtmpfs'

# change vim to neovim (note that most base functionalities can still be called with 'vi')
alias vim='nvim'
alias lvim="NVIM_APPNAME=lunarvim nvim"

# connect to DKFZ VPN via cisco secureclient
alias vpn='/opt/cisco/secureclient/bin/vpn'
alias vpndkfz='vpn connect gate.dkfz-heidelberg/token'

# rsync with archive mode, skipping files that are newer on the receiver, human readable output, and a progress bar
alias rsync_prog='rsync -auh --info=progress2'

# pipe to this to copy to clipboard
alias copy='xsel -ib'

# Tree with du capabilities
alias treedu='tree -du -h'

# Re-set the DISPLAY variable when the tmux windows mismatch the tmux DISPLAY
# This solves the issue of copying to clipboard with xclip (Error: can't open DISPLAY)
alias td='eval "$(tmux showenv -s DISPLAY)"'

# GIT aliases
## to commit to my dotfiles directory
alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# SSH machines
alias mystra='ssh ubuntu@10.128.129.72'
alias jhub='ssh ubuntu@vm-129-245.cloud.dkfz-heidelberg.de'
alias worker02='ssh a752o@odcf-worker02.dkfz.de'
