# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-carv <fde-carv@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/29 15:47:20 by fde-carv          #+#    #+#              #
#    Updated: 2024/08/19 16:39:00 by fde-carv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Use the Debian Bullseye base image
FROM debian:bullseye

# Install wget
RUN apt-get update && apt-get install -y wget

# Download and install Prometheus
RUN wget https://github.com/prometheus/prometheus/releases/download/v2.44.0/prometheus-2.44.0.linux-amd64.tar.gz \
&& tar xvf prometheus-2.44.0.linux-amd64.tar.gz \
    && mv prometheus-2.44.0.linux-amd64/prometheus /usr/local/bin/ \
    && mv prometheus-2.44.0.linux-amd64/promtool /usr/local/bin/ \
    && rm -rf prometheus-2.44.0.linux-amd64.tar.gz prometheus-2.44.0.linux-amd64
    
# Expose the default Prometheus port
EXPOSE 9090

# Command to start Prometheus
CMD ["prometheus", "--config.file=/etc/prometheus/prometheus.yml"]