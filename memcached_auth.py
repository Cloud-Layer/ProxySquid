#!/usr/bin/env python

import sys
import memcache

# Configuration
MEMCACHED_SERVER = 'memcached-server:11211'
CACHE_LIFETIME = 3600

# Connect to Memcached server
mc = memcache.Client([MEMCACHED_SERVER])

# Read credentials from Squid
line = sys.stdin.readline().strip()
username, password = line.split()

# Authenticate user
if mc.get(username) == password:
    # Store credentials in Memcached
    mc.set(username, password, CACHE_LIFETIME)
    print('OK')
else:
    print('ERR')
