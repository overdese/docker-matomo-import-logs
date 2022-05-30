#!/bin/sh

if [ -f "/tmp/cron_root" ]; then
    cat /tmp/cron_root > /etc/crontabs/root
fi

exec "$@"
