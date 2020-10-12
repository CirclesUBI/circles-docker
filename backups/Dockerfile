FROM postgres:12.2-alpine
MAINTAINER Jonatan Heyman <http://heyman.info>

# Install dependencies
RUN apk update && apk add --no-cache --virtual .build-deps && apk add \
    bash make curl openssh git 

# Install aws-cli
RUN apk -Uuv add groff less python3 && pip3 install --upgrade pip setuptools awscli 

VOLUME ["/data/backups"]

ENV BACKUP_DIR /data/backups

ADD . /backup

ENTRYPOINT ["/backup/entrypoint.sh"]

CMD crond -f -l 2
