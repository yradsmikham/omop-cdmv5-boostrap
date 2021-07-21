#!/bin/bash

# update the Penelope configuration URL of the WebAPI
perl -i -pe "BEGIN{undef $/;} s|https://yvonne-omop-appservice.azurewebsites.net:8080|"$WEBAPI_URL"|g" /usr/local/tomcat/webapps/penelope/web/js/app.js

# load any jdbc drivers in the docker host volume mapped directory into the tomcat library
cp /tmp/drivers/*.jar /usr/local/tomcat/lib

# start tomcat
/usr/local/tomcat/bin/catalina.sh run

# start SSH service
service ssh start
