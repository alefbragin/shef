# Install packages and upgrade system.
#
# Dependencies:
#.  shef/fn-alias
#.  shef/utils
#.  shef/state
#.  shef/log

shef__function_aliases \
  dist_install \
  dist_database_update \
  dist_initial_upgrade

shef__dist_install() {
  if ! dpkg-query --show "$1" > /dev/null 2> /dev/null; then
    DEBIAN_FRONTEND=noninteractive apt-get install --yes "$1" \
      || shef__die "install package: '$1'"

    shef__log_changed "package was successfully installed: '$1'"
  else
    shef__log_already "package is already installed: '$1'"
  fi
}

shef__dist_update_database() {
  if [ "$1" = --force ] || shef__check_state dist_database_needs_update; then
    DEBIAN_FRONTEND=noninteractive apt-get update \
      || shef__die 'update packages database'

    shef__state_set dist_database_needs_update no

    shef__log_changed 'package database was successfully updated'
  else
    shef__log_already 'package database is already updated'
  fi
}

shef__dist_initial_upgrade() {
  if [ "$1" = --force ] || ! shef__check_state dist_is_initially_upgraded; then
    shef__dist_update_database --force

    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade --yes \
      || shef__die 'upgrade distributive'

    shef__state_set dist_is_initially_upgraded yes

    shef__log_changed 'initial upgrade successfully completed'
  else
    shef__log_already 'initial upgrade already done'
  fi
}
