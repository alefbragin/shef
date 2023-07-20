# shef__log__log_message_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh

shef__fn_alias log_message

# Print message with optional prefix to STDERR.
#
# Arguments:
#   $1 Text to be printed.
#   $2 Optional prefix.
#
# Outputs:
#   STDERR The passed text that prefixed accordingly.
#
# Dies if:
#   - cannot print caption.
shef__log_message() {
	printf "${SHEF_RUNNER:+${SHEF_RUNNER}: }$2%s\n" "$1" 1>&2 || exit 1
}
