#!/bin/sh
#
# Entrypoint to running Google Cloud CLI.
# Borrowed from https://github.com/blacklabelops/gcloud/edit/master/imagescripts/docker-entrypoint.sh

set -e

GCLOUD_ROOT=/opt/google-cloud-sdk
GCLOUD="${GCLOUD_ROOT}/bin/gcloud"

if [ -n "${GCLOUD_ACCOUNT_FILE}" ]; then
  ${GCLOUD} auth activate-service-account --keyfile="${GCLOUD_ACCOUNT_FILE}"
fi

if [ -n "${GCLOUD_ACCOUNT}" ]; then
  export GCLOUD_ACCOUNT_FILE="${GCLOUD_ROOT}/auth.json"
  echo "${GCLOUD_ACCOUNT}" | base64 -d > "${GCLOUD_ACCOUNT_FILE}"
  ${GCLOUD} auth activate-service-account \
    --key-file="${GCLOUD_ROOT}/auth.json" \
    "${GCLOUD_ACCOUNT_EMAIL}"
fi

export GOOGLE_APPLICATION_CREDENTIALS="${GCLOUD_ACCOUNT_FILE}"

if [ -n "${KUBE_CLUSTER}" ]; then
  ${GCLOUD} container clusters get-credentials "${KUBE_CLUSTER}"
fi

exec "$@"
