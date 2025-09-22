FROM php:7.3-fpm

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ENV DEBIAN_FRONTEND noninteractive
RUN TERM=xterm
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

RUN apt-get update \
    && apt-get install -y --no-install-recommends locales tzdata \
    && locale-gen en_US.UTF-8

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    software-properties-common \
    cron \
    rsyslog \
    wget \
    git \
    curl \
    python \
    gettext \
    libfreetype6-dev \
    libpq-dev \
    libzip-dev \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
    libmcrypt-dev \
    supervisor \
    libxml2-dev \
    sqlite3 \
    libsqlite3-dev \
    libsqlite3-0 \
    zip \
    unzip \
    vim

RUN ln -sf /dev/stderr /var/log/php-fpm.log \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install \
        bcmath \
        ctype \
        opcache \
        exif \
        dom \
        gettext \
        json \
        gd \
        mbstring \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        pgsql \
        pdo_sqlite \
        sockets \
        intl \
        simplexml \
        xml \
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

RUN mkdir -p /var/run/php
RUN mkdir -p /etc/cron.d/

COPY supervisord.conf /etc/supervisord.conf
ADD entrypoint.sh /usr/local/bin/

WORKDIR /var/www

CMD ["entrypoint.sh"]
