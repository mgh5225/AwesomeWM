#!/bin/sh

run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run "lxpolkit"
run "picom"
run "nm-applet"
run "polychromatic-tray-applet"
run "pasystray"
run "playerctld daemon"
run "greenclip daemon"
