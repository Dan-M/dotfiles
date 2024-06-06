#!/usr/bin/env bash

# Options
shutdown='󰐥'
reboot='󰑐'
lock='󰍁'
suspend='󰏦'
logout=''

# Rofi CMD
rofi_cmd() {
	tofi -c $HOME/.config/waybar/scripts/power-menu/tofi-config --width 150 --height 200 --prompt-text What?
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ $1 == '--shutdown' ]]; then
		systemctl poweroff
	elif [[ $1 == '--reboot' ]]; then
		systemctl reboot
	elif [[ $1 == '--suspend' ]]; then
		mpc -q pause
		amixer set Master mute
		systemctl suspend
	elif [[ $1 == '--logout' ]]; then
		loginctl terminate-user "$USER"
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
"$shutdown")
	run_cmd --shutdown
	;;
"$reboot")
	run_cmd --reboot
	;;
"$lock")
	hyprlock
	;;
"$suspend")
	run_cmd --suspend
	;;
"$logout")
	run_cmd --logout
	;;
esac
