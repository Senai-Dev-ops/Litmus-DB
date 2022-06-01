FROM mysql:8.0.29

ENV MYSQL_ROOT_PASSWORD passwd
ENV MYSQL_USER backend
ENV MYSQL_PASSWORD passwd

COPY a.sql /docker-entrypoint-initdb.d/
COPY b.sql /docker-entrypoint-initdb.d/

WORKDIR /var/lib/mysql

# https://stackoverflow.com/questions/62999267/how-to-run-mysql-scripts-in-docker-image#62999651