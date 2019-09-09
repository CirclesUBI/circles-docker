FROM python:3.7-slim-stretch

ENV PYTHONUNBUFFERED 1
ENV TINI_VERSION v0.18.0

# Signal handling for PID1 https://github.com/krallin/tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN apt-get update \
      && apt-get install -y git

RUN git clone https://github.com/CirclesUBI/safe-relay-service.git \
      && cd safe-relay-service \
      && git checkout --quiet ee73b0e

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

COPY run.sh .
COPY run-worker.sh .
COPY run-scheduler.sh .

RUN chmod +x run*

COPY settings ./config/settings

ENTRYPOINT ["/tini", "--"]
