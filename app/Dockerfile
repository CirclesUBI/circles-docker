FROM node:11-slim

ENV GIT_COMMIT f5c898ab615c8f4fa1fa6118e08e3b85f3aec9a2
WORKDIR /usr/src

# Install dependencies
RUN apt-get update \
      && apt-get install -y git python build-essential

# Clone app repository
RUN git clone https://github.com/CirclesUBI/circles-baby-phoenix.git app \
      && cd app \
      && git checkout --quiet ${GIT_COMMIT}

WORKDIR /usr/src/app

# Install dependencies
RUN npm install

# Generate static files
ENV NODE_ENV production
RUN npm run build

# Clean up
RUN apt-get purge -y --auto-remove build-essential
RUN rm -rf node_modules

# Install and run static http-server
WORKDIR /usr/src/app/build

RUN npm install -g http-server

EXPOSE 8080

CMD http-server --port 8080 --proxy http://app:8080? -d false -c36000000
