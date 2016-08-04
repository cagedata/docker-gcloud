#!/bin/sh
#
# Entrypoint to running Google Cloud CLI.
# Borrowed from https://github.com/blacklabelops/gcloud/edit/master/imagescripts/docker-entrypoint.sh

set -e

GCLOUD_ROOT=/opt/google-cloud-sdk
GCLOUD="${GCLOUD_ROOT}/bin/gcloud"

if [ -n "${GCLOUD_ACCOUNT}" ]; then
  echo ${GCLOUD_ACCOUNT} >> "${GCLOUD_ROOT}/auth.base64"
  base64 -d "${GCLOUD_ROOT}/auth.base64" >> "${GCLOUD_ROOT}/auth.json"
  ${GCLOUD} auth activate-service-account \
    --key-file="${GCLOUD_ROOT}/auth.json" \
    ${GCLOUD_ACCOUNT_EMAIL}
fi

if [ -n "${GCLOUD_ACCOUNT_FILE}" ]; then
  ${GCLOUD} auth activate-service-account --keyfile=${GCLOUD_ACCOUNT_FILE}
fi

exec "$@"
