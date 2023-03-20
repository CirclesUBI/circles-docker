FROM node:latest

COPY . /app/
WORKDIR /app

RUN npm i

ENTRYPOINT ["/usr/local/bin/node", "/app/main.js"]
