FROM python:3.7-slim

ENV GIT_COMMIT 3a468537223e6440cbeb6d009d7a71a1cdcf5d44
ENV PYTHONUNBUFFERED 1
ENV TINI_VERSION v0.18.0

# Signal handling for PID1 https://github.com/krallin/tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Create man folders which are required by postgres
RUN for i in {1..8}; do mkdir -p "/usr/share/man/man$i"; done

# Install postgres-client
RUN apt-get update \
      && apt-get install -y git postgresql-client

# Install Safe relay service
RUN git clone https://github.com/CirclesUBI/safe-relay-service.git \
      && cd safe-relay-service \
      && git checkout --quiet ${GIT_COMMIT}

WORKDIR safe-relay-service

RUN set -ex \
      && buildDeps=" \
      build-essential \
      libssl-dev \
      libgmp-dev \
      pkg-config \
      " \
      && apt-get install -y --no-install-recommends $buildDeps \
      && pip install --no-cache-dir -r requirements-dev.txt \
      && apt-get purge -y --auto-remove $buildDeps \
      && rm -rf /var/lib/apt/lists/* \
      && find /usr/local \
      \( -type d -a -name test -o -name tests \) \
      -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
      -exec rm -rf '{}' +

EXPOSE 8888

# Copy all run scripts
COPY run.sh .
COPY run-worker.sh .
COPY run-scheduler.sh .
COPY wait-for-db.sh .

RUN chmod +x *.sh

# Replace settings with ours
COPY settings ./config/settings

ENTRYPOINT ["./wait-for-db.sh", "/tini", "--"]
