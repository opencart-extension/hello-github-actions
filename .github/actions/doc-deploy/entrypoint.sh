#!/bin/sh

set -e

echo '' # see https://github.com/actions/toolkit/issues/168

# Build vuepress project
echo "==> Start building \n $BUILD_SCRIPT"
eval "$BUILD_SCRIPT"
echo "Build success"

# Change directory to the dest
echo "==> Changing directory to '$BUILD_DIR' ..."
cd $BUILD_DIR

# Get respository
if [[ -z "$TARGET_REPO" ]]; then
  REPOSITORY_NAME="${GITHUB_REPOSITORY}"
else
  REPOSITORY_NAME="$TARGET_REPO"
fi

# Final repository
DEPLOY_REPO="https://${ACCESS_TOKEN}@github.com/${REPOSITORY_NAME}.git"
if [ "$TARGET_LINK" ]; then
  DEPLOY_REPO="$TARGET_LINK"
fi

echo "==> Prepare to deploy"

git init
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

if [ -z "$(git status --porcelain)" ]; then
    echo "The BUILD_DIR is setting error or nothing produced" && \
    echo "Exiting..."
    exit 0
fi

# Generate a CNAME file
if [ "$CNAME" ]; then
  echo "Generating a CNAME file..."
  echo $CNAME > CNAME
fi

echo "==> Starting deploying"

git add -A
git commit -m 'Auto deploy from Github Actions'
git push --force --delete $DEPLOY_REPO ${BRANCH_TO:-gh-pages}
git push --force $DEPLOY_REPO ${BRANCH_FROM:-master}:${BRANCH_TO:-gh-pages}
rm -fr .git

cd $GITHUB_WORKSPACE

echo "Successfully deployed!" && \
echo "See: https://github.com/$REPOSITORY_NAME/tree/${BRANCH_TO:-gh-pages}"