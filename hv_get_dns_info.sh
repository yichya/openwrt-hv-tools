#!/bin/sh
cat /etc/resolv.conf 2>/dev/null | awk '/^nameserver/ { print $2 }'
