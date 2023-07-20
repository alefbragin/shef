# shef__debian__update_packages_db_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh
#.  shef/log/log_changed.sh
#.  shef/log/log_already.sh
#.  shef/state/state_set.sh

shef__fn_alias update_packages_db

shef__update_packages_db() {
  if [ "$1" = --force ] || shef__check_state packages_db_needs_update; then
    DEBIAN_FRONTEND=noninteractive apt-get update \
      || shef__die 'update packages database'

    shef__state_set packages_db_needs_update 0

    shef__log_changed 'packages database was successfully updated'
  else
    shef__log_already 'packages database is already updated'
  fi
}
