#!/bin/bash


# Create home dir and update vsftpd user db:
input="/users.txt"
while IFS= read -r line
do
  echo "$line"

  arrIN=(${line//;/ })
  FTP_USER=${arrIN[0]}
  FTP_PWD=${arrIN[1]}
  mkdir -p "/home/vsftpd/$FTP_USER"

  echo "/home/vsftpd/$FTP_USER , $FTP_PWD"
  echo -e "$FTP_USER\n$FTP_PWD" > /etc/vsftpd/virtual_users.txt

done < "$input"



chown -R ftp:ftp /home/vsftpd/

/usr/bin/db_load -T -t hash -f /etc/vsftpd/virtual_users.txt /etc/vsftpd/virtual_users.db

# Set passive mode parameters:
if [ "$PASV_ADDRESS" = "**IPv4**" ]; then
    export PASV_ADDRESS=$(/sbin/ip route|awk '/default/ { print $3 }')
fi


# Run vsftpd:
&>/dev/null /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

