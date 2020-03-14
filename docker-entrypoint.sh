#!/usr/bin/env sh
set -eu

envsubst '${REGION} ${TABLE} ${REALM} ${CACHE_FOLDER} ${CACHE_DURATION}' < /aws.pam > /etc/pam.d/aws
envsubst '${UPSTREAM}' < /apache.conf > /etc/apache2/sites-available/000-default.conf

exec "$@"
