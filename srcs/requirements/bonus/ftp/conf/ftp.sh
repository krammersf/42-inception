#!/bin/bash

# Function to handle termination signals
term_handler() {
    echo "Stopping vsftpd..."
    timeout 3 service vsftpd stop
    if [ $? -eq 124 ]; then
        echo "vsftpd did not stop within 3 seconds, forcing stop..."
        pkill -9 vsftpd
        sleep 2
    fi
    exit 0
}

# Trap termination signals
trap 'term_handler' SIGTERM SIGINT

# Check if the FTP user already exists
if id "$FTP_USER" &>/dev/null; then
    echo "User $FTP_USER already exists."
else
    # Add the FTP user, set the password, and add to userlist
    adduser $FTP_USER --disabled-password
    echo "$FTP_USER:$FTP_PASSWORD" | /usr/sbin/chpasswd
    echo "$FTP_USER" | tee -a /etc/vsftpd.userlist

    # Set up FTP directories and permissions
    mkdir -p /home/$FTP_USER/ftp/files
    chown nobody:nogroup /home/$FTP_USER/ftp
    chmod a-w /home/$FTP_USER/ftp
    chmod 755 /home/$FTP_USER/ftp/files
    chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/files
fi

# Create the secure chroot directory
mkdir -p /var/run/vsftpd/empty

# Update vsftpd configuration
echo "
local_enable=YES
write_enable=YES
allow_writeable_chroot=YES
pasv_enable=YES
local_root=/home/$FTP_USER/ftp
pasv_min_port=40000
pasv_max_port=40005
userlist_file=/etc/vsftpd.userlist
secure_chroot_dir=/var/run/vsftpd/empty
" >> /etc/vsftpd.conf

# Start vsftpd in the foreground
/usr/sbin/vsftpd &

# Wait for vsftpd process to exit
wait $!