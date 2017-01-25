#!/bin/bash

SCREEPS_DIR=/screeps
SCREEPS_LIB=${SCREEPS_DIR}/lib
SCREEPS_LOGS=${SCREEPS_DIR}/logs
SCREEPS_SCRIPTS=${SCREEPS_DIR}/scripts

if [ $STEAM_KEY == "UNDEFINED" ] ; then
  echo "The Steam Key is not set. Cannot start the Screeps server."
  exit 1
fi

# Check if the Screeps server needs initialization
NEEDSINIT=1
if [ ! "$(ls -A $SCREEPS_LIB)" ] ; then
  echo ${STEAM_KEY} | /usr/local/bin/screeps init ${SCREEPS_LIB}
  if [ $? -ne 0 ] ; then
    echo "Failed to initialize the Screeps directory."
    exit 1
  fi
fi

# Overwrite the ScreepSrc file if necessary
if [ $OVERRIDESRC -eq 0 ] ; then
  [ $SCREEPS_DB == "UNDEFINED" ] && SCREEPS_DB=db.json
  [ $SCREEPS_ASSETS == "UNDEFINED" ] && SCREEPS_ASSETS=assetS/
  [ $SCREEPS_MODS == "UNDEFINED" ] && SCREEPS_MODS=mods.json
  [ $SCREEPS_PROCESSORS == "UNDEFINED" ] && SCREEPS_PROCESSORS=2
  [ $SCREEPS_RUNNERS == "UNDEFINED" ] && SCREEPS_RUNNERS=2
  [ $SCREEPS_PASSWORD == "UNDEFINED" ] && SCREEPS_PASSWORD=

  if [ -f ${SCREEPS_LIB}/.screepsrc ] ; then
    mv ${SCREEPS_LIB}/.screepsrc ${SCREEPS_LIB}/.screepsrc.docker-bak.$(/bin/date -u +%Y%m%dT%H%M%S)
  fi

  cat ${SCREEPS_SCRIPTS}/screepsrc.tmpl | \
  sed -e "s|<STEAM_KEY>|${STEAM_KEY}|" \
      -e "s|<SCREEPS_PASSWORD>|${SCREEPS_PASSWORD}|" \
      -e "s|<RUNNERS>|${SCREEPS_RUNNERS}|" \
      -e "s|<PROCESSORS>|${SCREEPS_PROCESSORS}|" \
      -e "s|<DIR_LOGS>|${SCREEPS_LOGS}|" \
      -e "s|<DIR_ASSETS>|${SCREEPS_ASSETS}|" \
      -e "s|<FILE_MOD>|${SCREEPS_MODS}|" \
      -e "s|<FILE_DB>|${SCREEPS_DB}|" > \
  ${SCREEPS_LIB}/.screepsrc
fi

/usr/local/bin/screeps start
