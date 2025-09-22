FROM ghcr.io/roadrunner-server/roadrunner:2025.1 AS roadrunner

FROM composer:2.8 AS composer

FROM php:8.4-cli AS runtime

ENV DEBIAN_FRONTEND=noninteractive
RUN TERM=xterm

RUN apt-get update \
    && apt-get install -y --no-install-recommends locales tzdata \
    && locale-gen en_US.UTF-8
RUN rm -rf /var/lib/apt/lists/*


RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gettext \
        libgmp-dev \
        libonig-dev \
        libfreetype6-dev \
        libmcrypt-dev \
        libpng-dev \
        libjpeg-dev \
        libicu-dev \
        libpq-dev \
        libzip-dev \
        libxml2-dev \
        libsqlite3-dev \
        libxslt-dev \
        libssh2-1-dev \
        libssh2-1 \
        wget \
        curl \
        git \
        vim \
        zip \
        unzip \
        supervisor

RUN ln -sf /dev/stderr /var/log/php-fpm.log \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install \
        bcmath \
        ctype \
        dom \
        exif \
        gd \
        gmp \
        gettext \
        intl \
        mbstring \
        opcache \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        pdo_sqlite \
        sockets \
        simplexml \
        xml \
        xsl \
        zip

RUN pecl install redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

COPY --from=composer /usr/bin/composer /usr/bin/composer
# install roadrunner
COPY --from=roadrunner /usr/bin/rr /usr/bin/rr

RUN TERM=xterm
RUN git config --global --add safe.directory '*'
