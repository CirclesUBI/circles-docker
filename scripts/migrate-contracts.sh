#!/bin/bash

source "scripts/common.sh"

REPOSITORY=https://github.com/CirclesUBI/circles-contracts.git
FOLDER_NAME=contracts

check_tmp_folder $REPOSITORY $FOLDER_NAME

# Clean up
rm -rf build

git fetch --all
git reset --hard origin/master

# Install dependencies
echo "Installing npm dependencies .."
npm install 

# Compile contracts
./node_modules/.bin/truffle compile

# Migrate contracts
./node_modules/.bin/truffle migrate
