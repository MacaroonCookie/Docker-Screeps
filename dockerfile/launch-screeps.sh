#!/bin/bash

SCREEPS_DIR=/screeps
SCREEPS_DATA=${SCREEPS_DIR}/data
SCREEPS_LOGS=${SCREEPS_DIR}/logs
SCREEPS_SCRIPTS=${SCREEPS_DIR}/scripts

if [ $STEAM_KEY == "UNDEFINED" ] ; then
  echo "The Steam Key is not set. Cannot start the Screeps server."
  exit 1
fi

# Check if the Screeps server needs initialization
NEEDSINIT=1
if [ ! "$(ls -A $SCREEPS_DATA)" ] ; then
  echo ${STEAM_KEY} | /usr/local/bin/screeps init ${SCREEPS_DATA}
  if [ $? -ne 0 ] ; then
    echo "Failed to initialize the Screeps directory."
    exit 1
  fi
fi

# Overwrite the ScreepSrc file if necessary
screeps_opts="--cli_host 0.0.0.0 --cli_port 21026 --port 21025 --host 0.0.0.0 --logdir ${SCREEPS_LOGS}"
[ $SCREEPS_DB != "UNDEFINED" ] && screeps_opts="${screeps_opts} --db ${SCREEPS_DB}"
[ $SCREEPS_ASSETS != "UNDEFINED" ] && screeps_opts="${screeps_opts} --assetdir ${SCREEPS_ASSETS}"
[ $SCREEPS_MODS != "UNDEFINED" ] && screeps_opts="${screeps_opts} --modfile ${SCREEPS_MODS}"
[ $SCREEPS_PROCESSORS != "UNDEFINED" ] && screeps_opts="${screeps_opts} --processors_cnt ${SCREEPS_PROCESSORS}"
[ $SCREEPS_RUNNERS != "UNDEFINED" ] && screeps_opts="${screeps_opts} --runners_cnt ${SCREEPS_RUNNERS}"
[ $SCREEPS_PASSWORD != "UNDEFINED" ] && screeps_opts="${screeps_opts} --password '${SCREEPS_PASSWORD}'"
[ $STEAM_KEY != "UNDEFINED" ] && screeps_opts="${screeps_opts} --steam_api_key ${STEAM_KEY}"

/usr/local/bin/screeps start ${screeps_opts}
