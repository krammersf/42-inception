# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fde-carv <fde-carv@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/28 15:41:32 by fde-carv          #+#    #+#              #
#    Updated: 2024/08/19 16:36:26 by fde-carv         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

# Install vsftpd and other necessary packages
RUN apt-get update && apt-get install -y vsftpd

# Copy the ftp.sh script into the container
COPY conf/ftp.sh /ftp.sh

# Ensure the script has execute permissions
RUN chmod +x /ftp.sh

# Set the stop signal to SIGINT (or another appropriate signal)
STOPSIGNAL SIGINT

# Run the script
CMD ["/ftp.sh"]
