# shef__state__state_file_sh
#
# Dependencies:
#.  shef/utils/println.sh
#.  shef/config/storage_path.sh

shef__state_file() {
	shef__println "${SHEF_STORAGE_PATH}/state/$1"
}
