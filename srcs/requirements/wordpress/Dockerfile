# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-carv <fde-carv@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/23 15:29:41 by fde-carv          #+#    #+#              #
#    Updated: 2024/08/19 16:53:48 by fde-carv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Use the Debian Bullseye base image
FROM debian:bullseye

# Update package list and install necessary packages
RUN apt -y update && apt install -y \
    curl \
    netcat \
    php \
    php-mysql \
    php7.4-fpm \
    sendmail

# Create the directory for WordPress
RUN mkdir -p /var/www/wordpress

## Example I started working with.
# RUN mkdir -p /var/www/wordpress/images
# COPY conf/foto.jpg /var/www/wordpress/images/minha_foto.jpg
# COPY conf/update_index.sh /var/www/wordpress/conf/update_index.sh

# Copy the WordPress setup script into the container
COPY ./conf/wordpress.sh /wordpress.sh

# Ensure the WordPress setup script has execute permissions
RUN chmod +x wordpress.sh

# Set the working directory to the WordPress directory
WORKDIR /var/www/wordpress

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Set the entrypoint to run the WordPress setup script
ENTRYPOINT ["/wordpress.sh"]