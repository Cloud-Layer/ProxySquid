import memcache

mc = memcache.Client(['memcached-server:11211'])

username = 'proxy101'
password = 'BqFK_&zRFX!7uVFDb'

key = 'auth:%s' % username
mc.set(key, password)
