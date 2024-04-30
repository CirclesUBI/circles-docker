#!/bin/bash

# if .env not exists, copy .env.example to .env
if [ ! -f .env ]; then
    cp .env.example .env
fi

# 1. Get and build the contracts
make down
make clean

make up EXPOSE_PORTS=1
make contracts
make up EXPOSE_PORTS=1
