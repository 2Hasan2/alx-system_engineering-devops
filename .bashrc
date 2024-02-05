#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
#alias more=less

xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#list all package
alias list='pacman -Qq'


# run codux from anywhere
alias codux='~/opt/Codux/codux'


# run app.sh from anywhere with it arguments
alias  web='/home/$(whoami)/FrameWorks/app.sh'

export PATH=~/.npm-global/bin:$PATH


# change permission for all files in current directory
c() {
    chmod -R $1 . && ls -l | grep -v "total"
}

# lang
export LANG=en_US.utf8
export LC_ALL=en_US.utf8



# java
export JAVA_HOME=/usr/lib/jvm/default
export PATH=$PATH:$JAVA_HOME/bin


#  invoke AI
alias invoke='cd /home/$(whoami)/invokeai && ./invoke.sh'


# minecraft
alias minecraft='cd /home/$(whoami)/Minecraft && ./mc.sh'


# web sites
# Define an array of website names
websites=(
    "github"
    "gitlab"
    "bitbucket"
    "stackoverflow"
    "google"
    "youtube"
    "facebook"
    "twitter"
    "instagram"
    "linkedin"
    "reddit"
    "pinterest"
    "tumblr"
    "snapchat"
    "whatsapp"
    "telegram"
    "skype"
    "zoom"
    "discord"
    "slack"
    "medium"
    "wordpress"
    "blogger"
    "wix"
    "weebly"
    "squarespace"
    "shopify"
    "bigcartel"
    "etsy"
    "ebay"
    "amazon"
    "alibaba"
    "flipkart"
    "snapdeal"
    "paytm"
    "olx"
)

# Define a function to generate URLs
open_website() {
    echo "xdg-open https://www.$1.com &> /dev/null & disown -a"
}

add_website() {
    websites+=("$1")
    alias "$1"="$(open_website "$1")"
    # Reload the .bashrc file
    source ~/.bashrc
}

remove_website() {
    # Remove the website from the array
    websites=("${websites[@]/$1}")
    # Remove the alias
    unalias "$1"
    # Reload the .bashrc file
    source ~/.bashrc
}

list_websites() {
    for website in "${websites[@]}"; do
        echo "$website"
    done
}

# Loop through the array and create aliases
for website in "${websites[@]}"; do
    alias "web-$website"="$(open_website "$website")"
done

# Create a function to take a screenshot
screenshot() {
    # Take a screenshot by clicking on print screen key and save it in the Pictures directory 
    gnome-screenshot -f "$HOME/Pictures/screenshots/$(date +%Y-%m-%d-%H-%M-%S).png" &> /dev/null
    # print the path of the screenshot with green color
    echo -e "\e[32mScreenshot saved in $HOME/Pictures/screenshots\e[0m"
}

# Create a function to record the screen
recordscreen() {
    # Record the screen using the following command the full screen
    # var the screen to git the window
    window_size=$(xdotool getactivewindow getwindowgeometry --shell | grep "WIDTH\|HEIGHT")
    output_dir="$HOME/Videos/recodings"
    eval "$window_size"
    # Record the screen using the following command
    ffmpeg -video_size "${WIDTH}x${HEIGHT}" -framerate 25 -f x11grab -i :0.0 -f pulse -ac 2 -i default "$output_dir/$(date +%Y-%m-%d-%H-%M-%S).mp4"
}
