#!/bin/bash

REPOSITORY=https://github.com/CirclesUBI/circles-contracts.git
TMP_FOLDER=.tmp

# Download contracts
git clone $REPOSITORY $TMP_FOLDER
cd $TMP_FOLDER

# Install dependencies
npm install

# Migrate contracts
./node_modules/.bin/truffle migrate

# Cleanup
cd ..
rm -rf $TMP_FOLDER
