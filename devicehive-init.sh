#!/bin/bash

echo "Starting DeviceHive Components"
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf

trap "{ 
	supervisorctl stop nginx; \
	supervisorctl stop devicehive; \
	supervisorctl stop kafka; \
	supervisorctl stop postgresql; \
	supervisorctl stop zookeeper;
	supervisorctl stop sshd; \
	killall supervisord; \
	exit 0; }" SIGINT SIGTERM SIGKILL
while :
do
        sleep 1
done
