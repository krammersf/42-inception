#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress

chmod -R 755 /var/www/wordpress/

chown -R www-data:www-data /var/www/wordpress

# Check if the wordpress core files are already downloaded
if [ ! -f "/var/www/wordpress/index.php" ]; then

	# download wordpress core files
	echo "______/=> Downloading WordPress"
	wp core download --allow-root

	# create wp-config.php file with database details
	sleep 5
	echo "_____/=> Creating WordPress Config"
	wp core config --dbhost=mariadb:3306 --dbname="$MDB_NAME" --dbuser="$MDB_USER" --dbpass="$MDB_PASSWORD" --allow-root
	
	# install wordpress with the given title, admin username, password and email
	echo "_____/=> Installing WordPress "
	wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_NAME" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root

	# Check if the user already exists
	if ! wp user get "$WP_USER_NAME" --field=user_login --allow-root > /dev/null 2>&1; then
		# create a new user with the given username, email, password and role
		echo "_____/=> Creating new user"
		wp user create "$WP_USER_NAME" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role="$WP_USER_ROLE" --allow-root
	else
		echo "_____/=> User $WP_USER_NAME already exists"
	fi

	# Update discussion settings to auto-approve comments
	echo "_____/=> Updating discussion settings"
	wp option update comment_whitelist 0 --allow-root

	echo "_____/=> Wordpress running!!!"

	## Example I started working with.
	# Check if the script exists and has execution permissions
	# if [ -f "./conf/update_index.sh" ]; then
	# 	echo "_____/=> Running update_index.sh "
	# 	chmod +x /var/www/wordpress/conf/update_index.sh
	# 	/var/www/wordpress/conf/update_index.sh
	# else
	# 	echo "Script update_index.sh not found!"
	# fi
fi

# change listen port from unix socket to 9000
sed -i 's@/run/php/php7.4-fpm.sock@9000@g' /etc/php/7.4/fpm/pool.d/www.conf
# create a directory for php-fpm
mkdir -p /run/php
# start php-fpm service in the foreground to keep the container running
exec /usr/sbin/php-fpm7.4 -F