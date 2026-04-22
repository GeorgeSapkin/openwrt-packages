#!/bin/sh

less --version | grep -F "$2"
[ -x /usr/libexec/less-gnu ] || { echo "FAIL: /usr/libexec/less-gnu not installed"; exit 1; }
