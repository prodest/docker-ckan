#!/bin/bash
set -e

if [ "$1" = 'ckan' ]; then
    # Wait for solr to finish initiating
    if ! wait-for-solr.sh; then
        echo "Could not start Ckan. Solr not reacheable."
        exit 1
    fi

    . $CKAN_HOME/bin/activate
    #paster make-config ckan /etc/ckan/default/production.ini
    
    cd $CKAN_HOME/src/ckan
    paster db init -c /etc/ckan/default/production.ini
    paster serve /etc/ckan/default/production.ini
fi

exec "$@"

# . /usr/lib/ckan/default/bin/activate
# cd /usr/lib/ckan/default/src/ckan
# paster sysadmin add seanh -c /etc/ckan/default/production.ini
