#!/bin/bash
set -e
mysql -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < /etc/squid/squid_users.sql
/usr/sbin/squid3 -NYCd 1
