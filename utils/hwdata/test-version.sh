#!/bin/sh
# Data-only packages; no executables to version-check
case "$1" in
pciids|usbids|pnpids) exit 0 ;;
esac
