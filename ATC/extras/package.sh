#!/bin/bash

VERSION=$(cat platform.txt | grep "version=" | cut -f2 -d"=")

if [ ! -f platform.txt ]; then
    echo Launch this script from the root core folder as ./extras/package.sh
    exit 2
fi

if [ ! -d ../ArduinoCore-API ]; then
    git clone https://github.com/arduino/ArduinoCore-API.git ../ArduinoCore-API
fi

cp -r ../ArduinoCore-API/api cores/arduino

echo $VERSION

VARIANT=raceup
EXCLUDE_TAGS=--exclude-tag-all=.portenta_only

FILENAME=Raceup-renesas_${VARIANT}-${VERSION}.tar.bz2

CORE_BASE=`basename $PWD`
cd ..
tar $EXCLUDE_TAGS --exclude='*.vscode*' --exclude='*.tar.*' --exclude='*.json*' --exclude='*.git*' --exclude='*e2studio*' --exclude='*extras*' -cjhvf $FILENAME $CORE_BASE
cd -

mv ../$FILENAME .

CHKSUM=`sha256sum $FILENAME | awk '{ print $1 }'`
SIZE=`wc -c $FILENAME | awk '{ print $1 }'`

cat ./extras/package_raceup_VERSION_index.json.tmp |
    sed "s/%%VERSION%%/${VERSION}/" |
        sed "s/%%FILENAME_BOARD%%/${FILENAME}/" |
        sed "s/%%CHECKSUM_BOARD%%/${CHKSUM}/" |
        sed "s/%%SIZE_BOARD%%/${SIZE}/" > package_raceup_${VERSION}_index.json
