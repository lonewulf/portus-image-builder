#!/bin/bash

set -e

if [ $# -eq 0 ] ; then
	echo "Usage: ./update.sh <tag or branch>"
	exit
fi

VERSION=$1

cd `dirname $0`
rm -rf Portus/
echo "Fetching and building distribution $VERSION..."
git clone -b $VERSION https://github.com/SUSE/Portus.git

echo "Done."
