# 基于centos6基础镜像
FROM centos:6
MAINTAINER chenyufeng "yufengcode@gmail.com"

WORKDIR /home

# 安装redis
RUN yum install -y wget gcc && \
        rpm --rebuilddb && \
        yum install -y tar && \
        wget http://download.redis.io/redis-stable.tar.gz && \
        tar -xvzf redis-stable.tar.gz && \
        mv redis-stable/ redis && \
        rm -f redis-stable.tar.gz && \
        ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
        yum clean all

WORKDIR /home/redis

RUN make && make install

# 设置时区的环境变量
ENV TZ Asia/Shanghai

# 把工作目录切换到/home下
WORKDIR /home

# 开放端口
EXPOSE 6379

# 启动容器后执行以下命令
ENTRYPOINT redis-server /home/redis/redis.conf

CMD ["redis-server"]

