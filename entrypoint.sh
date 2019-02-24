#!/bin/sh

trap "exit 0" SIGINT SIGTERM

DUCKDNS_INTERVAL=${DUCKDNS_INTERVAL:-300} # default update interval is 300 seconds (5 minutes)
DUCKDNS_TIMEOUT=${DUCKDNS_TIMEOUT:-10} # default timeout is 10 seconds

if [ -z "$DUCKDNS_URL" ]; then
	echo 'Please supply the $DUCKDNS_URL environment variable'
	exit 1
fi

while true; do

	# HTTP request with output to stdout (only printable chars, oneline)
	echo "[$(date)]" $(wget -T $DUCKDNS_TIMEOUT -q -O - "$DUCKDNS_URL" 2>&1 | tr -c '\11\12\40-\377' ' ')
	
	# Sleep and loop
	sleep $DUCKDNS_INTERVAL
done

