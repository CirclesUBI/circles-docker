#!/bin/bash

source "scripts/common.sh"

REPOSITORY=https://github.com/CirclesUBI/circles-subgraph.git
FOLDER_NAME=subgraph

check_tmp_folder $REPOSITORY $FOLDER_NAME

# @TODO: Remove this when merged to master
git checkout deployable-subgraph

# Clean up
rm -rf build src/types
git fetch --all

# @TODO: Change this when merged to master
git reset --hard origin/deployable-subgraph

# Install dependencies
npm install

# Link to .env file
ln -s ../../.env .env

# Prepare subgraph
npm run codegen
npm run build

# Create and deploy subgraph to node
npm run create
npm run deploy
