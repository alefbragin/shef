# shef__utils__fn_alias_sh

shef__fn_alias() {
	eval "$1(){ shef__$1 \"\$@\";}"
}
