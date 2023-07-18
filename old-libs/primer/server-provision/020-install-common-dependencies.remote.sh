###############################
# Install Common Dependencies #
###############################

info_section 'Install Common Dependencies'

install_package debian-archive-keyring
install_package gnupg2
install_package curl
install_package logrotate
