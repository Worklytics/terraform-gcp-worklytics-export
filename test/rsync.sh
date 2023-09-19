#!/bin/bash

# Usage:
# ./rsync.sh

EXAMPLE_TENANT_SA_EMAIL=$1
BUCKET_NAME=$2

# https://cloud.google.com/sdk/gcloud/reference/auth/print-identity-token
CI_RUN=`date +%Y%m%d'T'%H%M%S`

# should work, assuming you're running this somewhere that your gcloud CLI is auth'd as something
# that can impersonate the target service account
GCP_TOKEN=`gcloud auth print-identity-token --impersonate-service-account=${EXAMPLE_TENANT_SA_EMAIL}`

echo "EXAMPLE_TENANT_SA_EMAIL: ${EXAMPLE_TENANT_SA_EMAIL}"
echo "BUCKET_NAME: ${BUCKET_NAME}"

# if bucket exists + perms OK, this should work
mkdir /tmp/$CI_RUN
echo "TEST" > /tmp/$CI_RUN/test.txt
gsutil --impersonate-service-account=${EXAMPLE_TENANT_SA_EMAIL} -m rsync -r /tmp/$CI_RUN gs://$BUCKET_NAME
