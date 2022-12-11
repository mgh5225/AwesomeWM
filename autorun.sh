#!/bin/sh

run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run "lxqt-policykit-agent"
run "picom"
run "nm-applet"
