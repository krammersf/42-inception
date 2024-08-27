# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-carv <fde-carv@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/23 11:31:31 by fde-carv          #+#    #+#              #
#    Updated: 2024/08/19 16:49:44 by fde-carv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Use the Debian Bullseye base image
FROM debian:bullseye

# Update package list and install Nginx and OpenSSL
RUN apt -y update && apt install -y nginx && apt install openssl -y

# Create the directory for Nginx SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/ssl/nginx-selfsigned.pem \
    -keyout /etc/ssl/nginx-selfsigned.key \
    -subj "/C=PT/ST=Porto/L=Porto/O=42/OU=42/CN=${DOMAIN_NAME}/UID=${DB_USER}"

# Copy the Nginx configuration file into the container
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

# Expose the default HTTPS port
EXPOSE 443

# Set the entrypoint to run Nginx in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]


#____________________________________________ NOTES ____________________________________________#

# This Dockerfile command uses OpenSSL to generate a self-signed SSL certificate:

# - `openssl req`: Invokes OpenSSL's certificate signing request (CSR) utility, which can
#    also generate self-signed certificates.
# - `-x509`: Specifies that a self-signed certificate is to be generated instead of a certificate signing request.
# - `-nodes`: Stands for "no DES", which means that the private key will not be encrypted.
# - `-days 365`: Sets the validity of the certificate to 365 days.
# - `-newkey rsa:2048`: Generates a new RSA private key of 2048 bits.
# - `-out /etc/ssl/nginx-selfsigned.pem`: Specifies the output file for the certificate.
# - `-keyout /etc/ssl/nginx-selfsigned.key`: Specifies the output file for the private key.
# - `-subj "/C=PT/ST=Porto/L=Porto/O=42/OU=42/CN=${DOMAIN_NAME}/UID=${DB_USER}"`: Sets the subject field for
#    the certificate. This includes the country (`C`), state (`ST`), locality (`L`), organization (`O`),
#    organizational unit (`OU`), common name (`CN`), and user ID (`UID`). The `CN` and `UID` fields are populated
#    with environment variables `DOMAIN_NAME` and `DB_USER`, respectively.

# This command is typically used in Dockerfiles to generate a self-signed SSL certificate for use in development
# environments or internal networks, where the authenticity of the certificate can be trusted without needing a
# certificate from a trusted authority.
