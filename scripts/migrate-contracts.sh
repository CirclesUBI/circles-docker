#!/bin/bash

source "scripts/common.sh"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

REPOSITORY=https://github.com/CirclesUBI/circles-contracts.git
FOLDER_NAME=contracts

check_tmp_folder $REPOSITORY $FOLDER_NAME

# Clean up
rm -rf build

git fetch --all
git reset --hard origin/save-contract-addresses

# Install dependencies
echo "Installing npm dependencies .."
npm install &> /dev/null

# Compile contracts
./node_modules/.bin/truffle compile

# Migrate contracts
./node_modules/.bin/truffle migrate

# Populate contract addresses to .env file only for local development
$SCRIPT_DIR/./update_contract_addresses.sh
