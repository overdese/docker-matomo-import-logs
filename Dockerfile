FROM python:3.10.4-alpine

RUN apk update && apk add --no-cache \
    openssh-client \
    rsync \
    bash \
    && mkdir -p /logs \
    && mkdir -p /root/.ssh/ \
    && echo -e 'Host * \n \
    StrictHostKeyChecking no \n \
    UserKnownHostsFile /dev/null \n' \
    > /root/.ssh/config \
    && touch /main_script.sh \
    && chmod +x /main_script.sh

WORKDIR /app
COPY --from=matomo:4.9.1-fpm-alpine /usr/src/matomo/misc/log-analytics/ /app
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "/usr/sbin/crond", "-f"]
