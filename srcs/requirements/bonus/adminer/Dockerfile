# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-carv <fde-carv@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/28 06:31:17 by fde-carv          #+#    #+#              #
#    Updated: 2024/08/19 16:29:58 by fde-carv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

# Update packages and install wget and php
RUN apt -y update && apt install wget php php-mysql iputils-ping -y

# Create directory for Adminer
RUN mkdir -p /var/www/html

# Copy adminer.sh script to the container
COPY ./conf/adminer.sh /adminer.sh

# Grant execution permission to the script
RUN chmod +x /adminer.sh

# Install tini for better signal handling
RUN apt-get install -y tini

# Use tini as init system
ENTRYPOINT ["/usr/bin/tini", "--"]

# Set the entry command
CMD ["/adminer.sh"]