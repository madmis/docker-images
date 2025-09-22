#!/bin/bash
set -eu

ln -fs /usr/share/zoneinfo/UTC /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

usermod -u $UID_VAR www-data
groupmod -g 4444 dialout
groupmod -g 5555 staff
groupmod -g $GID_VAR www-data
chown -R www-data:www-data /var/www

exec /usr/bin/supervisord -c /etc/supervisord.conf
