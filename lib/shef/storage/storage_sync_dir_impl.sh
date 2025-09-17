# shef__storage__storage_sync_dir_impl_sh
#
# Dependencies:
#.   shef/config/storage.sh
#.   shef/utils/die.sh

shef__storage_sync_dir() {
	shef__storage_sync_dir__extra_opt="$3"
	shef__storage_sync_dir__src="${SHEF_STORAGE_PATH}/uploads/$1/"
	rsync \
		--recursive \
		--delete \
		--links \
		--perms \
		--mkpath \
		$shef__storage_sync_dir__extra_opt \
		"${shef__storage_sync_dir__src}" \
		"$2" \
			|| shef__die "sync dir ${shef__storage_sync_dir__src} to $2"
}
