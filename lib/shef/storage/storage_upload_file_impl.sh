# shef__storage__storage_upload_file_impl_sh
#
# Dependencies:
#.   shef/config/storage.sh
#.   shef/utils/die.sh

shef__storage_upload_file() {
	shef__storage_upload_file__dest="$2:${SHEF_STORAGE_PATH}/uploads/$3"
	rsync \
		--progress \
		--perms \
		--compress \
		--mkpath \
		"$1" \
		"${shef__storage_upload_file__dest}" \
			|| shef__die "upload file $1 to ${shef__storage_upload_file__dest}"
}
