#!/bin/bash

service mariadb start

# Wait for MariaDB to be ready
echo "______/=> Waiting for MariaDB to start..."
until mysqladmin ping --silent; do
	sleep 2
	echo "______/=> Waiting for MariaDB to be ready..."
done

# Create database and user
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MDB_NAME}\`;"
mariadb -e "CREATE USER IF NOT EXISTS \`${MDB_USER}\`@'%' IDENTIFIED BY '${MDB_PASSWORD}';"
mariadb -e "GRANT ALL PRIVILEGES ON ${MDB_NAME}.* TO \`${MDB_USER}\`@'%';"
mariadb -e "FLUSH PRIVILEGES;"

# Shutdown mariadb to restart with new config
mysqladmin --user=root shutdown

# Restart mariadb with new config in the background to keep the container running
exec mysqld --port=3306 \
		--bind-address=0.0.0.0 \
		--datadir='/var/lib/mysql' \
		--user=mysql


#____________________________________________ EXPLANATION ____________________________________________#

# **Create database and user**:
#
#    mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MDB_NAME}\`;"
#    mariadb -e "CREATE USER IF NOT EXISTS \`${MDB_USER}\`@'%' IDENTIFIED BY '${MDB_PASSWORD}';"
#    mariadb -e "GRANT ALL PRIVILEGES ON ${MDB_NAME}.* TO \`${MDB_USER}\`@'%';"
#    mariadb -e "FLUSH PRIVILEGES;"
# 
#    - Creates a database with the name specified in the environment variable [`MDB_NAME`],
#      if it does not exist.
#    - Creates a user with the name specified in the environment variable [`MDB_USER`], if it
#      does not exist.
#    - Grants all privileges on the database [`MDB_NAME`].
#    - Flushes the privileges to ensure the changes take effect.

# **Shut down MariaDB to restart with the new configuration**:
#
#    mysqladmin --user=root shutdown
#
#    - Shuts down MariaDB using the [`mysqladmin`] command with the root user.

# **Restart MariaDB with the new configuration**:
#
#    exec mysqld --port=3306 \
#            --bind-address=0.0.0.0 \
#            --datadir='/var/lib/mysql' \
#            --user=mysql
#
#    - Restarts MariaDB with the new configurations.
#    - Uses the [`exec`] command to replace the current shell with the [`mysqld`] process,
#      ensuring the container continues running.
#    - Specifies the port (`--port=3306`), the bind address (`--bind-address=0.0.0.0`),
#      the data directory (`--datadir='/var/lib/mysql'`), and the user (`--user=mysql`).

# This script is useful for configuring a Docker container with MariaDB, ensuring that the database
# and user are created and that the MariaDB server is correctly configured before being started
# in the background.