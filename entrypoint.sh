#!/bin/bash
set -e

mkdir -p /var/log/squid
chmod -R 755 /var/log/squid
chown -R proxy:proxy /var/log/squid
mkdir -p /var/cache/squid
chown -R proxy:proxy /var/cache/squid

SQUID_USER=proxy101
SQUID_PASS='BqFK_&zRFX!7uVFDb'

if ( [ -n "${SQUID_USER}" ] && [ -n "${SQUID_PASS}" ] ); then
  # Create a username/password for ncsa_auth.
  htpasswd -c -i -b /etc/squid/.htpasswd ${SQUID_USER} ${SQUID_PASS}
  fi