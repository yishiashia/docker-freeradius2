FROM centos:7

RUN cd /
ADD freeradius-server-release_2_2_10.tar.gz /

RUN yum -y update && yum -y upgrade \
  && yum -y install cpanm perl perl-App-cpanminus perl-Config-Tiny \
  && yum -y install gcc openssl.x86_64 openssl-devel.x86_64 perl-devel.x86_64 perl-ExtUtils-Embed.noarch \
  && cpanm install MongoDB ; rm -fr root/.cpanm \
  && cd /freeradius-server-release_2_2_10 \
  && ./configure --prefix=/app/freeradius \
                 --exec-prefix=/opt/freeradius-2.2.10 \
                 --mandir=/usr/local/share/man \
                 --with-docdir=/usr/local/share/doc/freeradius \
  && make && make install \
  && yum clean all && cd / && rm -rf /freeradius-server-release_2_2_10

CMD ["/bin/sh"]

