!/bin/bash

source "scripts/common.sh"

REPOSITORY=https://github.com/CirclesUBI/circles-contracts.git
FOLDER_NAME=contracts

check_tmp_folder $REPOSITORY $FOLDER_NAME

# Clean up
rm -rf build
git fetch --all

# @TODO: Use master as soon as its merged again
git checkout ec8c34e415f6403c5adb4a1668a11ea88afd2375
# git reset --hard origin/master

# Install dependencies
echo "Installing npm dependencies .."
npm install &> /dev/null

# Compile contracts
./node_modules/.bin/truffle compile

# Migrate contracts
./node_modules/.bin/truffle migrate
