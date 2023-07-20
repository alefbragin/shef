# shef__state__state_set_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/assign.sh
#.  shef/utils/die.sh
#.  shef/file/file_set.sh
#.  shef/file/file_sync.sh
#.  shef/file/file_changed.sh
#.  ./state_file.sh

shef__fn_alias state_set

# Set arbitary string as a state: assign it to appropriate variable and write to appropriate file.
#
# Arguments:
#   $1 State name. The name must be match `[a-z0-9_]+`.
#   $2 State. Default is `1`.
#
# Globals:
#   $shef__states__${1} State.
#   $shef__states__${1}_file Path of a file where state will be stored.
#
# Files:
#   in/out $(shef__state_file $1) File where state is stored.
#
# Dies if:
#   - cannot read or write state file.
shef__state_set() {
	shef__assign "shef__states__${1}" "${2:-1}"

	shef__state_set__file="$(shef__state_file "$1")" || shef__die
	shef__file_set "shef__states__${1}" "${shef__state_set__file}"
	if shef__file_changed "shef__states__${1}"; then
		shef__file_sync "shef__states__${1}"
	fi
}
