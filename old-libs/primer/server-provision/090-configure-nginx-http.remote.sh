########################
# Configure Nginx HTTP #
########################

info_section 'Configure Nginx HTTP'

nginx_http_conf_file="/etc/nginx/conf.d/${domain}.http.conf"

readm nginx_http_conf << EOF
server {
  listen 80;
  server_name ${domain} www.${domain};

  location ^~ /.well-known/acme-challenge {
    alias /var/lib/dehydrated/acme-challenges;
  }

  location / {
    return 301 https://\$host\$request_uri;
  }
}
EOF

if file_changed nginx_http_conf; then
  file_write nginx_http_conf
  set_flag nginx_needs_reload yes
  info_changed 'Nginx HTTP successfully configured'
else
  info_already 'Nginx HTTP already configured'
fi
