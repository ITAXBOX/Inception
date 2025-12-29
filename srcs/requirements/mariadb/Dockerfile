FROM alpine:3.22

EXPOSE 3306
# install mariadb and mariadb-client packages from alpine repositories
# with the command: apk add --no-cache mariadb mariadb-client, to ensure that the latest versions are installed
RUN apk update && apk add --no-cache mariadb mariadb-client
# configure mariadb to listen on all interfaces by modifying the skip-networking setting in the mariadb-server.cnf file
# the sed command is used to replace skip-networking with skip-networking=0
# this change allows remote connections to the database server
RUN sed -i "s/skip-networking/skip-networking=0/g" /etc/my.cnf.d/mariadb-server.cnf
# create the /var/run/mysqld directory and set its permissions to 777
RUN mkdir -p /var/run/mysqld
RUN chmod 777 /var/run/mysqld
# set the ownership of the /var/lib/mysql directory to the mysql user and group
RUN chown -R mysql:mysql /var/lib/mysql

COPY ./conf/db.sql /var/mariadb/

COPY ./tools/entrypoint.sh /var/mariadb/

RUN chmod 777 /var/mariadb/db.sql
RUN chmod 777 /var/mariadb/entrypoint.sh

ENTRYPOINT ["/var/mariadb/entrypoint.sh"]
# Start the MariaDB server with the specified user
# the --user option specifies that the server should run as the mysql user
CMD ["/usr/bin/mysqld", "--user=mysql"]