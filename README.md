# bashrc

### Install package
```bash
sudo apt-get update && sudo apt-get install -y gnupg2 ccze locate
sudo echo -e "\ndeb https://www.mindforger.com/debian stretch main" >> /etc/apt/sources.list.d/hstr.list
wget -qO - https://www.mindforger.com/gpgpubkey.txt | sudo apt-key add -
sudo apt-get update && sudo apt-get install -y hstr
```

### Edit .bashrc
```bash
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

logtail () {
  tail -F $1 | ccze -A -o nolookups
}
```
