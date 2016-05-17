FROM alpine:latest
MAINTAINER Robbert Klarenbeek <robbertkl@renbeek.nl>

RUN apk add --no-cache --virtual .docker-node \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    nodejs

ENV NPM_CONFIG_LOGLEVEL=silent \
    NODE_ENV=production

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

CMD [ "npm", "start" ]
