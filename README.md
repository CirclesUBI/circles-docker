# circles-docker

Infrastructure provisioning for Circles development.

## Setup

* Make a copy of `.env.example` and rename it to `.env`, edit the file according to your needs. The default values should be sufficient if you only need a Circles backend during client development.

* Edit your `/etc/hosts` file and add the following hostnames (or similar, depending on your `.env` configuration):

    ```
    127.0.1.1 api.circles.local
    127.0.1.1 graph.circles.local
    127.0.1.1 relay.circles.local
    ```

## Usage

```
# Build all docker containers
make build

# Start containers
make up

# Show container logs
make logs

# Download and migrate contracts
make contracts

# Stop all containers
make down

# Remove temporary files
make clean

# Convenient full-reset during development
make down \
    && docker container prune -f \
    && docker volume prune -f \
    && make build \
    && make up \
    && make contracts
```

## License

GNU Affero General Public License v3.0 `AGPL-3.0`
