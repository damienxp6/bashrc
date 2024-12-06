## COLOR
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    if [ $USER = 'root' ]; then
        PS1="\[\e[38;5;196m\]\u\[\e[38;5;202m\]@\[\e[38;5;208m\]\h \[\e[38;5;220m\]\w \[\033[0m\]$ "
    else
        PS1="${debian_chroot:+($debian_chroot)}\[\e[38;5;214m\]\u\[\e[38;5;209m\]@\[\e[38;5;166m\]\h \[\e[38;5;33m\]\w \[\033[0m\]$ "
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

## ALIASES
logtail () {
  tail -F $1 | ccze -A -o nolookups
}
alias ls='ls --color=auto'
alias ll='ls -lh'
alias lla='ls -lha'
alias l='lla'
alias ip='ip --color=auto'

## HSTR
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor,raw-history-view       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
