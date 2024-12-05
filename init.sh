get_wget () {
  wget -qO ~/.tmux.conf https://raw.githubusercontent.com/damienxp6/tmux/master/tmux.conf
  wget -O tpm.zip https://github.com/tmux-plugins/tpm/archive/master.zip && mkdir -p -v ~/.tmux/plugins && unzip tpm.zip -d ~/.tmux/plugins/
  wget -O tmux-prefix-highlight.zip https://github.com/tmux-plugins/tmux-prefix-highlight/archive/master.zip && mkdir -p -v ~/.tmux/plugins && unzip tmux-prefix-highlight.zip -d ~/.tmux/plugins/
}

get_bashrc () {
  wget -qO ~/.bashrc https://raw.githubusercontent.com/damienxp6/bashrc/refs/heads/main/.bashrc
}

install_package () {
  SUDO=''
  if (( $EUID != 0 )); then
      SUDO='sudo'
  fi
  $SUDO apt-get update
  $SUDO apt-get install -y tmux ccze locate hstr wget unzip
  if [ $? -eq 0 ]; then
      exit 1
  fi
}

echo "### Installing package."
install_package
echo "### Get bashrc."
get_bashrc
echo "### Get tmux config."
get_wget
