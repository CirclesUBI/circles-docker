#!/bin/bash

source "scripts/common.sh"

REPOSITORY=https://github.com/CirclesUBI/circles-subgraph.git
FOLDER_NAME=subgraph

check_tmp_folder $REPOSITORY $FOLDER_NAME

# Clean up
rm -rf build src/types
git fetch --all
git reset --hard e2dd1a0
# git reset --hard origin/master

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
npm run deploy
