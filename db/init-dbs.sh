#!/bin/bash

set -e

DATABASES=(
  $POSTGRES_DATABASE_API
  $POSTGRES_DATABASE_GRAPH_NODE
  $POSTGRES_DATABASE_RELAYER
)

create_database () {
  DB_NAME=$1

  echo "Create postgres database '$DB_NAME'"

  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE $DB_NAME;
    GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $POSTGRES_USER;
EOSQL
}

# Create all necessary databases for Circles
for db in "${DATABASES[@]}"
do
  create_database $db
done

# give permissions to shared volume 
chmod +x /usr/src/app/edges-data