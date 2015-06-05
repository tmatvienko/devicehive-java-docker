#!/bin/bash

# Use variables from env if available. Else use defaults
if [[ "$PG_USER" == "" ]]; then
    PG_USER="dh_user"
fi
if [[ "$PG_PASSWORD" == "" ]]; then
    PG_PASSWORD="dh_StrOngPasSWorD"
fi
if [[ "$PG_DATABASE" == "" ]]; then
    PG_DATABASE="dh"
fi

if [[ "$POSTGRES_PORT_5432_TCP_ADDR" == "" ]]; then
    echo "You MUST link this container with postgres database"
    echo "Example: docker run --link your-postgresql-container:postgres ...."
    exit 1
fi

echo "Alter config template with database location/credentials"

sed -e "s/{PG_USER}/${PG_USER}/g" \
-e "s/{PG_DATABASE}/${PG_DATABASE}/g" \
-e "s/{PG_PASSWORD}/${PG_PASSWORD}/g" \
-e "s/{PG_HOST}/${POSTGRES_PORT_5432_TCP_ADDR}/g" \
-e "s/{PG_PORT}/${POSTGRES_PORT_5432_TCP_PORT}/g" \
/opt/glassfish4/glassfish/domains/domain1/config/domain.tpl > \
/opt/glassfish4/glassfish/domains/domain1/config/domain.xml

echo "Alter admin-console config"
echo "app.config = {restEndpoint: '/DeviceHive/rest', rootUrl: '/admin', pushState: false }" > \
/opt/glassfish4/glassfish/domains/domain1/docroot/admin/scripts/config.js

echo "Starting glassfish server"
/opt/glassfish4/glassfish/bin/startserv
