# shef__log__log_caption_sh
#
# Dependencies:
#.  shef/utils/fn_alias.sh
#.  shef/utils/die.sh
#.  shef/utils/arg.sh
#.  ./log_message.sh

shef__fn_alias log_caption

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
shef__log_caption() {
	shef__log_caption__mainline="# $1 #"
	shef__log_caption__border="$(shef__arg "${shef__log_caption__mainline}" \
		tr '[:print:]' '#')" || shef__die 'make caption border'

	cat <<- EOF 1>&2 || shef__die 'print caption'

		${SHEF_RUNNER:+${SHEF_RUNNER}:${SHEF_NL}}
		${shef__log_caption__border}
		${shef__log_caption__mainline}
		${shef__log_caption__border}

	EOF
}
