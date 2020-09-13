#!/bin/sh

set -e

echo '' # see https://github.com/actions/toolkit/issues/168

npm install && npm run build

DEPLOY_REPO="https://${ACCESS_TOKEN}@github.com/${REPOSITORY_NAME}.git"
