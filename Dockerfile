FROM alpine:3.6

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES="1"

WORKDIR /portus

EXPOSE 3000

COPY /Portus/Gemfile* ./

RUN set -ex \
    && apk upgrade --no-cache \
    && apk add --no-cache -t deps \
           gcc \
           libxslt-dev \
           libxml2-dev \
           libffi-dev \
           make \
           mariadb-dev \
           musl-dev \
           libressl-dev \
           ruby-dev \
    && apk add --no-cache \
           bash \
           ca-certificates \
           libcurl \
           libffi \
           libxslt \
           mariadb-client \
           mariadb-client-libs \
           mariadb-libs \
           nodejs \
           libressl \
           ruby-bigdecimal \
           ruby-io-console \
           ruby-irb \
           ruby-json \
           tzdata \
    && echo 'gem: --verbose --no-document' > /etc/gemrc \
    && gem update --system \
    && gem install bundler \
    && bundle update webmock \
    && bundle install --retry=3 \
    && apk del --purge deps \
    && rm -rf /tmp/* \
    && rm -rf /usr/include/*

COPY ./Portus .
