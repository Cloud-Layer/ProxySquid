#!/usr/bin/env python3

import sys
import memcache

mc = memcache.Client(['memcached-server:11211'])

def authenticate(username, password):
    key = 'auth:%s' % username
    cached_password = mc.get(key)
    if cached_password and cached_password == password:
        return True
    else:
        return False

while True:
    line = sys.stdin.readline().strip()
    if not line:
        sys.exit(0)
    username, password = line.split(' ')
    if authenticate(username, password):
        sys.stdout.write('OK\n')
        sys.stdout.flush()
    else:
        sys.stdout.write('ERR\n')
        sys.stdout.flush()
