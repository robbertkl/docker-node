FROM alpine:latest
MAINTAINER Robbert Klarenbeek <robbertkl@renbeek.nl>

RUN apk add --no-cache \
        ca-certificates \
        libgcc \
        libstdc++

RUN VERSION=`wget -qO - https://api.github.com/repos/Yelp/dumb-init/tags | grep \"name\": | cut -d\" -f4 | grep -v [-^] | head -n 1 | sed -E s/^v//` && \
    wget -qO /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${VERSION}/dumb-init_${VERSION}_amd64 && \
    chmod +x /usr/local/bin/dumb-init

RUN apk add --no-cache --virtual .build-deps \
        make \
        gcc \
        g++ \
        openssl-dev \
        linux-headers \
        paxctl \
        python \
        zlib-dev \
    && \
    VERSION=`wget -qO - https://api.github.com/repos/nodejs/node/tags | grep \"name\": | cut -d\" -f4 | grep -v [-^] | head -n 1 | sed -E s/^v//` && \
    wget -O - https://nodejs.org/dist/v${VERSION}/node-v${VERSION}.tar.gz | tar xzf - && \
    cd node-v${VERSION} && \
    export GYP_DEFINES="linux_use_gold_flags=0" && \
    ./configure --prefix=/usr --shared-openssl --shared-zlib && \
    make -C out mksnapshot BUILDTYPE=Release && \
    paxctl -cm out/Release/mksnapshot && \
    make && \
    make install && \
    paxctl -cm /usr/bin/node && \
    cd .. && \
    rm -rf node-v${VERSION} && \
    apk del .build-deps

ENV NPM_CONFIG_LOGLEVEL=silent \
    NODE_ENV=production

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

CMD [ "dumb-init", "node", "." ]
