FROM ubuntu:latest

RUN apt-get update && apt-get install -y squid && \
    apt-get install -y apache2-utils && \
    apt-get install -y libcache-memcached-perl libcache-redis-perl

COPY squid.conf /etc/squid/squid.conf
COPY squid_memcached_auth.pl /usr/local/bin/squid_memcached_auth.pl

EXPOSE 8000-8900/tcp

CMD ["squid", "-N"]