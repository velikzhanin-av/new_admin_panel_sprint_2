#!/usr/bin/env bash

#set -e
cd /opt/app
python manage.py createsuperuser --noinput --username $DJANGO_SUPERUSER_USERNAME --email $DJANGO_SUPERUSER_EMAIL
#
#chown www-data:www-data /var/log

uwsgi --strict --ini uwsgi.ini
