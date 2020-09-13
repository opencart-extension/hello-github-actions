#!/bin/sh

set -e

echo '' # see https://github.com/actions/toolkit/issues/168

echo "npm install && npm run build"
npm install && npm run build

echo "Set DEPLOY_REPO"
DEPLOY_REPO="https://${ACCESS_TOKEN}@github.com/${REPOSITORY_NAME}.git"

echo "git checkout gh-pages"
git checkout gh-pages

echo "git checkout documentation -- src/.vuepress/dist"
git checkout documentation -- src/.vuepress/dist

echo "git add -A"
git add -A

echo "git commit"
git commit -m "Auto deploy"

echo "git push"
git push -f $DEPLOY_REPO gh-pages