# shef__storage__storage_upload_dir_impl_sh
#
# Dependencies:
#.   shef/config/storage.sh
#.   shef/utils/die.sh

shef__storage_upload_dir() {
	shef__storage_upload_dir__dest="$2:${SHEF_STORAGE_PATH}/uploads/$3"
	rsync \
		--recursive \
		--delete \
		--links \
		--perms \
		--compress \
		--mkpath \
		"${1}/" \
		"${shef__storage_upload_dir__dest}" \
			|| shef__die "upload dir $1 to ${shef__storage_upload_dir__dest}"
}
