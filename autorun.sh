#!/bin/sh

run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run "lxqt-policykit-agent"
run "picom"
run "nm-applet"
run "polychromatic-tray-applet"
run "kmix"
run "playerctld daemon"
