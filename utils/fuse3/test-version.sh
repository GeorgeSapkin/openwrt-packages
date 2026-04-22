#!/bin/sh
case "$1" in
fuse3-utils)
	fusermount3 --version 2>&1 | grep -qF "$2"
	;;
libfuse3)
	exit 0
	;;
esac
