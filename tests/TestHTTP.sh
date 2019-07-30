#!/bin/sh

set -ev

BUILD_IMAGE_NAME=test_build
BUILD_CONTAINER_NAME=test_container

HTTPD_CONTAINER_NAME=httpd
HTTP_STRING=${TRAVIS_BUILD_ID:-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)}

# start HTTP server
docker run --rm -d --name $HTTPD_CONTAINER_NAME  busybox sh -c "cd /var/www && echo $HTTP_STRING > index.html && httpd -f -vv -u www-data:www-data"

# build
docker build -t $BUILD_IMAGE_NAME "$(dirname "$0")/../"

# run
docker run --rm -d --name=$BUILD_CONTAINER_NAME --link=$HTTPD_CONTAINER_NAME -e DUCKDNS_URL=$HTTPD_CONTAINER_NAME -e DUCKDNS_INTERVAL=1 $BUILD_IMAGE_NAME

# test downloaded string match to served
attempts=0

while ! docker logs $BUILD_CONTAINER_NAME | grep $HTTP_STRING
do
	attempts=$((attempts+1))

	if [ "$attempts" -ge 30 ]; then
		echo "$attempts attemps reached; Exiting!" 1>&2
		exit 1
	fi

	sleep 1
done

# clean
docker stop $BUILD_CONTAINER_NAME $HTTPD_CONTAINER_NAME
docker image rm $BUILD_IMAGE_NAME

