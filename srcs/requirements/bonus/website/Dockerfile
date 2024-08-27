# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-carv <fde-carv@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/28 20:56:31 by fde-carv          #+#    #+#              #
#    Updated: 2024/08/19 18:24:53 by fde-carv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Use the Debian base image
FROM debian:bullseye

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip

# Set the working directory
WORKDIR /app

# Copy static site files to the working directory
COPY ./conf/ /app/website

# Copy the Python script to the working directory
COPY ./website.py /app/website.py

# Expose port 3000 for the HTTP server
EXPOSE 3000

# Set the stop signal to SIGINT
STOPSIGNAL SIGINT

# Command to run the Python script
CMD ["python3", "website.py"]