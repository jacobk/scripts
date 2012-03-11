#!/usr/bin/env bash

FORCE=false

while getopts f o; do
	case $o in
		f) FORCE=true;;
	esac
done

echo "Analyzing your system..."

user=`whoami`
topproc=`top -user $user -o cpu -stats pid,command,cpu -n 1 -l 3 | tail -n 1`
set -- $topproc

echo "$2 is consuming $3% CPU"

$FORCE || read -p "Kill it? [N]: " -r

if $FORCE || [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Killing pid $1"
    `kill -9 $1`
fi