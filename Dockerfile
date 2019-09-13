FROM kong:1.3.0-alpine
RUN apk add postgresql-client
STOPSIGNAL SIGQUIT
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["kong", "docker-start"]