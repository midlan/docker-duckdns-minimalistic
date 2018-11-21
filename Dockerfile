FROM alpine:latest

COPY entrypoint.sh /app/

ENTRYPOINT ["/app/entrypoint.sh"]

