#!/bin/bash
set -eu

if [ ! -d /app/vendor ]; then
  composer install  --no-scripts --no-interaction
fi

chown "$UID_VAR":"$GID_VAR" -R /app
chmod -R 0777 /app

rr serve --debug -c /app/docker/dev/.rr.http.yaml

