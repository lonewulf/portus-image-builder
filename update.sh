#!/bin/bash

set -e

if [ $# -eq 0 ] ; then
	echo "Usage: ./update.sh <tag or branch>"
	exit
fi

GIT_VERSION=$1

cd `dirname $0`
rm -rf Portus/
echo "Fetching and building Portus $GIT_VERSION..."
git clone -b $GIT_VERSION https://github.com/SUSE/Portus.git
cd Portus
BRANCH=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`
COMMIT=`git log --pretty=format:'%h' -n 1`
TAG=`git tag --points-at $(git rev-parse HEAD)`

if [ -n "$TAG" ]; then
    VERSION=$TAG
else
  if [ -n "$COMMIT" ]; then
    if [ -n "$BRANCH" ]; then
      VERSION="${BRANCH}@${COMMIT}"
    else
      VERSION=$COMMIT
    fi
  fi
fi

if [ -n "$VERSION" ]; then
  echo $VERSION > VERSION
fi

echo "Done."
