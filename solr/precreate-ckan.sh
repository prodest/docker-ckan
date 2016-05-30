#!/bin/bash
#
# A script that creates a core by copying config before starting solr.
#
# To use this, map this file into your container's docker-entrypoint-initdb.d directory:
#
#     docker run -d -P -v $PWD/precreate-collection.sh:/docker-entrypoint-initdb.d/precreate-collection.sh solr

echo "Creating config files"
CONFIG_SOURCE="/opt/solr/server/solr/configsets/basic_configs"
schema_url="https://raw.githubusercontent.com/ckan/ckan/ckan-2.5.2/ckan/config/solr/schema.xml"
#coresdir="/opt/solr/server/solr/mycores"
#mkdir -p $coresdir
#coredir="$coresdir/$SOLR_CKAN_CORE"
coredir="/opt/solr/server/solr/$SOLR_CKAN_CORE"

if [[ ! -d $coredir ]]; then
    cp -r $CONFIG_SOURCE/ $coredir
    touch "$coredir/core.properties"
    wget -nv $schema_url -O $coredir/conf/managed-schema
    echo "Created $SOLR_CKAN_CORE"
else
    echo "Core $SOLR_CKAN_CORE already exists"
    echo "Skipping creating $SOLR_CKAN_CORE"
fi

su - $SOLR_USER
