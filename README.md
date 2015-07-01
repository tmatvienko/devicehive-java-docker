**DeviceHive Dockerized user guide**
================================

Image overview
-----------

With the exception of devicehive app there are several auxiliary services inside docker image - zookeeper, kafka, redis, postgresql. All of them work under the control of supervisord. Here is a summary table of internal services and network ports they use:

    22 - sshd
    2181 - zookeeper
    5432 - postgresql
    80 - nginx: devicehive & admin console
    9001 - supervisord web panel
    9092 - kafka broker

Default credentials
-------------------------

SSH, PostgreSQL, DeviceHive Admin, Supervisord Web Panel:
     login=dhadmin
     password=dhadmin_#911

Usage
-----------

     docker build -t devicehive
     docker run -d --name=devicehive -p 80:80  -p 9001:9001 devicehive

In about 1 minute 
* DeviceHive admin console will be available at [http://localhost/admin/](http://localhost/admin/)
* DeviceHive api will be available at [http://localhost/api/](http://localhost/api/)
* Supervisor web console  will be available at [http://localhost:9001/](http://localhost:9001/)
