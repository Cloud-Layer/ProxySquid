FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install -y squid
RUN apt-get install -y apache2-utils
RUN apt-get install -y libcache-memcached-perl 
# RUN apt-get install -y libcache-redis-perl

ADD entrypoint.sh /sbin/entrypoint.sh
RUN chmod +x /sbin/entrypoint.sh
COPY squid.conf /etc/squid/squid.conf
COPY squid_memcached_auth.pl /usr/local/bin/squid_memcached_auth.pl

EXPOSE 3128/tcp

CMD ["squid", "-N"]
ENTRYPOINT ["/sbin/entrypoint.sh"]