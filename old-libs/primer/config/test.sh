provision_dir=/var/lib/provision
uploads_dir="${provision_dir}/uploads"

domain=test.magicalchemy.org

dehydrated_ca=letsencrypt
dehydrated_ca_hash=aHR0cHM6Ly9hY21lLXYwMi5hcGkubGV0c2VuY3J5cHQub3JnL2RpcmVjdG9yeQo

nginx_basic_auth_needed=yes

# htpasswd can be created as `echo tester | htpasswd -c -B -i >(xclip -sel clip) tester 2> /dev/null`
readm htpasswd << 'EOF'
tester:$2y$05$8Huq8cNJdri97ObEZxWwtO1bZ3ORQQKC0zp6jtEMYOlrOo37brKyu
EOF

# Staging dehydrated_ca
# dehydrated_ca=letsencrypt-test
# dehydrated_ca_hash=aHR0cHM6Ly9hY21lLXN0YWdpbmctdjAyLmFwaS5sZXRzZW5jcnlwdC5vcmcvZGlyZWN0b3J5Cg
