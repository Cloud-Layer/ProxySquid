import memcache

def auth(username, password):
    mc = memcache.Client(['memcached-server:11211'])
    key = 'auth:%s' % username
    cached_password = mc.get(key)
    if cached_password and cached_password == password:
        return True
    else:
        return False

def store(username, password):
    mc = memcache.Client(['memcached-server:11211'])
    key = 'auth:%s' % username
    mc.set(key, password)

def delete(username):
    mc = memcache.Client(['memcached-server:11211'])
    key = 'auth:%s' % username
    mc.delete(key)
