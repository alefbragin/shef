##########################
# Prepare Frontend Build #
##########################

info_section 'Prepare Frontend Build'

CI=true ./scripts/build-frontend || die
info_changed 'Frontend successfully built'

rsync \
  --recursive \
  --delete \
  --links \
  --perms \
  --compress \
  --mkpath \
  "./frontend/build/" \
  "root@${host}:${uploads_dir}/${domain}/"

ok_or_die
info_changed 'Frontend build successfully uploaded'
