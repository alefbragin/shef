# shef__log__log_skipped_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  ./log_message.sh

shef__fn_alias log_skipped

# Print message that the changes are skipped because they are turned off manually, to STDERR.
#
# Arguments:
#   $1 Text to be printed.
#
# Outputs:
#   STDERR The passed text that prefixed accordingly.
#
# Dies if:
#   - cannot print caption.
shef__log_skipped() {
	shef__log_message "$1" '~~~ '
}
