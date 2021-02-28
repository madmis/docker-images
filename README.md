## Build image
```bash
    $ docker build -t php7.3:latest .
    $ docker tag php7.3:latest madmis/php7.3:latest
```

## Push to hub
```bash
    $ docker push madmis/php7.3:latest
```


### Extend Dockerfile for DEV environment

```docker
FROM madmis/php7.2:latest

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RUN echo 'PS1="\[\033[36m\]\u\[\033[m\]@\[\033[95;1m\]card.php:\[\033[34m\]\w\[\033[m\]\$ "' >> ~/.bashrc
# home dir for www-data
RUN echo 'PS1="\[\033[36m\]\u\[\033[m\]@\[\033[95;1m\]card.php:\[\033[34m\]\w\[\033[m\]\$ "' >> /var/www/.bashrc
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

RUN sed -i "s/opcache.validate_timestamps=0 ; (comment this in dev env)/;opcache.validate_timestamps=0 ; (comment this in dev env)/g" /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini


## For php < 8.0
RUN pecl install xdebug-2.9.7 \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

## For php 8+
RUN pecl install xdebug-3.0.2 \
    && docker-php-ext-enable xdebug  \
    && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.max_nesting_level=-1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini


CMD ["entrypoint.sh"]

 ```
