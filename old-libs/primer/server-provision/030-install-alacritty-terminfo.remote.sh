##############################
# Install Alacritty Terminfo #
##############################

info_section 'Install Alacritty Terminfo'

if ! infocmp alacritty > /dev/null 2> /dev/null; then
  alacritty_terminfo_file="$(mktemp)" || die

  curl https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info \
    > "${alacritty_terminfo_file}"
  ok_or_die

  tic -xe alacritty,alacritty-direct "${alacritty_terminfo_file}" || die
  rm "${alacritty_terminfo_file}" || die
  info_changed 'Alacritty terminfo successfully installed'
else
  info_already 'Alacritty termalready already installed'
fi
