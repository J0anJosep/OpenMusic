#!/usr/bin/env bash

source musictools/config.sh

userinput=""

if [ "$1" == "--agree" ]
then
  userinput="I agree"
else
  cat << _EOF_

This script will download the SoundFonts required to build OpenRCT2-OpenMusic.

Please note that these SoundFonts do not fall under the license found in the
COPYING file in the root directory of this repository.

The license agreements for the SoundFonts that are about to be downloaded can
be found in the $SOUNDFONTSDIR/licenses directory. Please read them carefully.
If you agree to them, enter "I agree" and press return, otherwise type
something else and the script will exit.

_EOF_
  read userinput
fi

if [ "$userinput" == "I agree" ]
then
  curl -C - -L "https://dl.bintray.com/ccoors/OpenRCT2-OpenMusic-SoundFonts/FluidR3_GM.sf2" -o $SOUNDFONTSDIR/FluidR3_GM.sf2
  curl -C - -L "https://dl.bintray.com/ccoors/OpenRCT2-OpenMusic-SoundFonts/GeneralUser GS v1.471.sf2" -o "$SOUNDFONTSDIR/GeneralUser GS v1.471.sf2"

  MERGE=""
  for suffix in aa ab ac; do
    OUTPUT="$SOUNDFONTSDIR/Organ.sf2.${suffix}"
    curl -C - -L "https://dl.bintray.com/ccoors/OpenRCT2-OpenMusic-SoundFonts/Organ.sf2.${suffix}" -o $OUTPUT
    MERGE="${MERGE} $OUTPUT"
  done
  cat $MERGE > $SOUNDFONTSDIR/Organ.sf2
else
  echo "You did not agree to the license agreement."
  exit 1
fi