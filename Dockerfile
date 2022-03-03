FROM rockylinux

ARG USER_ID=976
ARG GROUP_ID=971

ENV TZ=Asia/Taipei

LABEL Description="vsftpd Docker image based on RockyLinux. Supports passive mode and virtual users." \
        License="Apache License 2.0" \
        Version="1.0"

RUN dnf -y update && yum clean all
RUN dnf install -y \
        vsftpd \
        #db4-utils \
        #iproute \
        #db4 \
        && yum clean all


RUN usermod -u ${USER_ID} ftp
RUN groupmod -g ${GROUP_ID} ftp

COPY vsftpd.conf /etc/vsftpd/
COPY vsftpd_virtual /etc/pam.d/
COPY run-vsftpd.sh /usr/sbin/
RUN mkdir -p /etc/ssl/
COPY ssl/ /etc/ssl/

RUN chmod +x /usr/sbin/run-vsftpd.sh
RUN mkdir -p /home/vsftpd/
RUN chown -R ftp:ftp /home/vsftpd/



ADD ./users.txt /


VOLUME /home/vsftpd
VOLUME /var/log/vsftpd

EXPOSE 20 21

CMD ["/usr/sbin/run-vsftpd.sh"]

