#!/bin/bash

# create symlink for sqlcmd
ln -sfn /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd

echo "APP SERVICE HOST: $WEBAPI_SOURCES/sources"
response=$(curl "$WEBAPI_SOURCES/sources")
echo "Echoing curl response ..."
echo $response

echo "Entering first while loop now..."
while [ "$response" != '[]' ]; do
  echo "Container has not started yet..."
  response=$(curl "$WEBAPI_SOURCES/sources")
  echo "$response"

  # wait 30 seconds
  sleep 30
done

echo "Entering second while loop now..."
while [ "${response:-[]}" == '[]' ]; do
  echo "Need to configure sources..."
  sqlcmd -U omop_admin -P $OMOP_PASSWORD -S $SQL_SERVER_NAME -d $SQL_DB_NAME -i /usr/local/tomcat/webapps/atlas/js/tf_config/source_source_daimon.sql -o output.log

  # wait 60 seconds for it to try again
  sleep 60

  # refresh sources endpoint
  curl "$WEBAPI_SOURCES/refresh"

  # curl response again
  response=$(curl "$WEBAPI_SOURCES/sources")
  echo "$response"
done

echo "Curl Response: $response"
# refresh sources endpoint once more
curl "$WEBAPI_SOURCES/refresh"

echo "fin"
