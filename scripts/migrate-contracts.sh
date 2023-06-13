#!/bin/bash

source "scripts/common.sh"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

REPOSITORY=https://github.com/CirclesUBI/circles-contracts.git
FOLDER_NAME=contracts

check_tmp_folder $REPOSITORY $FOLDER_NAME

# Clean up
rm -rf build

git fetch --all
git reset --hard v3.3.2

# Install dependencies
echo "Installing npm dependencies .."
npm ci &> /dev/null

# Compile contracts
./node_modules/.bin/truffle compile

# Migrate contracts
./node_modules/.bin/truffle migrate
