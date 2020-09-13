#!/bin/sh

set -e

echo '' # see https://github.com/actions/toolkit/issues/168

echo "CMD: npm install && npm run build"
npm install && npm run build

echo "CMD: Set DEPLOY_REPO"
DEPLOY_REPO="https://${ACCESS_TOKEN}@github.com/${REPOSITORY_NAME}.git"

echo "CMD: git checkout gh-pages"
git checkout -b gh-pages

echo "CMD: rm -rf *"
rm -rf *

echo "CMD: git add -A"
git add -A

echo "CMD: git commit Remove files"
git commit -m "Remove files"

echo "CMD: git checkout documentation -- src/.vuepress/dist"
git checkout documentation -- src/.vuepress/dist

echo "CMD: git add -A"
git add -A

echo "CMD: git commit Auto deploy"
git commit -m "Auto deploy"

echo "CMD: git push"
git push -f $DEPLOY_REPO gh-pages