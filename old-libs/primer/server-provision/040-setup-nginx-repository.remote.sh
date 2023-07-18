##########################
# Setup Nginx Repository #
##########################

info_section 'Setup Nginx Repository'

nginx_key_file=/usr/share/keyrings/nginx-archive-keyring.gpg
if [ ! -f "${nginx_key_file}" ]; then
  curl https://nginx.org/keys/nginx_signing.key \
    | gpg --dearmor > "${nginx_key_file}"
  ok_or_die
  info_changed 'Nginx key successfully downloaded'
else
  info_already 'Nginx key already exists'
fi

gpg --dry-run --quiet --import --import-options import-show "${nginx_key_file}" 2> /dev/null \
  | grep --quiet 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
ok_or_die 'Bad Nginx key'

readm nginx_apt_source << EOF
deb [signed-by=${nginx_key_file}] http://nginx.org/packages/debian ${lsb_release} nginx
EOF

nginx_apt_source_file=/etc/apt/sources.list.d/nginx.list
if file_changed nginx_apt_source; then
  file_write nginx_apt_source
  set_flag repositories_needs_update yes
  info_changed 'Nginx APT source successfully setup'
else
  info_already 'Nginx APT source already setup'
fi

readm nginx_apt_preferences << 'EOF'
Package: *
Pin: origin nginx.org
Pin: release o=nginx
Pin-Priority: 900
EOF

nginx_apt_preferences_file=/etc/apt/preferences.d/99nginx
if file_changed nginx_apt_preferences; then
  file_write nginx_apt_preferences
  info_changed 'Nginx APT preferences successfully setup'
else
  info_already 'Nginx APT preferences already setup'
fi
