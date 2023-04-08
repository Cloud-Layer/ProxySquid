FROM ubuntu:latest
# Update OS
RUN apt-get update -y

#Install all relevants application adn plugins
RUN apt-get install -y squid 
RUN apt-get install -y libmysqlclient-dev
RUN apt-get install -y mysql-client
RUN apt-get install -y squid-langpack
RUN apt-get install -y pip
RUN apt-get install -y python3
RUN pip install mysql-connector-python
RUN apt-get update -y
RUN apt-get install -y vim
RUN apt-get install -y cpanminus
RUN cpanm DBD::mysql

# Upload files to containers
COPY squid.conf /etc/squid/squid.conf
COPY squid_users /etc/squid/squid_users
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY mysql_auth.py /usr/lib/squid/mysql_auth.py

# Create Cache folders:
RUN cd /var/log/squid
RUN mkdir cache1
RUN mkdir cache2
RUN mkdir cache3

# Change permissions
RUN chmod a+x /etc/squid/squid.conf
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/lib/squid/mysql_auth.py

# Run a services
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["squid", "-NYCd", "1"]
