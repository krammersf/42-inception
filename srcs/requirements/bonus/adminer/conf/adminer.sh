#!/bin/bash

# Function to handle termination signals
term_handler() {
    echo "Stopping PHP server..."
    kill -SIGINT "$php_pid"
    wait "$php_pid"
    exit 0
}

# Capture termination signals
trap 'term_handler' SIGTERM SIGINT

# Download Adminer
wget --no-check-certificate "https://www.adminer.org/latest.php" -O /var/www/html/adminer.php

# Set the owner of the file to www-data
chown -R www-data:www-data /var/www/html/adminer.php

# Set correct permissions for the file
chmod 755 /var/www/html/adminer.php

cd /var/www/html

# Remove the index.html file if it exists
rm -rf index.html

# Start the built-in PHP server
php -S 0.0.0.0:80 -t /var/www/html &
php_pid=$!

# Wait for the PHP process to finish
wait "$php_pid"