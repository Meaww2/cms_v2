#!/bin/bash
# @Author: kitt k
# @Date:   2024-05-08 00:23:58
# @Last Modified by:   kk
# @Last Modified time: 2024-05-08 13:59:42
POSTGRESQL_PASSWD="cms1234cmu"
ADMIN="cmuadmin"
ADMIN_PASS="cmu1234cms"

cd $HOME/cms


cp ./config/cms.conf.sample ./config/cms.conf

# Read the JSON file
json=$(cat config/cms.conf)

# Extract password from "database" field
password=$(echo "$json" | grep -oP '"database": "postgresql\+psycopg2://cmsuser:\K[^@]*')

# Replace the placeholder with the actual password
updated_json=$(echo "$json" | sed -E "s|\"database\": \"postgresql\+psycopg2://cmsuser:$password@localhost:5432/cmsdb\"|\"database\": \"postgresql+psycopg2://cmsuser:$POSTGRESQL_PASSWD@localhost:5432/cmsdb\"|")

# Write the updated JSON back to the file
echo "$updated_json" > ./config/cms.conf
sudo cp ./config/cms.conf /usr/local/etc/cms.conf

sudo service postgresql start


# # Read the JSON file
# json=$(cat ./config/cms.conf)

# # Extract password from "database" field
# password=$(echo "$json" | grep -oP '"database": "postgresql\+psycopg2://cmsuser:\K[^@]*')

# # Store the password in the environment variable
# export POSTGRESQL_PASSWD="$password"

# echo "Password extracted and stored in POSTGRESQL_PASSWD: $POSTGRESQL_PASSWD"

# Switch to postgres user and create cmsuser without password
sudo -u postgres createuser --username=postgres --no-password cmsuser

# Alter the user's password
sudo -u postgres psql -c "ALTER USER cmsuser WITH PASSWORD '$POSTGRESQL_PASSWD';"

# Create a new database named 'cmsdb' with 'cmsuser' as the owner
sudo -u postgres createdb --username=postgres --owner=cmsuser cmsdb

# Connect to the 'cmsdb' database and change the ownership of the 'public' schema to 'cmsuser'
sudo -u postgres psql -c "ALTER SCHEMA public OWNER TO cmsuser" --dbname=cmsdb

# Connect to the 'cmsdb' database and grant 'cmsuser' the 'SELECT' permission on the 'pg_largeobject' system table
sudo -u postgres psql -c "GRANT SELECT ON pg_largeobject TO cmsuser" --dbname=cmsdb

cmsInitDB
cmsAddAdmin $ADMIN -p $ADMIN_PASS
cmsDumpImporter ./dump/dump_2024-05-08.tar.gz
