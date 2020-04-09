FROM centos:8

RUN yum -y install bind-utils bind && \
    yum clean all

ADD ./entrypoint.sh / 

VOLUME /opt/named

EXPOSE 53 53/udp

RUN named-checkconf /etc/named.conf

ENTRYPOINT [ "/entrypoint.sh" ]
