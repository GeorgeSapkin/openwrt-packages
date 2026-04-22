#!/bin/sh

case "$1" in
	fuse3-utils)
		fusermount3 --version 2>&1 | grep -F "$2"
		[ -x /usr/sbin/mount.fuse3 ]
		;;
	libfuse3)
		ls /usr/lib/libfuse3.so.* > /dev/null
		;;
esac
