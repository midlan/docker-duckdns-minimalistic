FROM busybox:latest

COPY entrypoint.sh /app/

ENTRYPOINT ["/app/entrypoint.sh"]

