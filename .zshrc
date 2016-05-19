# Remove .zshrc in home directory and use ln -s Dropbox/.dotties/.zshrc .zshrc

# Install oh-my-zsh first from https://github.com/robbyrussell/oh-my-zsh
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
DISABLE_UPDATE_PROMPT=true
plugins=(git)
stty -ixon

# Export stuff
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM='xterm-256color'
export BROWSER='iceweasel'
export R_HISTFILE=~/.Rhistory
export WINEARCH=win64
export CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1920x1080
export EMULATOR=`basename "/"$(ps -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //')`
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export VLC_PLUGIN_PATH=/usr/lib/vlc/plugins
export M2_HOME=/opt/apache-maven-3.3.9
export R_LIBS="$HOME/.local/lib64/R/x86_64-pc-linux-gnu-library/3.2"
export R_LIBS_USER="$HOME/.local/lib64/R/x86_64-pc-linux-gnu-library/3.2"

# Set $PATH:
export PATH="/bin:$PATH"
export PATH="/sbin:$PATH"
export PATH="/usr/lib/x86_64-linux/gnu/wine/bin/:$PATH"
export PATH="/usr/lib/i386-linux-gnu/wine/bin$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="/usr/local/games:$PATH"
export PATH="/usr/lib/R/bin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/usr/sbin/:$PATH"
export PATH="/usr/games:$PATH"
export PATH="$HOME/Dropbox/papers/scholar.py:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/applications:$PATH"
export PATH=$PATH:$M2_HOME/bin

export GOPATH="$HOME/.go"
export QT_STYLE_OVERRIDE=GTK+
export TESSDATA_PREFIX=/usr/local/share

if [[ $EMULATOR == "urxvt" ]]; then
        eval $( dircolors -b ~/.dircolors )
else
        eval $( dircolors -b ~/.dircolors )
fi

###############################################################################
# Aliases
###############################################################################

# Some aliases depend the machine:
HOSTNAME=`/bin/hostname`

# Open apps in quiet terminal mode without having to append options:
alias R='R -q'
alias matlab='matlab -nodesktop -nosplash'
alias stata='stata -q'

# Git aliases:
alias ga='git add -u'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'

# Install and update faster (without password set with visudo)
alias updates='sudo apt update; sudo apt dist-upgrade -y'
alias install='sudo apt install'
alias apt-search='apt search'

# Edit GTK settings easier:
alias gtk2='vim ~/.gtkrc-2.0'
alias gtk3='vim ~/.config/gtk-3.0/settings.ini'

# Don't delete things by accident:
alias rm='rm -i'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

# Common misspellings
alias kilall='killall'
alias sl='sl -e'
alias help='man'

# SSH Shortcuts:
alias pbu='sftp walshcb@people.bu.edu'
alias pi='ssh osmc@192.168.0.107 -X'
alias pi2='ssh pi@192.168.0.106 -X'
alias sftpbu='sftp walshcb@people.bu.edu'

# Connect to the BU VPN easier:
alias vpn='sudo openconnect vpn.bu.edu -u walshcb'

# Power management:
alias shutdown='sudo shutdown -h now'
alias lock-and-suspend='/home/christoph/.i3/suspend-and-lock'
alias lock-screen='/home/christoph/.i3/blurred-lock'
alias turn-off-screen='xset dpms force off'

# Shortcuts to open apps:
alias tabula='java -Dfile.encoding=utf-8 -Xms256M -Xmx1024M -jar ~/.local/tabula/tabula.jar'
alias preview='feh -g 900x600'
alias bib-database='vim ~/Dropbox/papers/bib.bib'
alias ncmpcpp='ncmpcpp --config ~/.i3/ncmpcpp.conf'
alias ncmpcpp-pi='ncmpcpp --config ~/.i3/ncmpcpp-pi.conf'
alias mpc-pi='mpc -h 192.168.0.106'
alias rnag='mpc clear; mpc add tunein:station:s25665; mpc play'
alias wgbh='mpc clear; mpc add tunein:station:s28957; mpc play'
alias rte1='mpc clear; mpc add tunein:station:s15066; mpc play'
alias pause-spotify='playerctl -p spotify play-pause'
# Create a Stata alias only on the Thinkpad:
thinkpad={'lenovo'}
if [ "$HOSTNAME" = lenovo ] | [ "$HOSTNAME" = acer ]; then
  alias stata='/usr/local/stata13/stata-se -q';
  alias xstata='/usr/local/stata13/xstata-se -q'
  #alias vim='vim --username VIM'
fi

if [ "$HOSTNAME" = scc1 ]; then
  alias R2='/usr/local/bin/R -q';
  alias splat='/usr3/graduate/walshcb/.local/bin/splat';
  alias splat-hd='/usr3/graduate/walshcb/.local/bin/splat-hd';
fi

# Preview the boot and shutdown animation:
alias plymouth-preview-boot='plymouthd; plymouth --show-splash; \
  for ((I=0; I<12; I++)); do plymouth --update=test$I; sleep 1; done; \
  plymouth quit'
alias plymouth-preview-shutdown='plymouthd --mode=shutdown; \
  plymouth --show-splash; for ((I=0; I<8; I++)); \
  do plymouth --update=test$I; sleep 1; done; plymouth quit'

# Display settings shortcuts::
if [[ $HOSTNAME == debian ]]; then
    alias monitor-only="xrandr --auto; xrandr --output HDMI2 --mode 1920x1080 \
        --output eDP1 --off & sed -i -e '6,9s/!//g' -e '10,13s/^/!/g' ~/.Xdefaults"
    alias dual-display="xrandr --output HDMI2 --primary --mode 1920x1080 \
        --left-of eDP1 --output eDP1 --mode 2560x1440"
    alias laptop-only="xrandr --output eDP1 --mode 2560x1440 --rotate normal \
        --output HDMI2 --off & sed -i -e '6,9s/^/!/g' ~/.Xdefaults -e '10,13s/!//g'"
    alias dual-monitors='xrandr --output HDMI2 --mode 1920x1080 --left-of HDMI1 \
            --output HDMI1 --mode 1920x1080 --output eDP1 --off'
elif [[ $HOSTNAME == acer ]]; then
    alias monitor-only='xrandr --auto; xrandr --output HDMI1 --mode 1920x1080 \
         --output LVDS1 --off'
    alias dual-display='xrandr --output HDMI1 --primary --mode 1920x1080 --left-of LVDS1 --output LVDS1 --mode 1366x768'
    alias dual-display-vga='xrandr --output VGA1 --primary --mode 1024x768 --left-of LVDS1 --output LVDS1 --mode 1366x768'
elif [[ $HOSTNAME == m73 ]]; then
   alias samsung-only='xrandr --auto; xrandr --output HDMI1 --mode 1920x1080 \
           --output VGA1 --off'
   alias dual-display='xrandr --auto; xrandr --output HDMI1 --mode 1920x1080 --left-of VGA1 \
           --output VGA1 --mode 1280x1024 \
           --output HDMI1 --primary'
   alias dual-display-1080p='xrandr --auto; xrandr --output HDMI1 --mode 1920x1080 --left-of VGA1 \
           --output VGA1 --mode 1280x1024 --scale 1.054688x1.054688 \
           --output HDMI1 --primary'
   alias monitor-only='xrandr --output HDMI1 --mode 1920x1080 \
           --output VGA1 --off'
fi
# Shortcut to change font size in urxvt, handy when switching between monitor and laptop:
alias large-urxvt-font="sed -i -e '6,9s/^/!/g' ~/.Xdefaults -e '10,13s/!//g'"
alias small-urxvt-font="sed -i -e '6,9s/!//g' ~/.Xdefaults -e '10,13s/^/!/g'"
alias laptop-1080p='xrandr --output eDP1 --mode 1920x1080 --output HDMI2 --off'
alias laptop-768p='xrandr --output eDP1 --mode 1360x768 --output HDMI2 --off'
alias dual-display-1080p='xrandr --output HDMI2 --primary --mode 1920x1080 --left-of eDP1 --output eDP1 --mode 1920x1080'
alias projector-mode='xrandr --output DP1 --auto --output eDP1 --off'
alias mirror-with-projector='xrandr --output DP1 --mode 1024x768 --output eDP1 --mode 1024x768 --same-as DP1'
alias reading-mode='xrandr --output eDP1 --rotate left'
alias rgb-screen-saver='eog --slide-show ~/Documents/screenfix'
alias mod-to-alt="sed -i -e '2s/Mod4/Mod1/g' ~/.i3/config & i3-msg reload"
alias mod-to-super="sed -i -e '2s/Mod1/Mod4/g' ~/.i3/config & i3-msg reload"

# Misc:
alias cwd='cd .'  # this puts the current directory in ~/.last_dir
alias rwd='cd `cat ~/.last_dir`'  # go to the directory in ~/.last_dir
alias mount-windows='sudo mount -t ntfs -o nls=utf8,umask=0222 /dev/sda4 /media/christoph/windows'
alias hs='herbstclient spawn'
alias fullscreen-urxvt='wmctrl -r :ACTIVE: -b toggle,fullscreen'
alias start-dropbox='nohup ~/.dropbox-dist/dropboxd >&/dev/null'

###############################################################################
# Functions
###############################################################################

# Open new terminal in same directory as last terminal:
function cd {
        builtin cd $@
        echo $(pwd) > ~/.last_dir
}
if [ -f ~/.last_dir ]; then
        cd "`cat ~/.last_dir`"
fi

# For some reason, bigger git directories were loading slowly.
# This somehow speeds it up:
function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Send a file to print at Mugar with "mugar_print file.pdf"
function mugar_print() {
  cat $1 | sshpass -f ~/.config/sshpass/.Xpi2 ssh walshcb@scc-lite.bu.edu \
    lpr -P mugar-ds-staple -J $1
}

# Send a script with qsub with "qsub_job myscript.R"
function qsub_job() {
  jobname=$(basename $1)
  qsub -P econdept -cwd -m beas -N $jobname $1
}

# Same as above but for parallel jobs:
function qsub_parallel_job() {
  jobname=$(basename $1)
  qsub -P econdept -pe omp 12 -cwd -m beas -N $jobname $1
}

function aoe2() {
  cd "/home/christoph/Documents/Age2HD The Forgotten 3.2 LAN Version/Age2HD The Forgotten 3.2 LAN Version"
  WINEARCH=win32
  wine SmartSteamLoader.exe
  cd
}

function weather() {
  curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml"
}

function calc() {
  R --vanilla --slave -e $1
}

###############################################################################
# Setting the prompt
###############################################################################

# Shows directory (two directories deep only)
# Shows hostname if connected via SSH and also shows root.
# Shows git repos and changes colors depending on if there are unstaged commits
# or up to date.

autoload -U add-zsh-hook
autoload -Uz vcs_info

# Git information:
zstyle ':vcs_info:*' actionformats \
       '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats ' %F{2}%s%F{7}:%F{2}(%F{1}%b%F{2})%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git

prompt_vcs () {
  vcs_info
  if [ "${vcs_info_msg_0_}" = "" ]; then
    dir_status="$%f"
  elif [[ $(git diff --cached --name-status 2>/dev/null ) != "" ]]; then
    dir_status="%F{1}»%f"
  elif [[ $(git diff --name-status 2>/dev/null ) != "" ]]; then
    dir_status="%F{3}»%f"
  else
    dir_status="%F{2}»%f"
  fi
}

add-zsh-hook precmd prompt_vcs

# SSH host information:
if [[ -n "$SSH_CLIENT" ]]; then
  PROMPT_HOST="($HOST) "
elif [[ `whoami` == "root" ]]; then
  PROMPT_HOST="(root) "
else
  PROMPT_HOST=''
fi

# Finally setting the prompt and colours:
if [[ $EMULATOR == "urxvt" ]] || [[ $EMULATOR == "85x24" ]]; then
        PROMPT='${ret_status}%{$fg[green]%}${PROMPT_HOST}%{$fg_bold[green]%}%p%{$fg_bold[yellow]%}%2~ ${vcs_info_msg_0_}${dir_status}%{$reset_color%} '
else
        source ~/.powerline-prompt
fi

# Make the caps lock be another button for escape
setxkbmap -option ctrl:escape
eval setxkbmap -option caps:escape
unset GNOME_KEYRING_CONTROL  # turn off gnome keyring
