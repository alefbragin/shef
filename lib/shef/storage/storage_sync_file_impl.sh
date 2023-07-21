# shef__storage__storage_sync_file_impl_sh
#
# Dependencies:
#.   shef/config/storage.sh
#.   shef/utils/die.sh

shef__storage_sync_file() {
	shef__storage_sync_file__src="${SHEF_STORAGE_PATH}/uploads/$1"
	rsync \
		--perms \
		--mkpath \
		"${shef__storage_sync_file__src}" \
		"$2" \
			|| shef__die "sync file ${shef__storage_sync_file__src} to $1"
}
