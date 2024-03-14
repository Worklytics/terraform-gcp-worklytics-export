#!/bin/bash

# Usage:
# ./rsync.sh

EXAMPLE_TENANT_SA_EMAIL=$1
BUCKET_NAME=$2
CI_RUN=$3


echo "EXAMPLE_TENANT_SA_EMAIL: ${EXAMPLE_TENANT_SA_EMAIL}"
echo "BUCKET_NAME: ${BUCKET_NAME}"

# if bucket exists + perms OK, this should work
mkdir /tmp/$CI_RUN
echo "TEST" > /tmp/$CI_RUN/test.txt
gsutil --impersonate-service-account=${EXAMPLE_TENANT_SA_EMAIL} -m rsync -r /tmp/$CI_RUN gs://$BUCKET_NAME
