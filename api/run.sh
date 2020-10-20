#!/bin/sh

export NODE_ENV=production

npm run db:migrate
npm run db:seed

pm2-runtime ./build/index.js -i 2
