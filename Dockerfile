FROM python:3.10.4-slim-bullseye
RUN apt-get update \
    && apt-get install -y -qq --no-install-recommends \
        openssh-client \
        rsync \
        cron \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && mkdir -p /logs \
    && mkdir -p /root/.ssh/ \
    && echo 'Host *\n\
    StrictHostKeyChecking no \n\
    UserKnownHostsFile /dev/null \n' \
    > /root/.ssh/config

WORKDIR /app
COPY --from=matomo:4.9.1-fpm-alpine /usr/src/matomo/misc/log-analytics/ /app
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

