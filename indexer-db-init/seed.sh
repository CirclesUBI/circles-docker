#!/bin/bash
git clone https://github.com/CirclesUBI/blockchain-indexer.git
cd blockchain-indexer
git checkout dev

export CONNECTION_STRING_ROOT="postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}"

ls CirclesLand.BlockchainIndexer/DbMigrations/*.sql | xargs -I% sh -c 'psql ${CONNECTION_STRING_ROOT} << envsubst < %'

cd ..
rm -r -f blockchain-indexer
