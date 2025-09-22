FROM php:8.4-fpm

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

RUN rm /usr/local/etc/php-fpm.d/www.conf
COPY www.conf /usr/local/etc/php-fpm.d/

RUN echo "opcache.revalidate_freq=0" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo "opcache.validate_timestamps=0 ; (comment this in dev env)" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo "opcache.max_accelerated_files=50000"  >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo "opcache.memory_consumption=1512"  >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo "opcache.interned_strings_buffer=16"  >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo "opcache.fast_shutdown=1"  >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo "opcache.consistency_checks=1"  >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo "opcache.save_comments=1"  >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin
RUN export PATH="~/.composer/vendor/bin/:$PATH"

WORKDIR /app
