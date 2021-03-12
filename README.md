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
  <!-- npm -->
  <a href="https://www.npmjs.com/package/@circles/core">
    <img src="https://img.shields.io/npm/v/@circles/core?style=flat-square&color=%23f14d48" height="18">
  </a>
  <!-- Licence -->
  <a href="https://github.com/CirclesUBI/circles-core/blob/main/LICENSE">
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
    <a href="https://circlesubi.github.io/circles-core/">
      API Docs
    </a>
    <span> | </span>
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

* Make a copy of `.env.example` and rename it to `.env`, edit the file according to your needs. The default values should be sufficient for local development on your machine.

* Edit your `/etc/hosts` file and add the following hostnames (or similar, depending on your `.env` configuration):

    ```
    127.0.1.1 api.circles.local
    127.0.1.1 graph.circles.local
    127.0.1.1 relay.circles.local
    ```

## Usage

Please note that depending on how you installed Docker you might need to run these commands with `sudo` before them (except of `make contracts` and `make subgraph`).

```bash
# Start all containers
make up

# If you need more control on how the `circles-api` and `safe-relay-service`
# are handled during local development you can use the following values:
#
# pull = Loads the pre-built image from external registry (default)
# build = Builds the container from your computer
# skip = Skips starting this container
#
# Pass on these values for the `API` and `RELAYER` arguments depending on your
# needs:
make up API=skip|pull|build RELAYER=skip|pull|build

# Example: Start all containers except api and safe-relayer-service
make up API=skip RELAYER=skip

# Example: Start all containers, but build relayer container from local
# `safe-relay-service` repository (clone the project next to the
# `circles-docker` repository)
make up RELAYER=build

# You can also expose the ports of the PostgreSQL and Redis database to use
# them outside of the docker network
make up EXPOSE_PORTS=1

# Show all container logs
make logs

# Download and migrate contracts
make contracts

# Build and upload subgraph
make subgraph

# Stop all containers and remove attached volumes
make down

# Remove temporary files
make clean

# Run interactive shell in container
make sh c=circles-api

# Connect to PostgreSQL database via psql
make psql
```

## License

GNU Affero General Public License v3.0 `AGPL-3.0`
