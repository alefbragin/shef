# Printing log messages.
#
# Dependencies:
#.  shef/fn-alias
#.  shef/utils

shef__function_aliases \
	caption \
	message \
	changed \
	already \
	skipped \
	info

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
shef__log_caption() {
	shef__log_caption__mainline="# $1 #"
	shef__log_caption__border="$(shef__stdin_arg "${shef__log_caption__mainline}" \
		tr '[:print:]' '#')" || shef__die 'make caption border'

	cat <<- EOF 1>&2 || shef__die 'print caption'

		${SHEF_RUNNER:+${SHEF_RUNNER}:${SHEF_NL}}
		${shef__log_caption__border}
		${shef__log_caption__mainline}
		${shef__log_caption__border}

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
shef__log_message() {
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
shef__log_changed() {
	shef__log_message "$1" '+++ '
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
shef__log_already() {
	shef__log_message "$1" '=== '
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
shef__log_skipped() {
	shef__log_message "$1" '~~~ '
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
shef__log_info() {
	shef__log_message "$1" '### '
}
