#!/bin/bash
set -e

write_config () {
    # update the config dynamic urls
    # echo "Configuring dynamic URLs"
    # paster --plugin=ckan config-tool "$CONFIG" -e \
    #     "ckan.site_url            = http://$(hostname -f)" \
    #     "sqlalchemy.url           = ${DATABASE_URL}" \
    #     "solr_url                 = ${SOLR_URL}" \
    #     "ckan.datastore.write_url = ${DATASTORE_WRITE_URL}" \
    #     "ckan.datastore.read_url  = ${DATASTORE_READ_URL}" \
    #     "ckan.datapusher.url      = ${DATAPUSHER_URL}"

    # apply any custom options
    if [ -e "$CKAN_CONFIG/$CONFIG_OPTIONS" ]; then
        echo "Configuring custom options from $CONFIG_OPTIONS"
        paster --plugin=ckan config-tool "$CONFIG" -f "$CKAN_CONFIG/$CONFIG_OPTIONS"
    fi
}

if [ "$1" = 'ckan' ]; then
    # Wait for solr to finish initiating
    if ! wait-for-solr.sh; then
        echo "Could not start Ckan. Solr not reacheable."
        exit 1
    fi

    . $CKAN_HOME/bin/activate
    
    if [ ! -e "$CONFIG" ]; then
        paster make-config ckan "$CONFIG"
    fi
    
    write_config
    
    cd $CKAN_HOME/src/ckan
    paster db init -c "$CONFIG"
    paster serve "$CONFIG"
fi

exec "$@"
