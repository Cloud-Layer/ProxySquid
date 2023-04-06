FROM ubuntu:latest
RUN apt-get update -y
RUN apt-get install -y squid 
RUN apt-get install -y libmysqlclient-dev
RUN apt-get install -y mysql-client
RUN apt-get install -y squid-langpack
RUN apt-get install -y pip
RUN apt-get install -y python3
RUN pip install mysql-connector-python
COPY squid.conf /etc/squid/squid.conf
COPY squid_users /etc/squid/squid_users
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY mysql_auth.py /usr/lib/squid/mysql_auth.py
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/lib/squid/mysql_auth.py
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["squid", "-NYCd", "1"]
