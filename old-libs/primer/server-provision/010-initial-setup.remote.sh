###################
# Initial Upgrade #
###################

info_section 'Initial Upgrade'

if flag host_needs_initial_upgrade yes; then
  DEBIAN_FRONTEND=noninteractive apt-get update || die
  DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade --yes || die

  set_flag host_needs_initial_upgrade no
  set_flag repositories_needs_update yes

  info_changed 'Initial upgrade successfully completed'
else
  info_already 'Initial upgrade already done'
fi

##########################
# Setup Common Variables #
##########################

install_package lsb-release
lsb_release="$(lsb_release -cs)"
