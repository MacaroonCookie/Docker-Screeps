FROM node:7.4.0
MAINTAINER Seth Cook <cooker52@gmail.com>


RUN "/bin/mkdir" \
    "-p" \
    "/screeps/scripts" \
    "/screeps/lib" \
    "/screeps/logs"

ADD launch-screeps.sh /screeps/scripts/launch-screeps.sh
ADD screepsrc.tmpl /screeps/scripts/screepsrc.tmpl

RUN npm -g install screeps

VOLUME "/screeps/lib"
VOLUME "/screeps/logs"

ENV OVERRIDESRC=0
ENV STEAM_KEY="UNDEFINED"
ENV SCREEPS_DB="UNDEFINED"
ENV SCREEPS_ASSETS="UNDEFINED"
ENV SCREEPS_MODS="UNDEFINED"
ENV SCREEPS_PROCESSORS="UNDEFINED"
ENV SCREEPS_RUNNERS="UNDEFINED"
ENV SCREEPS_PASSWORD="UNDEFINED"

EXPOSE "21025"
EXPOSE "21026"

WORKDIR /screeps/lib
CMD "/screeps/scripts/launch-screeps.sh"