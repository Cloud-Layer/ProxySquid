FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install -y squid
RUN apt-get install -y apache2-utils
RUN apt-get install -y libcache-memcached-perl 
# RUN apt-get install -y libcache-redis-perl

COPY squid.conf /etc/squid/squid.conf
COPY squid_memcached_auth.pl /usr/local/bin/squid_memcached_auth.pl
RUN htpasswd -c -i -b /etc/squid/.htpasswd proxy101 'BqFK_&zRFX!7uVFDb'
EXPOSE 3128/tcp

CMD ["squid", "-N"]