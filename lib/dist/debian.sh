# Install packages and upgrade system.
#
# Dependencies:
#.  shef/state

dist_install() {
  if ! dpkg-query --show "$1" > /dev/null 2> /dev/null; then
    DEBIAN_FRONTEND=noninteractive apt-get install --yes "$1" \
      || die "cannot install package: '$1'"

    log_changed "package was successfully installed: '$1'"
  else
    log_already "package is already installed: '$1'"
  fi
}

dist_database_update() {
  if [ "$1" = --force ] || state dist_database_needs_update yes; then
    DEBIAN_FRONTEND=noninteractive apt-get update \
      || die "cannot update packages database"

    state_set dist_database_needs_update no

    log_changed "package database was successfully updated"
  else
    log_already "package database is already updated"
  fi
}

dist_initial_upgrade() {
  if [ "$1" = --force ] || ! state dist_is_initially_upgraded yes; then
    dist_database_update --force

    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade --yes \
      || die "cannot upgrade distributive"

    state_set dist_is_initially_upgraded yes

    log_changed 'initial upgrade successfully completed'
  else
    log_already 'initial upgrade already done'
  fi
}
