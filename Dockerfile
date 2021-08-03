FROM postgres:13
RUN apt-get update
RUN apt-get install -y postgresql-13-wal2json
ENV POSTGRES_HOST_AUTH_METHOD=trust
