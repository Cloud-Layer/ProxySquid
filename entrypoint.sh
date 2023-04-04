#!/bin/bash
set -e

mkdir -p /var/log/squid
chmod -R 755 /var/log/squid
chown -R proxy:proxy /var/log/squid
mkdir -p /var/cache/squid
chown -R proxy:proxy /var/cache/squid

SQUID_USER=${SQUID_USER}
SQUID_PASS=${SQUID_PASS}

if ( [ -n "${SQUID_USER}" ] && [ -n "${SQUID_PASS}" ] ); then
  # Create a username/password for ncsa_auth.
  htpasswd -c -i -b /etc/squid/.htpasswd ${SQUID_USER} ${SQUID_PASS}

  sed -i "1 i\\
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/.htpasswd\\
auth_param basic children 5\\
auth_param basic realm Squid proxy-caching web server\\
auth_param basic credentialsttl 2 hours\\
auth_param basic casesensitive off" /etc/squid/squid.conf

  sed -i "1 i\\
dns_nameservers 208.67.222.222\\
dns_nameservers 208.67.220.220" /etc/squid/squid.conf


