FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install -y squid
RUN apt-get install -y apache2-utils
RUN apt-get install -y libcache-memcached-perl
RUN apt-get install -y python3
RUN apt-get -y update
RUN apt-get -y install python3-pip
RUN pip3 install python-memcached

COPY squid.conf /etc/squid/squid.conf
COPY memcached_auth.py /usr/local/bin/memcached_auth.py
EXPOSE 3128/tcp

CMD ["squid", "-N"]