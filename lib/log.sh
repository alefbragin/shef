# Printing log messages.
#
# Dependencies:
#.  shef/utils

##
# Print fancy caption to STDERR.
#
# Arguments:
#   $1 Caption text.
#
# Outputs:
#   STDERR The passed text that decorated accordingly.
#
# Dies if:
#   - cannot print caption.
##
log_caption() {
	mainline="# $1 #"
	border="$(stdin_arg "${mainline}" tr '[:print:]' '#')" || die 'cannot make caption border'
	cat <<- EOF 1>&2 || die 'cannot print caption'

		${SHEF_RUNNER:+${SHEF_RUNNER}:${SHEF_NL}}
		${border}
		${mainline}
		${border}

	EOF
}

##
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
##
log_message() {
	printf "${SHEF_RUNNER:+${SHEF_RUNNER}: }$2%s\n" "$1" 1>&2 || exit 1
}

##
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
##
log_changed() {
	log_message "$1" '+++ '
}

##
# Print message that the required state has already been achived, to STDERR.
#
# Arguments:
#   $1 Text to be printed.
#
# Outputs:
#   STDERR The passed text that prefixed accordingly.
#
# Dies if:
#   - cannot print caption.
##
log_already() {
	log_message "$1" '=== '
}

##
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
##
log_skipped() {
	log_message "$1" '~~~ '
}

##
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
##
log_info() {
	log_message "$1" '### '
}
