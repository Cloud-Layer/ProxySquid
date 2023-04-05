FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y squid 
RUN apt-get install -y libmysqlclient-dev
COPY squid.conf /etc/squid/squid.conf
COPY squid_users /etc/squid/squid_users
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["squid3", "-NYCd", "1"]
