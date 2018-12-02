FROM busybox:latest

COPY ./entrypoint.sh /usr/local/bin/entrypoint

ENTRYPOINT ["entrypoint"]

