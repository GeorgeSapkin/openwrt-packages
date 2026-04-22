#!/bin/sh
case "$1" in
sispmctl)
	sispmctl --version 2>&1 | grep -qF "$2"
	;;
libsispmctl)
	exit 0
	;;
esac
