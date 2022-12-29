# Install packages and upgrade system.
#
# Dependencies:
#.  shef/utils
#.  shef/state
#.  shef/log

service_variable_name() {
	stdin_arg "service_$1" tr - _ \
		|| die "cannot make service variable name from: '$1'"
}

service_set_reload_needness() {
	service_varname="$(service_variable_name "$1")" || die
	state_set "${service_varname}_needs_reload" "$2"
}

service_ensure() {
	if ! systemctl is-active "$1" > /dev/null; then
		systemctl start "$1" \
			|| die "cannot start service: '$1'"

		log_changed "service successfully changed: '$1'"
	else
		log_already "service already active: '$1'"

		service_varname="$(service_variable_name "$1")" || die

		if state "${service_varname}_needs_reload" yes; then
			systemctl reload "$1" \
				|| die "cannot reload service: '$1'"

			state_set "${service_varname}_needs_reload" "$1" no

			log_changed "service successfully reloaded: '$1'"
		else
			log_already "service does not need reload: '$1'"
		fi
	fi
}
