#!/bin/bash


source "scripts/common.sh"

REPOSITORY=https://github.com/CirclesUBI/circles-subgraph.git
FOLDER_NAME=subgraph

check_tmp_folder $REPOSITORY $FOLDER_NAME

# Clean up
rm -rf build src/types
git fetch --all
git reset --hard v1.2.1


# Install dependencies
echo "Installing npm dependencies .."
npm install &> /dev/null

# Link to .env file
ln -s ../../.env .env

# Set env vars
export IPFS_NODE_ENDPOINT=http://localhost:5001
export GRAPH_ADMIN_NODE_ENDPOINT=http://localhost:8020

# Prepare subgraph
npm run codegen --loglevel verbose
npm run build --loglevel verbose

# Create and deploy subgraph to node
npm run create --loglevel verbose
npm run deploy --loglevel verbose
