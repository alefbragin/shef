####################################
# Install and Configure Dehydrated #
####################################

info_section 'Install and Configure Dehydrated'

install_package dehydrated

dehydrated_hook_file=/etc/dehydrated/hook.sh

readm dehydrated_hook << 'EOF'
#!/bin/bash

deploy_cert() {
  systemctl reload nginx
}

HANDLER="$1"; shift
if [[ "${HANDLER}" = deploy_cert ]]; then
  "$HANDLER" "$@"
fi
EOF

if file_changed dehydrated_hook; then
  file_write dehydrated_hook
  chmod +x "${dehydrated_hook_file}" || die
  info_changed 'Dehydrated hook successfully created'
else
  info_already 'Dehydrated hook already exists'
fi

dehydrated_config_file=/etc/dehydrated/config
readm dehydrated_config << EOF
CONFIG_D=/etc/dehydrated/conf.d
BASEDIR=/var/lib/dehydrated
WELLKNOWN="\${BASEDIR}/acme-challenges"
DOMAINS_TXT=/etc/dehydrated/domains.txt
HOOK=/etc/dehydrated/hook.sh
CA=${dehydrated_ca}
EOF

if file_changed dehydrated_config; then
  file_write dehydrated_config
  info_changed 'Dehydrated config successfully setup'
else
  info_already 'Dehydrated config already setup'
fi

dehydrated_domains_file="/etc/dehydrated/domains.txt"
readm dehydrated_domains << EOF
${domain} www.${domain}
EOF

if file_changed dehydrated_domains; then
  file_write dehydrated_domains
  info_changed 'Dehydrated domains successfully setup'
else
  info_already 'Dehydrated domains already setup'
fi

dehydrated_account_key_file="/var/lib/dehydrated/accounts/${dehydrated_ca_hash}/account_key.pem"
if [ ! -f "${dehydrated_account_key_file}" ]; then
  dehydrated --register --accept-terms || die
  info_changed 'Dehydrated account successfully registered'
else
  info_already 'Dehydrated account already registered'
fi
