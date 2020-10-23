#!/bin/bash

source "scripts/common.sh"

REPOSITORY=https://github.com/CirclesUBI/circles-subgraph.git
FOLDER_NAME=subgraph

check_tmp_folder $REPOSITORY $FOLDER_NAME

# Clean up
rm -rf build src/types
git fetch --all
git reset --hard origin/main

# Install dependencies
echo "Installing npm dependencies .."
npm install &> /dev/null

# Link to .env file
ln -s ../../.env .env

# Prepare subgraph
npm run codegen
npm run build

# Create and deploy subgraph to node
npm run create
IPFS_NODE_ENDPOINT=http://localhost:5001 GRAPH_NODE_ENDPOINT=http://localhost:8020 npm run deploy
