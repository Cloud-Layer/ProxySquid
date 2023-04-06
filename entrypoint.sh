#!/bin/bash
set -e
# mysql -h 138.199.41.118 -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < /etc/squid/squid_users
mysql -h 138.199.41.118 -u squid_user -psquid_password squid_db < /etc/squid/squid_users
/usr/sbin/squid -NYCd 1
