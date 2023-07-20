# shef__log__log_already_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  ./log_message.sh

shef__fn_alias log_already

shef__log_already() {
	shef__log_message "$1" '=== '
}
