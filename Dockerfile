ARG PHP_VERSION=8.4
ARG COMPOSER_VERSION=latest
ARG RR_VERSION=2024.3.4
ARG GRPC_VERSION=1.70.0
ARG PROTOBUF_VERSION=4.29.3
ARG KAFKA_VERSION=6.0.3
ARG WWWGROUP=1337

FROM composer:$COMPOSER_VERSION AS composer
FROM ghcr.io/roadrunner-server/roadrunner:$RR_VERSION AS roadrunner

FROM php:${PHP_VERSION}-cli-alpine

COPY --from=roadrunner /usr/bin/rr /usr/local/bin/
COPY --from=composer /usr/bin/composer /usr/local/bin/

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

ARG GRPC_VERSION
ARG PROTOBUF_VERSION
ARG KAFKA_VERSION

RUN apk add --no-cache bash less \
&& install-php-extensions \
    pdo_mysql pdo_pgsql redis pcntl sockets gd zip \
    grpc-$GRPC_VERSION \
    protobuf-$PROTOBUF_VERSION \
    rdkafka-$KAFKA_VERSION

ARG WWWGROUP

RUN addgroup -g $WWWGROUP sail
RUN adduser -u $WWWGROUP -G sail -s /bin/sh -D sail

WORKDIR /var/www/app
VOLUME /var/www/app
