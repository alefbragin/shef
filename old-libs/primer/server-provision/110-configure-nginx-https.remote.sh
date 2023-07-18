#########################
# Configure Nginx HTTPS #
#########################

info_section 'Configure Nginx HTTPS'

nginx_https_index_file="/var/www/${domain}/index.html"
if [ ! -f "${nginx_https_index_file}" ]; then
  mkdir --parent "$(dirname "${nginx_https_index_file}")" || die
  cat << 'EOF' > "${nginx_https_index_file}"
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="theme-color" content="#000000" />
    <meta
      name="description"
      content="Stub for site maintenance"
    />
    <title>Site under maintenance</title>
  </head>
  <body>
    <p>Under maintenance</p>
  </body>
</html>
EOF

  ok_or_die
  set_flag nginx_needs_reload yes
  info_changed 'Nginx HTTPS stub index file successfully created'
else
  info_already 'Nginx HTTPS index file already exists'
fi

htpasswd_file="/var/lib/nginx/${domain}.htpasswd"
if feature_needed nginx_basic_auth; then
  if file_changed htpasswd; then
    file_write htpasswd
    set_flag nginx_needs_reload yes
    info_changed 'Nginx htpasswd file successfully written'
  else
    info_already 'Nginx htpasswd file already written'
  fi

  readm nginx_basic_auth_fragment << EOF


    auth_basic "Restricted access";
    auth_basic_user_file ${htpasswd_file};
EOF
else
  nginx_basic_auth_fragment=''
fi

nginx_https_conf_file="/etc/nginx/conf.d/${domain}.https.conf"
readm nginx_https_conf << EOF
server {
  listen 443 ssl;
  server_name ${domain} www.${domain};

  ssl_certificate     /var/lib/dehydrated/certs/${domain}/fullchain.pem;
  ssl_certificate_key /var/lib/dehydrated/certs/${domain}/privkey.pem;

  root /var/www/${domain};

  location / {
    try_files \$uri /index.html =404;${nginx_basic_auth_fragment}
  }
}
EOF

if file_changed nginx_https_conf; then
  file_write nginx_https_conf
  set_flag nginx_needs_reload yes
  info_changed 'Nginx HTTPS successfully configured'
else
  info_already 'Nginx HTTPS already configured'
fi

ensure_service nginx
