####################
# Sign Cerificates #
####################

info_section 'Sign Cerificates'

ensure_service nginx

dehydrated_log=/var/log/dehydrated/cron.log
ensure_directory_for_file "${dehydrated_log}"

dehydrated_exitcode=0
{
  dehydrated --cron
  dehydrated_exitcode=$?
} | tee --append "${dehydrated_log}" || die "Can't append to Dehydrated log"
[ "${dehydrated_exitcode}" -eq 0 ] || die "Can't setup or renew TLS certs"

dehydrated_logrotate_file=/etc/logrotate.d/dehydrated
readm dehydrated_logrotate << EOF
${dehydrated_log} {
  rotate 1024
  weekly
  maxsize 128k
  compress
  missingok
  notifempty
}
EOF

if file_changed dehydrated_logrotate; then
  file_write dehydrated_logrotate
  info_changed 'Logrotate for Dehydrated successfully setup'
else
  info_already 'Logrotate for Dehydrated already setup'
fi

dehydrated_cron_file=/etc/cron.d/dehydrated
readm dehydrated_cron << EOF
0 0 * * *	root	dehydrated --cron --keep-going >> ${dehydrated_log}
EOF

if file_changed dehydrated_cron; then
  file_write dehydrated_cron
  chmod 600 "${dehydrated_cron_file}"
  info_changed 'Cronjob for Dehydrated successfully setup'
else
  info_already 'Cronjob for Dehydrated already setup'
fi
