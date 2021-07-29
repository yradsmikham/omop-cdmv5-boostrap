#!/bin/bash

# overwrite Atlas configurations with mounted volume
cp /usr/local/tomcat/webapps/atlas/js/tf_config/config-gis.js /usr/local/tomcat/webapps/atlas/js/
cp /usr/local/tomcat/webapps/atlas/js/tf_config/config-local.js /usr/local/tomcat/webapps/atlas/js/
