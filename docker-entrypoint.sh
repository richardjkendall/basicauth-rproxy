#!/usr/bin/env sh
set -eu

envsubst '${REGION} ${TABLE} ${REALM}' < /aws.pam > /etc/pam.d/aws

exec "$@"
