#!/bin/bash
#
# A helper script to create a sysadmin user
#
# Usage: create-sysadmin.sh username

if [[ -z $1 ]]; then
  echo "Username is required."
fi

. /usr/lib/ckan/default/bin/activate
cd /usr/lib/ckan/default/src/ckan

paster sysadmin add $1 -c /etc/ckan/default/production.ini
