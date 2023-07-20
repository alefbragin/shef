# shef__debian__install_package_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh
#.  shef/log/log_changed.sh
#.  shef/log/log_already.sh

shef__fn_alias install_package

shef__install_package() {
  if ! dpkg-query --show "$1" > /dev/null 2> /dev/null; then
    DEBIAN_FRONTEND=noninteractive apt-get install --yes "$1" \
      || shef__die "install package: '$1'"

    shef__log_changed "package was successfully installed: '$1'"
  else
    shef__log_already "package is already installed: '$1'"
  fi
}
