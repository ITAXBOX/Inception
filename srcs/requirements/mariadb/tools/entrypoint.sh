#!/bin/sh

# Initialize MariaDB data directory and create database/user if not already present
if [ ! -d "/var/lib/mysql/mysql" ]; then
	# the mysql_install_db is used to create the mysql system tables
	mysql_install_db --user=mysql --ldata=/var/lib/mysql
	# sed commands to replace placeholders in the SQL script with actual environment variable values
	sed -i "s/DB_NAME/$DB_NAME/g" /var/mariadb/db.sql
	sed -i "s/DB_USER_PW/$DB_USER_PW/g" /var/mariadb/db.sql
	sed -i "s/DB_USER_NAME/$DB_USER_NAME/g" /var/mariadb/db.sql
	sed -i "s/DB_ROOT_PW/$DB_ROOT_PW/g" /var/mariadb/db.sql
	
	# Start MariaDB in bootstrap mode to execute the SQL script
	# this is necessary to set up the initial database and user
	# because the database server is not running yet
	/usr/bin/mysqld --user=mysql --bootstrap < /var/mariadb/db.sql
fi

# Execute the command passed as arguments to the script
# the $@ represents all the arguments passed to the script
exec "$@"