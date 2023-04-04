FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install -y squid
RUN apt-get install -y apache2-utils
RUN apt-get install -y libcache-memcached-perl
RUN apt-get install -y python3
RUN apt-get -y update
RUN apt-get -y install python3-pip
RUN pip3 install python-memcached

COPY auth.py /etc/squid/auth.py
COPY squid.conf /etc/squid/squid.conf
COPY store-credentials.py /etc/squid/store-credentials.py
COPY memcached_auth.py /etc/squid/memcached_auth.py
COPY squid_memcached_auth.pl /usr/local/bin/squid_memcached_auth.pl
RUN python3 /etc/squid/store-credentials.py
RUN htpasswd -c -i -b /etc/squid/.htpasswd proxy101 'BqFK_&zRFX!7uVFDb'
EXPOSE 3128/tcp

CMD ["squid", "-N"]