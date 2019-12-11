#!/bin/bash

source "scripts/common.sh"

REPOSITORY=https://github.com/CirclesUBI/circles-contracts.git
FOLDER_NAME=contracts

check_tmp_folder $REPOSITORY $FOLDER_NAME

# Clean up
rm -rf build

# Use this for local testing:
# git checkout 89f316ab7bb7a6779b68709a1d7d7824397d2870

git fetch --all
git reset --hard origin/master

# Install dependencies
echo "Installing npm dependencies .."
npm install &> /dev/null

# Compile contracts
./node_modules/.bin/truffle compile

# Migrate contracts
./node_modules/.bin/truffle migrate
