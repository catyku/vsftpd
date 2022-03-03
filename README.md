# vsftpd  
This Docker container implements a vsftpd server, with the following features: 

RockyLinux base image.  
vsftpd  
Virtual users  
Passive mode  
Installation from Docker registry hub.  
You can download the image with the following command:  

```
docker pull catyku/vsftpd
```

## run docker

```
docker run -d -v /my/data/directory:/home/vsftpd \
-p 20:20 -p 21:21 -p 21100-21110:21100-21110 \
--name vsftpd --restart=always catyku/vsftpd
```

## description

default port 
ftp 21  
data 20  
pasv_max_port 21110  
pasv_min_port 21100  

## create users  
edit users.txt  
account;password  

## vsftpd config  
edit vsftpd.conf  
