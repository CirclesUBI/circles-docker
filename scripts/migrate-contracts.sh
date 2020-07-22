#!/bin/bash

source "scripts/common.sh"

REPOSITORY=https://github.com/CirclesUBI/circles-contracts.git
FOLDER_NAME=contracts

check_tmp_folder $REPOSITORY $FOLDER_NAME

# Clean up
rm -rf build

git checkout 21296095382a856a32484aaf48812b78f3aeda6d
# git fetch --all
# git reset --hard origin/master

# Install dependencies
echo "Installing npm dependencies .."
npm install &> /dev/null

# Compile contracts
./node_modules/.bin/truffle compile

# Migrate contracts
./node_modules/.bin/truffle migrate
