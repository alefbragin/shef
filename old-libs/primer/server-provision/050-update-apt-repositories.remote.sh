###########################
# Update APT Repositories #
###########################

info_section 'Update APT Repositories'

if flag repositories_needs_update; then
  apt-get update || die
  set_flag repositories_needs_update no
  info_changed 'APT repositories successfully updated'
else
  info_already 'APT repositories do not need to be updated'
fi
