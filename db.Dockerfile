FROM mysql:8.0.29

WORKDIR /docker-entrypoint-initdb.d
COPY ./DB.sql ./
WORKDIR /var/lib/mysql