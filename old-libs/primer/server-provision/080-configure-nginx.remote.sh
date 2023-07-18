###################
# Configure Nginx #
###################

info_section 'Configure Nginx'

nginx_conf_file=/etc/nginx/nginx.conf

readm nginx_conf << 'EOF'

user  nginx;
worker_processes  auto;

error_log  /var/log/nginx/error.log notice;
pid        /var/run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    gzip  on;

    include /etc/nginx/conf.d/*.conf;
}
EOF

if file_changed nginx_conf; then
  file_write nginx_conf
  set_flag nginx_needs_reload yes
  info_changed 'Nginx successfully configured'
else
  info_already 'Nginx already configured'
fi

nginx_default_conf_file=/etc/nginx/conf.d/default.conf
if [ -f "${nginx_default_conf_file}" ]; then
  rm "${nginx_default_conf_file}" || die
  set_flag nginx_needs_reload yes
  info_changed 'Nginx default site config removed'
else
  info_already 'Nginx default site config does not exist'
fi
