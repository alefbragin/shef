# shef__systemd___impl__ensure_service__sh
#
# Dependencies:
#.	shef/utils/die.sh
#.	shef/log/log_changed.sh
#.	shef/log/log_already.sh
#.	shef/state/state_set.sh
#.	shef/state/state_check.sh
#.	./make_service_state_name.sh

shef__ensure_service() {
	if [ "$1" = '--privileged' ]; then
		shef__ensure_service__doas_privileged=sudo
		shift
	fi
	if ! systemctl is-active "$1" > /dev/null; then
		$shef__ensure_service__doas_privileged \
			systemctl start "$1" || die "start service: '$1'"
		shef__log_changed "service was successfully started: '$1'"
	else
		shef__log_already "service is already active: '$1'"

		shef_impl__make_service_state_name "$1" restart
		if shef__state_check "$shef_impl__make_service_state_name__result"; then
			$shef__ensure_service__doas_privileged \
				systemctl restart "$1" || die "restart service: '$1'"
			shef__state_set "$shef_impl__make_service_state_name__result" 0
			shef__log_changed "service was successfully restarted: '$1'"
		else
			shef__log_already "service does not need restart: '$1'"

			shef_impl__make_service_state_name "$1" reload
			if shef__state_check "$shef_impl__make_service_state_name__result"; then
				$shef__ensure_service__doas_privileged \
					systemctl reload "$1" || die "reload service: '$1'"
				shef__state_set "$shef_impl__make_service_state_name__result" 0
				shef__log_changed "service was successfully reloaded: '$1'"
			else
				shef__log_already "service does not need reload: '$1'"
			fi
		fi
	fi
}
