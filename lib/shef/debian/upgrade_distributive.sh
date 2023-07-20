# shef__debian__upgrade_distributive_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh
#.  shef/state/state_check.sh
#.  shef/log/log_changed.sh
#.  shef/log/log_already.sh
#.  ./update_packages_db.sh

shef__fn_alias upgrade_distributive

shef__upgrade_distributive() {
  if [ "$1" = --force ] || ! shef__state_check distributive_has_been_upgraded; then
    shef__update_packages_db --force

    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade --yes \
      || shef__die 'upgrade system'

    shef__state_set distributive_has_been_upgraded

    shef__log_changed 'distributive upgrade was successfully completed'
  else
    shef__log_already 'distributive upgrade is already done'
  fi
}
