FROM madmis/php-roadrunner:8.4-2025.1

COPY php.ini /usr/local/etc/php/conf.d/

RUN sed -i "s/opcache.validate_timestamps=0 ; (comment this in dev env)/;opcache.validate_timestamps=0 ; (comment this in dev env)/g" /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

RUN echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.max_nesting_level=-1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.log_level=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

ENV COMPOSER_ALLOW_SUPERUSER=1

WORKDIR /app

ADD entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT []
CMD ["entrypoint.sh"]
