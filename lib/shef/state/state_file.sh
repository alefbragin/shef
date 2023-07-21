# shef__state__state_file_sh
#
# Dependencies:
#.  shef/config/storage.sh
#.  shef/utils/println.sh

shef__state_file() {
	shef__println "${SHEF_STORAGE_PATH}/state/$1"
}
