FROM alpine:3.3

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES="1"

WORKDIR /portus

EXPOSE 3000

COPY /Portus/Gemfile* ./

RUN set -ex \
    && apk add --update -t deps \
           gcc \
           libxslt-dev \
           libxml2-dev \
           libffi-dev \
           make \
           mariadb-dev \
           musl-dev \
           openssl-dev \
           ruby-dev \
           ruby-mini_portile \
    && apk add \
           bash \
           ca-certificates \
           libffi \
           libxslt \
           mariadb-client \
           mariadb-libs \
           nodejs \
           openssl \
           ruby-bigdecimal \
           ruby-io-console \
           ruby-irb \
           ruby-json \
           tzdata \
    && echo 'gem: --verbose --no-document' > /etc/gemrc \
    && gem install bundler \
    && bundle install --retry=3 \
    && apk del --purge deps \
    && rm -rf /tmp/* /var/cache/apk/*

COPY ./Portus .
