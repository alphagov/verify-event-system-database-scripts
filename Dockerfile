FROM boxfuse/flyway:5.2.4

ENV PGHOST=event-store
ENV PGDATABASE=events
ENV PGUSER=postgres
ENV PGPASSWORD=postgres
ENV USE_IAM_AUTH=0

RUN apt-get update \
 && apt-get install -y python3 python3-pip \
 && pip3 install awscli \
 && mkdir -p /flyway/tools

COPY migrations/*.sql /flyway/sql/
COPY docker-entrypoint.sh /flyway/
COPY tools/submit_job.py /flyway/tools
COPY requirements/prod.txt /flyway/

RUN pip3 install -r /flyway/prod.txt

ENTRYPOINT ["/flyway/docker-entrypoint.sh"]
CMD ["-?"]
