FROM debian:buster-slim

RUN apt-get update && apt-get install -y awscli postgresql-client

WORKDIR /query-runner

COPY . .

ENTRYPOINT ["/query-runner/run-query.sh"]
