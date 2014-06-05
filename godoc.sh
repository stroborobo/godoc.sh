#!/bin/sh
set -e

MAXWIDTH=79
width=`tput cols`
if [ $width -gt $MAXWIDTH ]; then
	width=$MAXWIDTH
fi
r=$READER
if [ "1$r" = "1" ]; then
	r="less"
fi

search=0
url='http://godoc.org/'
if [ "1$1" = "1-s" ]; then
	shift
	url="${url}?q="
	search=1
fi

if [ "1$*" = "1" ]; then
	echo "Usage: $0 [-s] <import-path>" >&2
	echo "       -s: search" >&2
	exit 1
fi

url="${url}$*"
out=`curl --silent --header 'Accept: text/plain' "$url"`

if [ $search -eq 1 ]; then
	echo "$out" | head -10 | sed -E 's/^([-a-zA-Z0-9._/]+) /[1;34m\1 [0m\
    /'
else
	echo "$out" | $r
fi
