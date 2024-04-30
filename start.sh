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

# Update /etc/hosts and .env file depending on the operating system
if [ "$OS" = "Linux" ]; then
    echo "Detected Linux OS"
    update_hosts "127.0.0.1" "api.circles.local"
    update_hosts "127.0.0.1" "graph.circles.local"
    update_hosts "127.0.0.1" "relay.circles.local"
    # Update .env file to match Linux entries
    sed -i 's/HOST_API=.*/HOST_API=api.circles.local/' .env
    sed -i 's/HOST_GRAPH_NODE=.*/HOST_GRAPH_NODE=graph.circles.local/' .env
    sed -i 's/HOST_RELAYER=.*/HOST_RELAYER=relay.circles.local/' .env
elif [ "$OS" = "Darwin" ]; then
    echo "Detected macOS"
    update_hosts "127.0.0.1" "api.circles.lan"
    update_hosts "127.0.0.1" "graph.circles.lan"
    update_hosts "127.0.0.1" "relay.circles.lan"
    # Update .env file to match macOS entries
    sed -i '' 's/HOST_API=.*/HOST_API=api.circles.lan/' .env
    sed -i '' 's/HOST_GRAPH_NODE=.*/HOST_GRAPH_NODE=graph.circles.lan/' .env
    sed -i '' 's/HOST_RELAYER=.*/HOST_RELAYER=relay.circles.lan/' .env
    # Flush DNS cache on macOS
    sudo killall -HUP mDNSResponder
    echo "Flushed DNS cache on macOS"
else
    echo "Unsupported OS: $OS"
    exit 1
fi

make down
make clean

make up EXPOSE_PORTS=1
make contracts
make up EXPOSE_PORTS=1
make pathfinder