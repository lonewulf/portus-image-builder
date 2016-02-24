#!/bin/bash
HASH=$(docker images -q quay.io/lonewulf/portus)
if [ $HASH == $OLD_HASH ]; then
  echo "Image already exists"
elif [ $TRAVIS_PULL_REQUEST == "false" ] && [ $PORTUS_VERSION == "master" ] && [ $TRAVIS_BRANCH == "master" ]; then
  SHA=$(cat Portus/VERSION | cut -d '@' -f 2)
  docker tag quay.io/lonewulf/portus "quay.io/lonewulf/portus:${SHA}"
  docker login -u "${DOCKER_USERNAME}" -p "${DOCKER_PASSWORD}" -e "." quay.io
  docker push quay.io/lonewulf/portus
else
  echo "Not pushing"
fi
