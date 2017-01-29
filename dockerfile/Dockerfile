FROM node:7.4.0
MAINTAINER Seth Cook <cooker52@gmail.com>

ARG SCREEPSVERSION=latest

RUN "/bin/mkdir" \
    "-p" \
    "/screeps/scripts" \
    "/screeps/data" \
    "/screeps/logs"

ADD launch-screeps.sh /screeps/scripts/launch-screeps.sh
ADD screepsrc.tmpl /screeps/scripts/screepsrc.tmpl

RUN npm -g install screeps@${SCREEPSVERSION}

VOLUME "/screeps/data"
VOLUME "/screeps/logs"

ENV STEAM_KEY="UNDEFINED"
ENV SCREEPS_DB="UNDEFINED"
ENV SCREEPS_ASSETS="UNDEFINED"
ENV SCREEPS_MODS="UNDEFINED"
ENV SCREEPS_PROCESSORS="UNDEFINED"
ENV SCREEPS_RUNNERS="UNDEFINED"
ENV SCREEPS_PASSWORD="UNDEFINED"

EXPOSE "21025"
EXPOSE "21026"

WORKDIR /screeps/data
CMD "/screeps/scripts/launch-screeps.sh"
