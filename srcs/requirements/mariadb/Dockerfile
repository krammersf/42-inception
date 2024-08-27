# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-carv <fde-carv@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/24 17:11:45 by fde-carv          #+#    #+#              #
#    Updated: 2024/08/19 16:48:46 by fde-carv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Use the Debian Bullseye base image
FROM debian:bullseye

# Update package list and install MariaDB server
RUN apt update && apt install -y \
    mariadb-server

# Copy the MariaDB configuration script into the container
COPY ./conf/mariadb_conf.sh /mariadb_conf.sh

# Ensure the configuration script has execute permissions
RUN chmod +x /mariadb_conf.sh

# Expose the default MariaDB port
EXPOSE 3306

# Set the entrypoint to run the MariaDB configuration script
ENTRYPOINT ["./mariadb_conf.sh"]


#____________________________________________ EXPLANATION ____________________________________________#

# 	1. **Base Image**:
#
# 	   FROM debian:bullseye
#
# 	   - This line specifies the base image for the Docker container. In this case,
#        it uses the Debian Bullseye distribution.
	
# 	2. **Update and Install MariaDB Server**:
#
# 	   RUN apt update && apt install -y \
#
# 	   - This line updates the package list ([`apt update`]. The `-y` flag automatically
#        answers "yes" to any prompts during the installation.
	
# 	3. **Copy Configuration Script**:
#
# 	   COPY ./conf/mariadb_conf.sh /mariadb_conf.sh
#
# 	   - This line copies the [`mariadb_conf.sh`] script from the local `./conf`
#        directory to the root directory of the container (`/mariadb_conf.sh`).
	
# 	4. **Make the Script Executable**:
#
# 	   RUN chmod +x /mariadb_conf.sh
#
# 	   - This line changes the permissions of the [`mariadb_conf.sh`] script to make it executable.
	
# 	5. **Expose Port 3306**:
#
# 	   EXPOSE 3306
#
# 	   - This line informs Docker that the container will listen on port 3306 at runtime.
#        Port 3306 is the default port for MariaDB.
	
# 	6. **Set Entry Point**:
#
# 	   ENTRYPOINT ["./mariadb_conf.sh"]
#
# 	   - This line sets the entry point for the container to the [`mariadb_conf.sh`] script.
#        When the container starts, this script will be executed.
	
# 	In summary, this Dockerfile sets up a Debian-based container with MariaDB server installed, copies
#   a configuration script into the container, makes the script executable, exposes the MariaDB port,
#   and sets the script as the entry point for the container.