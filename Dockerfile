FROM robbertkl/base
MAINTAINER Robbert Klarenbeek <robbertkl@renbeek.nl>

RUN VERSION=`latestversion nodejs/node` \
    && curl -sSL "https://nodejs.org/dist/v${VERSION}/node-v${VERSION}-linux-x64.tar.gz" \
    | tar -xzC /usr/local --strip-components=1

ENV NPM_CONFIG_LOGLEVEL=info \
    NODE_ENV=production

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

CMD [ "npm", "start" ]
