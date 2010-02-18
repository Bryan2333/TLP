#! /bin/sh
# tlp - restore ThinkPad wwan state after suspend / hibernate

. "${PM_FUNCTIONS}"

LIB=/usr/lib/tlp/tlp-rf-func
CFG=/etc/default/tlp

suspend_device () {
	savestate $1 `cat $2`
}

resume_device () {
	state_exists $1 || return
	restorestate $1 > $2
}

[ -f $LIB ] || exit 0
[ -f $CFG ] || exit 0

. $LIB
. $CFG
[ "$TLP_ENABLE" = "1" ] || exit 0

get_ctrl_device wwan
[ -n "$devc" ] || exit 0

case $1 in
	hibernate|suspend)
		suspend_device tp_wwan $devc
		;;
		
	thaw|resume)
		resume_device tp_wwan $devc
		;;
		
	*) exit $NA
		;;
esac
