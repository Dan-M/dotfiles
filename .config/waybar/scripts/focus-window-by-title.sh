#!/usr/bin/env bash

if [ -z "$1" ]; then
	echo "Need to provide the window title"
	exit 1
fi
hyprctl dispatch focuswindow address:"$(hyprctl clients -j | gojq -r --arg title "$1" '.[] | select(.title == $title) | .address')"
