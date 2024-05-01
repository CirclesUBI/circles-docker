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

- docker
- docker compose V2
- [Node](https://nodejs.org/en/download/) version 16

## Quick start

1. Run `./start.sh` and wait for completion
2. Run the client from https://github.com/CirclesUBI/circles-myxogastria
3. Visit http://localhost:8080/ and complete the setup of a new account
4. Once you reach http://localhost:8080/validation:
    - Open a new terminal window
    - Run `cd utils && npm i && node src/fund-account.js [YOUR-SAFE-ADDRESS]` and wait for completion
5. Refresh the browser window to finish the setup of the initial account


## Setup

- Make a copy of `.env.example` and rename it to `.env`, edit the file according to your needs. The default values should be sufficient for local development on your machine.

- Edit your `/etc/hosts` file and add the following hostnames (or similar, depending on your `.env` configuration):

  ```
  127.0.1.1 api.circles.local
  127.0.1.1 graph.circles.local
  127.0.1.1 relay.circles.local
  ```

  You can run the following commands to do this automatically (on linux):

  ```bash
  # Add entries to /etc/hosts if they don't exist
  grep -q "^127.0.0.1 api.circles.local$" /etc/hosts || echo "127.0.0.1 api.circles.local" | sudo tee -a /etc/hosts
  grep -q "^127.0.0.1 graph.circles.local$" /etc/hosts || echo "127.0.0.1 graph.circles.local" | sudo tee -a /etc/hosts
  grep -q "^127.0.0.1 relay.circles.local$" /etc/hosts || echo "127.0.0.1 relay.circles.local" | sudo tee -a /etc/hosts
  ```

### Setup for MAC OS X

Note that the setup is different for MAC OS systems. Instead of adding to `/etc/hosts` the following lines:

```
127.0.1.1 api.circles.local
127.0.1.1 graph.circles.local
127.0.1.1 relay.circles.local
```

Use these:

```
127.0.0.1	api.circles.lan
127.0.0.1	graph.circles.lan
127.0.0.1	relay.circles.lan
```

After updating `/etc/hosts` flush the DNS cache, howto depends on your Mac OS X distribution. [Flush DNS cache Mac OS X](https://osxdaily.com/2008/03/21/how-to-flush-your-dns-cache-in-mac-os-x/)

Also change in the `.env` file the following lines. So it matches the entries in `/etc/hosts`:

```
# Hosts
HOST_API=api.circles.lan
HOST_GRAPH_NODE=graph.circles.lan
HOST_RELAYER=relay.circles.lan
```

## Usage

Please note that depending on how you installed Docker you might need to run these commands with `sudo` before them (except of `make contracts`).

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

# Stop all containers and remove attached volumes
make down

# Remove temporary files
make clean

# Run interactive shell in container
make sh c=circles-api

# Connect to PostgreSQL database via psql
make psql
```

For preparing the environment to run the [`circles-core` tests](https://github.com/CirclesUBI/circles-core/) use:

```
make down && make up EXPOSE_PORTS=1 && make contracts && make up EXPOSE_PORTS=1
```

# Enabling the pathfinder service and blockchain indexer

This integrates the following components from [local envinroment](https://github.com/CirclesUBI/land-local)

- blockchain indexer
- indexer db
- pathfinder updater
- pathfinder proxy
- pathfinder

Which enables testing in the circles.garden envinroment the pathfinder server implemented [here](https://github.com/chriseth/pathfinder2)

There is known issue [#2](https://github.com/CirclesUBI/land-local/issues/2) whitin lan-local, this is a walkaround to have the services running:
(Here the commands are running with docker compose v2 but it works the same with docker compose v1)

```
1.
cp .env.example .env

2.
make up EXPOSE_PORTS=1 && make contracts && make up EXPOSE_PORTS=1

3.
make pathfinder

if there are any issues with the indexer init remove the `.state` folder and restart the process again.
## License

GNU Affero General Public License v3.0 `AGPL-3.0`
```
