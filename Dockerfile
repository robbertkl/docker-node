FROM alpine:latest
MAINTAINER Robbert Klarenbeek <robbertkl@renbeek.nl>

RUN apk add --no-cache --virtual .docker-node \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
    openssl \
    nodejs

RUN VERSION=`wget -qO - https://api.github.com/repos/Yelp/dumb-init/tags | grep \"name\": | cut -d\" -f4 | grep -v [-^] | head -n 1 | sed -E s/^v//` && \
    wget -qO /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${VERSION}/dumb-init_${VERSION}_amd64 && \
    chmod +x /usr/local/bin/dumb-init

ENV NPM_CONFIG_LOGLEVEL=silent \
    NODE_ENV=production

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

CMD [ "dumb-init", "node", "." ]
