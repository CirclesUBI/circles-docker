# circles-docker

Infrastructure provisioning for Circles development and production environments.

## Setup

* Change the `.env` or `.env.production` file according to your needs.

* Edit your `/etc/hosts` file and add the following hostnames (or similar, depending on your `.env` configuration):

    ```
    127.0.0.1 relay.circles.local
    ```

## Usage

```
# Build all docker containers
make build

# .. use production environment
ENV=production make build

# Start containers in background
make up

# Show container logs
make logs

# Download and migrate contracts
make migrate
```

## License

GNU Affero General Public License v3.0 `AGPL-3.0`
