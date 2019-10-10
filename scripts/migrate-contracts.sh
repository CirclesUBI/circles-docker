#!/bin/bash

REPOSITORY=https://github.com/CirclesUBI/circles-contracts.git
TMP_FOLDER=.tmp

# Download or update contracts
if [ -d "$TMP_FOLDER" ]; then
  cd $TMP_FOLDER
  rm -rf build
  git fetch --all
  git reset --hard origin/master
  ./node_modules/.bin/truffle compile
else
  git clone $REPOSITORY $TMP_FOLDER
  cd $TMP_FOLDER
fi

# Install dependencies
npm install

# Migrate contracts
./node_modules/.bin/truffle migrate
