#!/bin/bash

# Check if .env exists, if not, copy .env.example to .env and edit as needed
if [ ! -f .env ]; then
    cp .env.example .env
    echo "Copied .env.example to .env, please edit it as needed."
fi

# Detect the operating system
OS="$(uname -s)"

# Function to update /etc/hosts based on OS
update_hosts() {
    local ip="$1"
    local domain="$2"
    local file="/etc/hosts"
    if ! grep -q "^$ip $domain$" $file; then
        echo "$ip $domain" | sudo tee -a $file > /dev/null
        echo "Added $domain to $file"
    else
        echo "$domain already exists in $file"
    fi
}

# Update /etc/hosts depending on the operating system
if [ "$OS" = "Linux" ]; then
    echo "Detected Linux OS"
    update_hosts "127.0.0.1" "api.circles.local"
    update_hosts "127.0.0.1" "graph.circles.local"
    update_hosts "127.0.0.1" "relay.circles.local"
elif [ "$OS" = "Darwin" ]; then
    echo "Detected macOS"
    update_hosts "127.0.0.1" "api.circles.lan"
    update_hosts "127.0.0.1" "graph.circles.lan"
    update_hosts "127.0.0.1" "relay.circles.lan"
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# Make commands to manage and build the project
make down
make clean
make up EXPOSE_PORTS=1
make contracts
make up EXPOSE_PORTS=1
