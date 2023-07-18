###############
# Update Site #
###############

info_section 'Update Site'

rsync \
  --recursive \
  --delete \
  --links \
  --perms \
  "${uploads_dir}/${domain}/" \
  "/var/www/${domain}/"

ok_or_die
info_changed 'Site successfully updated'

ensure_service nginx
