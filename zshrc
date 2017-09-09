# Remove .zshrc in home directory and use ln -s Dropbox/.dotties/.zshrc .zshrc

# Install oh-my-zsh first from https://github.com/robbyrussell/oh-my-zsh
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
plugins=(debian dircycle dirhistory git last-working-dir pip python sudo \
        web-search)
stty -ixon

# Export stuff
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
export TERM='xterm-256color'
export BROWSER=firefox
export DE=i3
export R_HISTFILE=~/.Rhistory
export WINEARCH=win64
export EMULATOR=`basename "/"$(ps -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/^.* //')`
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
export VLC_PLUGIN_PATH="/usr/lib/vlc/plugins:$VLC_PLUGIN_PATH"
export M2_HOME=/opt/apache-maven-3.3.9
export R_LIBS="$HOME/.local/lib64/R/x86_64-pc-linux-gnu-library/3.2"
export R_LIBS_USER="$HOME/.local/lib64/R/x86_64-pc-linux-gnu-library/3.2"
export GPODDER_HOME=/home/christoph/Documents/gPodder
export GPODDER_DOWNLOAD_DIR=/home/christoph/Documents/gPodder
PYTHONDONTWRITEBYTECODE=True
export PYTHONDONTWRITEBYTECODE

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
export PATH="$HOME/.local/pycharm-community-2017.2.2/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/applications:$PATH"
export PATH="$HOME/.i3/scripts/:$PATH"
# export PATH="$HOME/.i3/scripts:$PATH"
export PATH=$PATH:$M2_HOME/bin

export GOPATH="$HOME/.go"
export QT_STYLE_OVERRIDE=GTK+
export TESSDATA_PREFIX=/usr/local/share

###############################################################################
# Aliases
###############################################################################

# Some aliases depend the machine:
HOSTNAME=`/bin/hostname`

# Open apps in quiet terminal mode without having to append options:
alias R='R -q --no-save'
alias matlab='matlab -nodesktop -nosplash'
if [[ "$HOSTNAME" == "scc1" ]]; then
        module load armadillo/7.400.2
        module load R/3.3.0
        module load stata/14
        module load tmux/2.0
        module load unison/2.48.3
        module load vim/8.0
fi
alias stata='stata -q'
alias julia='~/.local/julia-3c9d75391c/bin/julia'

# Git aliases:
alias ga='git add -u'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'

# Install and update faster (without password set with visudo)
alias updates='sudo apt update; sudo apt dist-upgrade -y'
alias install='sudo apt install'
alias apt-search='apt search'

# Edit config files easier:
alias gtk2='vim ~/.gtkrc-2.0'
alias gtk3='vim ~/.config/gtk-3.0/settings.ini'
alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias Rprofile='vim ~/.Rprofile'

# Don't delete things by accident:
alias rm='rm -i'
alias crontab='crontab -i'
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

# Power management:
alias shutdown='sudo shutdown -h now'
alias lock-and-suspend='~/.i3/scripts/blurred-lock & sudo pm-suspend'
alias lock-screen='~/.i3/scripts/blurred-lock'
alias turn-off-screen='xset dpms force off'

# Shortcuts to open apps:
alias open='xdg-open'
alias tabula='nohup java -Dfile.encoding=utf-8 -Xms256M -Xmx1024M -jar ~/.local/tabula/tabula.jar > /dev/null &'
alias briss='nohup java -jar ~/.local/briss-0.9/briss-0.9.jar > /dev/null &'
alias fritzing='$HOME/.local/fritzing-0.9.3b.linux.AMD64/Fritzing'
alias redshift='nohup redshift -l 42.36:-71.06 > /dev/null &'
alias bib-database='vim ~/Dropbox/papers/bib.bib'
alias ncmpcpp='ncmpcpp --config ~/.i3/ncmpcpp.conf'
alias ncmpcpp-pi='ncmpcpp --config ~/.i3/ncmpcpp-pi.conf'
alias rnag='mpc clear; mpc add tunein:station:s25665; mpc play'
alias wgbh='mpc clear; mpc add tunein:station:s28957; mpc play'
alias rte1='mpc clear; mpc add tunein:station:s15066; mpc play'
alias tcr-fm='mpc clear; mpc add tunein:station:s166348; mpc play'
alias wlr-fm='mpc clear; mpc add tunein:station:s16511; mpc play'
alias pause-spotify='playerctl -p spotify play-pause'

# Preview the boot and shutdown animation:
alias plymouth-preview-boot='plymouthd; plymouth --show-splash; \
  for ((I=0; I<12; I++)); do plymouth --update=test$I; sleep 1; done; \
  plymouth quit'
alias plymouth-preview-shutdown='plymouthd --mode=shutdown; \
  plymouth --show-splash; for ((I=0; I<8; I++)); \
  do plymouth --update=test$I; sleep 1; done; plymouth quit'

# Display settings shortcuts::
if [[ $HOSTNAME == "x1carbon" ]]; then
    alias monitor-only="xrandr --auto; xrandr --output 'HDMI-2' --mode 1920x1080 \
        --output 'eDP-1' --off & bash ~/.i3/scripts/monitor-fonts"
    alias dual-display="xrandr --output 'HDMI-2' --primary --mode 1920x1080 \
        --left-of 'eDP-1' --output 'eDP-1' --mode 2560x1440"
    alias laptop-only="xrandr --output 'eDP-1' --mode 2560x1440 --rotate normal \
        --output 'HDMI-2' --off & bash ~/.i3/scripts/laptop-fonts"
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
alias mirror-with-projector="xrandr --output 'DP1' --mode 1024x768 --output /eDP-1' --mode 1024x768 --same-as 'DP1'"
alias reading-mode='xrandr --output 'eDP-1' --rotate left'
alias mod-to-alt="sed -i -e '2s/Mod4/Mod1/g' ~/.i3/config & i3-msg reload"
alias mod-to-super="sed -i -e '2s/Mod1/Mod4/g' ~/.i3/config & i3-msg reload"
alias random-mac='sudo ifconfig wlan0 down; sudo macchanger wlan0 -r; sudo ifconfig wlan0 up'
alias touchpad-off='synclient TouchpadOff=1'
alias touchpad-on='synclient TouchpadOff=0'

# Misc:
alias cwd='cd .'  # this puts the current directory in ~/.last_dir
alias rwd='cd `cat ~/.last_dir`'  # go to the directory in ~/.last_dir
alias mount-windows='sudo mount -t ntfs -o nls=utf8,umask=0222 /dev/sda4 /media/christoph/windows'
alias hs='herbstclient spawn'
alias fullscreen-urxvt='wmctrl -r :ACTIVE: -b toggle,fullscreen'
alias start-dropbox='nohup ~/.dropbox-dist/dropboxd > /dev/null &'
alias start-icons='nohup python3 ~/.i3/scripts/autoname-workspaces.py > /dev/null &'
alias start-mopidy='nohup mopidy > /dev/null &'
alias restart-sync='killall dropbox; dropbox start; killall insync; insync start'

source ~/.private-aliases

###############################################################################
# Functions
###############################################################################

# Open new terminal in same directory as last terminal:
function cd {
        builtin cd $@
        pwd > ~/.last_dir
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
  cat $1 | ssh walshcb@scc-lite.bu.edu lpr -P mugar-ds-staple -J 'print-job'
}

# Send a script with qsub with "qsub_job myscript.R"
function qsub_job() {
  jobname=$(basename $1)
  qsub -P econdept -cwd -m beas -l h_rt=24:00:00 -j y -N $jobname $1
}

# Same as above but for parallel jobs:
function qsub_parallel_job() {
  jobname=$(basename $1)
  qsub -P econdept -pe omp 12 -cwd -m beas -l h_rt=48:00:00 -j y -N $jobname $1
}

function weather() {
  curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml"
}

function calc() {
  R --vanilla --slave -e $1
}

function texToHTML() {
  htlatex $1 "ht5mjlatex.cfg, charset=utf-8" " -cunihtf -utf8"
}

function extract() {
        if [ -f $1 ]; then
                case $1 in
                        *.tar.bz2)   tar xvjf $1     ;;
                        *.tar.gz)    tar xvzf $1     ;;
                        *.bz2)       bunzip2 $1      ;;
                        *.rar)       unrar x $1      ;;
                        *.gz)        gunzip $1       ;;
                        *.tar)       tar xvf $1      ;;
                        *.tbz2)      tar xvjf $1     ;;
                        *.tgz)       tar xvzf $1     ;;
                        *.zip)       unzip $1        ;;
                        *.Z)         uncompress $1   ;;
                        *.7z)        7z x $1         ;;
                        *)           echo "'$1' cannot be extracted via >extract<" ;;
                esac
        else
                echo "'$1' is not a valid file!"
        fi
}

function preview() {
  RESOLUTION=`file $1 | grep -oE "[0-9]{3,}x[0-9]{3,}"`
  WIDTH=`echo $RESOLUTION | cut -d x -f 1`
  HEIGHT=`echo $RESOLUTION | cut -d x -f 2`
  ASPECT_RATIO=`echo $WIDTH / $HEIGHT | bc -l`
  NEW_WIDTH=`echo $(($ASPECT_RATIO * 600))`
  NEW_WIDTH=`printf '%.0f' "$(($NEW_WIDTH))"`
  feh -B black -g "$NEW_WIDTH"x600 $1
}

function makelatex() {
  latexmk -pdf $1
  latexmk -c $1
}

###############################################################################
# Setting the prompt
###############################################################################

# SSH host information:
if [[ -n "$SSH_CLIENT" ]]; then
  PROMPT_HOST="($HOST) "
elif [[ `whoami` == "root" ]]; then
  PROMPT_HOST="(root) "
else
  PROMPT_HOST=''
fi

# Finally setting the prompt and colours:
if [[ -n "$SSH_CLIENT" ]]; then
      PROMPT='${PROMPT_HOST}%{$fg_bold[blue]%}%p%{$fg_bold[blue]%}%2~ ${dir_status}%{$reset_color%}$ '
else
      source ~/.powerline-prompt
fi

# Make the caps lock be another button for escape
setxkbmap -option ctrl:escape
eval setxkbmap -option caps:escape

BASE16_SHELL_SET_BACKGROUND=false
BASE16_SHELL=$HOME/.config/base16-shell
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
