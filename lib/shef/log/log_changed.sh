# shef__log__log_changed_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  ./log_message.sh

shef__fn_alias log_changed

# Print message that the changes have occurred, to STDERR.
#
# Arguments:
#   $1 Text to be printed.
#
# Outputs:
#   STDERR The passed text that prefixed accordingly.
#
# Dies if:
#   - cannot print caption.
shef__log_changed() {
	shef__log_message "$1" '+++ '
}
