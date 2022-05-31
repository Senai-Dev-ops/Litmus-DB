FROM mysql:8.0.29

COPY DB.sql  /docker-entrypoint-initdb.d/
WORKDIR /var/lib/mysql

# https://stackoverflow.com/questions/62999267/how-to-run-mysql-scripts-in-docker-image#62999651