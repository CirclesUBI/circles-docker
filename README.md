# circles-docker

Infrastructure provisioning for Circles development.

## Requirements

* docker
* docker-compose
* NodeJS
* envsubst (required to build the subgraph)

## Setup

* Make a copy of `.env.example` and rename it to `.env`, edit the file according to your needs. The default values should be sufficient if you only need a Circles backend during client development.

* Edit your `/etc/hosts` file and add the following hostnames (or similar, depending on your `.env` configuration):

    ```
    127.0.1.1 api.circles.local
    127.0.1.1 graph.circles.local
    127.0.1.1 relay.circles.local
    ```

## Usage

```bash
# Start containers
make up

# Show container logs
make logs

# Download and migrate contracts
make contracts

# Build and upload subgraph
make subgraph

# Stop all containers
make down

# Remove temporary files
make clean

# Convenient full-reset during development
make down \
    && docker volume prune -f \
    && make up \
    && make contracts \
    && make subgraph
```

## Development

Start the `up`, `down` and `logs` commands with `ENV=backend` when developing `circles-api` or `safe-relay-service` locally. For example:

```bash
make ENV=backend up
make ENV=backend down
make ENV=backend logs
```

Running the commands for the `backend` will do the following:

* Skip starting `circles-api` and `safe-relay-service` containers
* Expose the ports of the PostgreSQL database and Redis
* Make sure you only have all the basic services running (databases, Ethereum client, IPFS etc.)

## License

GNU Affero General Public License v3.0 `AGPL-3.0`
