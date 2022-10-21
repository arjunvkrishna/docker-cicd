
#FROM arjunvk/redis:v3
#RUN apt update
#RUN apt install curl -y
#RUN apt install net-tools -y
#COPY redis.conf /etc/redis/redis.conf
#RUN mkdir -p /var/log/redis/
#RUN export port=$port


#
# Redis Dockerfile
#
# https://github.com/dockerfile/redis
#

# Pull base image.
FROM ubuntu

# Install Redis.
RUN apt update
RUN apt install wget -y
RUN apt install make -y
RUN apt install gcc -y
RUN apt install net-tools -y

RUN \
  cd /tmp && \
  wget http://download.redis.io/redis-stable.tar.gz && \
  tar xvzf redis-stable.tar.gz && \
  cd redis-stable && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-stable* && \
  sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["redis-server", "/etc/redis/redis.conf"]

# Expose ports.
EXPOSE 6379


