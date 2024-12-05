get_wget () {
  echo "# download .tmux.conf"
  wget -qO ~/.tmux.conf https://raw.githubusercontent.com/damienxp6/tmux/master/tmux.conf
  mkdir -p -v ~/.tmux/plugins
  echo "# download tmux plugin manager"
  wget -qO tpm.zip https://github.com/tmux-plugins/tpm/archive/master.zip && unzip -qo tpm.zip -d ~/.tmux/plugins/
  echo "# download plugin : tmux-prefix-highlight"
  wget -qO tmux-prefix-highlight.zip https://github.com/tmux-plugins/tmux-prefix-highlight/archive/master.zip && unzip -qo tmux-prefix-highlight.zip -d ~/.tmux/plugins/
  rm -f tpm.zip tmux-prefix-highlight.zip
}

get_bashrc () {
  echo "# download .bashrc"
  wget -qO ~/.bashrc https://raw.githubusercontent.com/damienxp6/bashrc/refs/heads/main/.bashrc
}

install_package () {
  SUDO=''
  if (( $EUID != 0 )); then
      SUDO='sudo'
  fi
  $SUDO apt-get update
  $SUDO apt-get install -y tmux ccze locate hstr wget unzip
  if [ $? -ne 0 ]; then
      echo "Install KO"
      exit 1
  fi
}

echo "### Installing package."
install_package
echo -e "\n### Get bashrc."
get_bashrc
echo -e "\n### Get tmux config."
get_wget
