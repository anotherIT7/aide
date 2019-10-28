FROM centos:7.6.1810

MAINTAINER "Another IT7" <anotherIT7@gmail.com>

RUN yum -y update && yum -y install aide && yum clean all

# Install the default AIDE configuration
COPY aide.conf /etc/aide.conf

COPY aide_init.sh /aide_init.sh
RUN chmod +x /aide_init.sh
CMD ["/aide_init.sh"]
