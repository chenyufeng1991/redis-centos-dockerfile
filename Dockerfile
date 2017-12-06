FROM centos:6.7
MAINTAINER chenyufeng "yufengcode@gmail.com"

WORKDIR /home

RUN yum install -y wget gcc && \
        rpm --rebuilddb && \
        yum install -y tar && \
        wget http://download.redis.io/redis-stable.tar.gz && \
        tar -xvzf redis-stable.tar.gz && \
        mv redis-stable/ redis && \
        rm -f redis-stable.tar.gz && \
        yum clean all

WORKDIR /home/redis

RUN make && make install

EXPOSE 6379

ENTRYPOINT redis-server /home/redis/redis.conf

CMD ["redis-server"]

