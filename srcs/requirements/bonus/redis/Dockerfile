# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-carv <fde-carv@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/28 14:19:23 by fde-carv          #+#    #+#              #
#    Updated: 2024/08/19 16:41:03 by fde-carv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Use the Debian Bullseye base image
FROM debian:bullseye

# Update package list, install Redis server, and set max memory limit
RUN apt-get -y update && apt install redis-server -y && echo "maxmemory 256mb" >> /etc/redis/redis.conf

# Set the max memory policy to allkeys-lru
RUN echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf

# Comment out the bind to localhost line in the Redis configuration
RUN sed -i -r "s/bind 127.0.0.1/#bind 127.0.0.0/" /etc/redis/redis.conf

# Start Redis server with protected mode disabled
CMD ["redis-server",  "--protected-mode", "no"]