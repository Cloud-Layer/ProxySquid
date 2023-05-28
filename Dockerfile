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

# Install Python MySQL Connector
RUN pip install mysql-connector-python

# Install Perl module DBD::mysql
RUN cpanm DBD::mysql

# Copy configuration files
COPY squid.conf /etc/squid/squid.conf
COPY squid_users /etc/squid/squid_users
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY mysql_auth.py /usr/lib/squid/mysql_auth.py

# Create cache folders
RUN mkdir -p /var/log/squid/cache1 \
    && mkdir -p /var/log/squid/cache2 \
    && mkdir -p /var/log/squid/cache3 \
    && mkdir -p /var/spool/squid

# Change permissions
RUN chmod -R 777 /var/spool/squid \
    && chown -R proxy:proxy /var/spool/squid \
    && chmod a+x /etc/squid/squid.conf \
    && chown -R proxy:proxy /var/log/squid \
    && chmod +x /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/lib/squid/mysql_auth.py

# Run the Squid proxy server
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["squid", "-NYCd", "1"]
