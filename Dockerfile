FROM centos:7.6.1810

MAINTAINER "The Ignorant IT Guy" <iitg@gmail.com>

RUN yum -y --nogpgcheck update && yum -y --nogpgcheck install \
                                                              aide && \
                                                              yum clean all

# Install the default AIDE configuration
COPY aide.conf /etc/aide.conf

COPY aide_init.sh /aide_init.sh
RUN chmod +x /aide_init.sh
CMD ["/aide_init.sh"]
