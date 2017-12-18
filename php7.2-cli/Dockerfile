FROM php:7.2-cli

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ENV DEBIAN_FRONTEND noninteractive
RUN TERM=xterm
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

RUN apt-get update -y --fix-missing && apt-get install -y \
    cron \
    rsyslog \
    vim \
    wget \
    git \
    python \
    libpq-dev \
    libzip-dev \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
    supervisor \
    libxml2-dev \
    sqlite3 \
    libsqlite3-dev \
    libsqlite3-0

RUN rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install \
	    bcmath \
	    ctype \
	    exif \
	    opcache \
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

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RUN php -r "readfile('https://getcomposer.org/installer');" | php && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer
RUN composer config -g github-oauth.github.com 544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061

RUN export PATH="~/.composer/vendor/bin/:$PATH"
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RUN git clone git://github.com/xdebug/xdebug.git /tmp/xdebug \
    && cd /tmp/xdebug \
    && pwd && ls -la && ./rebuild.sh \
    && /usr/local/bin/phpize \
    && ./configure --enable-xdebug \
    && make \
    && make install

RUN docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "debug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

RUN mkdir -p /etc/cron.d/
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www

