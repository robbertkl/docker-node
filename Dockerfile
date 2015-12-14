FROM robbertkl/base
MAINTAINER Robbert Klarenbeek <robbertkl@renbeek.nl>

ENV NODE_VERSION=5.2.0
RUN curl -sSL "https://nodejs.org/dist/v${NODE_VERSION}/node-v{$NODE_VERSION}-linux-x64.tar.gz" \
    | tar -xzC /usr/local --strip-components=1

ENV NPM_CONFIG_LOGLEVEL=info \
    NODE_ENV=production

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

CMD [ "npm", "start" ]
