#!/bin/bash
set -e

if [ "$1" = 'ckan' ]; then
    . $CKAN_HOME/bin/activate
    paster make-config ckan /etc/ckan/default/production.ini
    
    cd $CKAN_HOME/src/ckan
    paster db init -c /etc/ckan/default/production.ini
    paster serve /etc/ckan/default/production.ini
fi

exec "$@"
