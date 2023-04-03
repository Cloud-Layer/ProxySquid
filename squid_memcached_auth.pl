#!/usr/bin/perl

use Cache::Memcached;

my $memd = Cache::Memcached->new({
    servers => ["memcached:11211"],
    namespace => 'squid_auth',
});

my $username = "proxy101";
my $password = "BqFK_&zRFX!7uVFDb";

$memd->set($username, $password);
