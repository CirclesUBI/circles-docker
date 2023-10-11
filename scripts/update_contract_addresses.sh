#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

declare -a addresses=()

while read -r line; do  addresses+=("$line"); done < $SCRIPT_DIR/../.tmp/contracts/addresses

# Update addresses in .env file

ENV_FILE=$SCRIPT_DIR/../.env

# Substitute in .env in circles-docker  

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sed -i  's/HUB_ADDRESS=[^ ]*/HUB_ADDRESS='"${addresses[0]}"'/; s/PROXY_FACTORY_ADDRESS=[^ ]*/PROXY_FACTORY_ADDRESS='"${addresses[6]}"'/;s/SAFE_ADDRESS=[^ ]*/SAFE_ADDRESS='"${addresses[8]}"'/;s/MULTI_SEND_ADDRESS=[^ ]*/MULTI_SEND_ADDRESS='"${addresses[3]}"'/;s/MULTI_SEND_CALL_ONLY_ADDRESS=[^ ]*/MULTI_SEND_CALL_ONLY_ADDRESS='"${addresses[5]}"'/;s/SAFE_DEFAULT_CALLBACK_HANDLER=[^ ]*/SAFE_DEFAULT_CALLBACK_HANDLER='"${addresses[7]}"'/;s/PROXY_FACTORY_ADDRESS_CRC=[^ ]*/PROXY_FACTORY_ADDRESS_CRC='"${addresses[2]}"'/;s/SAFE_CONTRACT_ADDRESS_CRC=[^ ]*/SAFE_CONTRACT_ADDRESS_CRC='"${addresses[1]}"'/' $ENV_FILE
elif [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '.bak'  's/HUB_ADDRESS=[^ ]*/HUB_ADDRESS='"${addresses[0]}"'/; s/PROXY_FACTORY_ADDRESS=[^ ]*/PROXY_FACTORY_ADDRESS='"${addresses[6]}"'/;s/SAFE_ADDRESS=[^ ]*/SAFE_ADDRESS='"${addresses[8]}"'/;s/MULTI_SEND_ADDRESS=[^ ]*/MULTI_SEND_ADDRESS='"${addresses[3]}"'/;s/MULTI_SEND_CALL_ONLY_ADDRESS=[^ ]*/MULTI_SEND_CALL_ONLY_ADDRESS='"${addresses[5]}"'/;s/SAFE_DEFAULT_CALLBACK_HANDLER=[^ ]*/SAFE_DEFAULT_CALLBACK_HANDLER='"${addresses[7]}"'/;s/PROXY_FACTORY_ADDRESS_CRC=[^ ]*/PROXY_FACTORY_ADDRESS_CRC='"${addresses[2]}"'/;s/SAFE_CONTRACT_ADDRESS_CRC=[^ ]*/SAFE_CONTRACT_ADDRESS_CRC='"${addresses[1]}"'/' $ENV_FILE
fi
