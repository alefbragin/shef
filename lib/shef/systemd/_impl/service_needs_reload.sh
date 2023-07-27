# shef__systemd___impl__service_needs_reload__sh
#
# Dependencies:
#.	shef/state/state_set.sh
#.	./make_service_state_name.sh

shef__service_needs_reload() {
	shef_impl__make_service_state_name "$1" reload
	shef__state_set "$shef_impl__make_service_state_name__result" 1
}
