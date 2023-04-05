FROM ubuntu:latest
RUN apt-get update && apt-get install -y squid3 libmysqlclient-dev
COPY squid.conf /etc/squid3/squid.conf
COPY squid_users /etc/squid3/squid_users
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["squid3", "-NYCd", "1"]
