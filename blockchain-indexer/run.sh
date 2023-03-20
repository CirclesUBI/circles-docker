#!/bin/sh
file_path='/app/status/addresses.json'

if [ -f "$file_path" ]; then
  echo "Using addresses from $file_path:"
  HUB_ADDRESS=$(jq -r '.hubContract' "$file_path")
  echo "HUB_ADDRESS: $HUB_ADDRESS"
else
  echo "Using addresses from environment variables:"
  echo "HUB_ADDRESS: $HUB_ADDRESS"
fi

./CirclesLand.BlockchainIndexer.Server
