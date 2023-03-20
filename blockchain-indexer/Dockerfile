FROM circlesubi/blockchain-indexer:dev

RUN apt update
RUN apt install jq -y

WORKDIR /app
COPY run.sh run.sh
RUN chmod +x run.sh
ENTRYPOINT ["sh", "run.sh"]
