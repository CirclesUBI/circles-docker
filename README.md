<div align="center">
	<img width="80" src="https://raw.githubusercontent.com/CirclesUBI/.github/main/assets/logo.svg" />
</div>

<h1 align="center">circles-docker</h1>

<div align="center">
 <strong>
   Infrastructure provisioning for Circles development
 </strong>
</div>

<br />

<div align="center">
  <!-- Licence -->
  <a href="https://github.com/CirclesUBI/circles-docker/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/CirclesUBI/circles-core?style=flat-square&color=%23cc1e66" alt="License" height="18">
  </a>
  <!-- Discourse -->
  <a href="https://aboutcircles.com/">
    <img src="https://img.shields.io/discourse/topics?server=https%3A%2F%2Faboutcircles.com%2F&style=flat-square&color=%23faad26" alt="chat" height="18"/>
  </a>
  <!-- Twitter -->
  <a href="https://twitter.com/CirclesUBI">
    <img src="https://img.shields.io/twitter/follow/circlesubi.svg?label=twitter&style=flat-square&color=%23f14d48" alt="Follow Circles" height="18">
  </a>
</div>

<div align="center">
  <h3>
    <a href="https://handbook.joincircles.net">
      Handbook
    </a>
    <span> | </span>
    <a href="https://github.com/CirclesUBI/.github/blob/main/CONTRIBUTING.md">
      Contributing
    </a>
  </h3>
</div>

<br/>


Enables you to start Circles services in Docker containers for Circles development.

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

```
# Build all docker containers
make build

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
    && docker container prune -f \
    && docker volume prune -f \
    && make build \
    && make up \
    && make contracts \
    && make subgraph
```

## Development

Clone [circles-api](https://github.com/CirclesUBI/circles-api) and [safe-relay-service](https://github.com/CirclesUBI/safe-relay-service) into the parent folder of `circles-docker` if you're about to set up a development environment of the api or relayer.

```
├── circles-api
├── circles-docker
└── safe-relay-service
```

Start all `make` commands with `ENV=backend` to point the build steps against the local repositories. For example:

```
make ENV=backend build
make ENV=backend up
make ENV=backend down
```

## License

GNU Affero General Public License v3.0 `AGPL-3.0`
