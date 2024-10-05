FROM php:8.2.16-fpm-alpine3.18

RUN apk update && apk add autoconf g++ make git zip postgresql-dev php82-pdo_pgsql && \
 docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    docker-php-ext-install pdo_pgsql opcache bcmath

COPY .docker/php/php.ini  /usr/local/etc/php

RUN curl -s https://getcomposer.org/installer |php
RUN alias composer='php composer.phar'

WORKDIR /app
COPY  ./ .
CMD ["php-fpm"]

