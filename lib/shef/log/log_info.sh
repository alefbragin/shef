# shef__log__log_info_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  ./log_message.sh

shef__fn_alias log_info

# Print message without any special meaning to STDERR.
#
# Arguments:
#   $1 Text to be printed.
#
# Outputs:
#   STDERR The passed text that prefixed accordingly.
#
# Dies if:
#   - cannot print caption.
shef__log_info() {
	shef__log_message "$1" '### '
}
