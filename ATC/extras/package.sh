#!/bin/bash


package_board(){
    git checkout boards.txt
    git checkout platform.txt

    sed -i 's/#$1./$1./g' boards.txt

    VARIANT=raceup
    EXCLUDE_TAGS=--exclude-tag-all=.portenta_only

    FILENAME=ArduinoCore-renesas_$VARIANT-$VERSION.tar.bz2

    CORE_BASE=`basename $PWD`
    cd ..
    tar $EXCLUDE_TAGS --exclude='*.vscode*' --exclude='*.tar.*' --exclude='*.json*' --exclude='*.git*' --exclude='*e2studio*' --exclude='*extras*' -cjhvf $FILENAME $CORE_BASE
    cd -

    mv ../$FILENAME .

    CHKSUM=`sha256sum $FILENAME | awk '{ print $1 }'`
    SIZE=`wc -c $FILENAME | awk '{ print $1 }'`

    cat package_renesas_${VERSION}_index.json.tmp |
        # sed "s/%%BUILD_NUMBER%%/${BUILD_NUMBER}/" |
            # sed "s/%%CURR_TIME%%/${CURR_TIME_SED}/" |
            sed "s/%%VERSION%%/${VERSION}/" |
                sed "s/%%FILENAME_UNO%%/${FILENAME}/" |
                sed "s/%%CHECKSUM_UNO%%/${CHKSUM}/" |
                sed "s/%%SIZE_UNO%%/${SIZE}/" > package_renesas_${VERSION}_index.json

            cat package_renesas_${VERSION}_index.json
        }

if [ ! -f platform.txt ]; then
  echo Launch this script from the root core folder as ./extras/package.sh
  exit 2
fi

if [ ! -d ../ArduinoCore-API ]; then
  git clone https://github.com/arduino/ArduinoCore-API.git ../ArduinoCore-API
fi

git checkout boards.txt
git checkout platform.txt


VERSION=`cat platform.txt | grep "version=" | cut -f2 -d"="`
echo $VERSION


package_board "atc"

git checkout boards.txt
git checkout platform.txt

#atc

# VARIANT=atc
# EXCLUDE_TAGS=--exclude-tag-all=.portenta_only
#
# FILENAME=ArduinoCore-renesas_$VARIANT-$VERSION.tar.bz2
#
# CORE_BASE=`basename $PWD`
# cd ..
# tar $EXCLUDE_TAGS --exclude='*.vscode*' --exclude='*.tar.*' --exclude='*.json*' --exclude='*.git*' --exclude='*e2studio*' --exclude='*extras*' -cjhvf $FILENAME $CORE_BASE
# cd -
#
# mv ../$FILENAME .
#
# CHKSUM=`sha256sum $FILENAME | awk '{ print $1 }'`
# SIZE=`wc -c $FILENAME | awk '{ print $1 }'`
#
# cat package_renesas_${VERSION}_index.json.tmp |
# # sed "s/%%BUILD_NUMBER%%/${BUILD_NUMBER}/" |
# # sed "s/%%CURR_TIME%%/${CURR_TIME_SED}/" |
# sed "s/%%VERSION%%/${VERSION}/" |
# sed "s/%%FILENAME_UNO%%/${FILENAME}/" |
# sed "s/%%CHECKSUM_UNO%%/${CHKSUM}/" |
# sed "s/%%SIZE_UNO%%/${SIZE}/" > package_renesas_${VERSION}_index.json
#
# cat package_renesas_${VERSION}_index.json
#
# VARIANT=smu
# EXCLUDE_TAGS=--exclude-tag-all=.portenta_only
#
# FILENAME=ArduinoCore-renesas_$VARIANT-$VERSION.tar.bz2
#
# CORE_BASE=`basename $PWD`
# cd ..
# tar $EXCLUDE_TAGS --exclude='*.vscode*' --exclude='*.tar.*' --exclude='*.json*' --exclude='*.git*' --exclude='*e2studio*' --exclude='*extras*' -cjhvf $FILENAME $CORE_BASE
# cd -
#
# mv ../$FILENAME .
#
# CHKSUM=`sha256sum $FILENAME | awk '{ print $1 }'`
# SIZE=`wc -c $FILENAME | awk '{ print $1 }'`
#
# cat package_renesas_${VERSION}_index.json.tmp |
# # sed "s/%%BUILD_NUMBER%%/${BUILD_NUMBER}/" |
# # sed "s/%%CURR_TIME%%/${CURR_TIME_SED}/" |
# sed "s/%%VERSION%%/${VERSION}/" |
# sed "s/%%FILENAME_UNO%%/${FILENAME}/" |
# sed "s/%%CHECKSUM_UNO%%/${CHKSUM}/" |
# sed "s/%%SIZE_UNO%%/${SIZE}/" > package_renesas_${VERSION}_index.json
#
# cat package_renesas_${VERSION}_index.json

# git checkout boards.txt
# git checkout platform.txt
