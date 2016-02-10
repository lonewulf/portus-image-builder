FROM alpine:3.3

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES="1"

WORKDIR /portus

COPY /Portus/Gemfile* ./

RUN set -ex \
    && apk add --update -t deps \
           gcc \
           libxslt-dev \
           libxml2-dev \
           make \
           mariadb-dev \
           musl-dev \
           openssl-dev \
           ruby-dev \
           ruby-mini_portile \
    && apk add \
           bash \
           ca-certificates \
           git \
           libxslt \
           mariadb-client \
           mariadb-libs \
           nodejs \
           openssl \
           ruby-bigdecimal \
           ruby-bundler \
           ruby-io-console \
           ruby-irb \
           ruby-json \
           tzdata \
    && echo 'gem: --verbose --no-document' > /etc/gemrc \
    && bundle install --retry=3 \
    && apk del --purge deps \
    && rm -rf /tmp/* /var/cache/apk/*

EXPOSE 3000

COPY ./Portus .
