FROM ubuntu:latest

# Update OS
RUN apt-get update -y

# Install Squid and other dependencies
RUN apt-get install -y squid libmysqlclient-dev mysql-client squid-langpack vim cpanminus python3-pip

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
    && chmod a+x /etc/squid/squid.conf \
    && chmod +x /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/lib/squid/mysql_auth.py

# Run the Squid proxy server
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["squid", "-NYCd", "1"]
