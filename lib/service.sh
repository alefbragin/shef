# Install packages and upgrade system.
#
# Dependencies:
#.  shef/fn-alias
#.  shef/utils
#.  shef/state
#.  shef/log

shef__function_aliases \
	service_set_reload \
	service_ensure

shef__service_variable_name() {
	shef__stdin_arg "service_$1" tr - _ \
		|| shef__die "make service variable name from: '$1'"
}

shef__service_set_reload() {
	shef__service_set_reload__name="$(shef__service_variable_name "$1")" || shef__die
	shef__state_set "${shef__service_set_reload__name}_needs_reload" "$2"
}

shef__service_ensure() {
	if ! systemctl is-active "$1" > /dev/null; then
		systemctl start "$1" \
			|| shef__die "start service: '$1'"

		shef__log_changed "service successfully changed: '$1'"
	else
		shef__log_already "service already active: '$1'"

		shef__service_ensure__name="$(shef__service_variable_name "$1")" || shef__die

		if shef__check_state "${shef__service_ensure__name}_needs_reload"; then
			systemctl reload "$1" \
				|| shef__die "reload service: '$1'"

			shef__state_set "${shef__service_ensure__name}_needs_reload" "$1" no

			shef__log_changed "service successfully reloaded: '$1'"
		else
			shef__log_already "service does not need reload: '$1'"
		fi
	fi
}
