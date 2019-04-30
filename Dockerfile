FROM boxfuse/flyway:5.2.4

ENV PGHOST=event-store
ENV PGDATABASE=events
ENV PGUSER=postgres
ENV PGPASSWORD=postgres
ENV USE_IAM_AUTH=0

RUN apt-get update \
 && apt-get install -y python3 python3-pip \
 && pip3 install awscli

COPY migrations/*.sql /flyway/sql/
COPY docker-entrypoint.sh /flyway/

ENTRYPOINT ["/flyway/docker-entrypoint.sh"]
CMD ["-?"]
