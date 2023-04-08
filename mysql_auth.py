#!/usr/bin/perl

use DBI;
use Digest::MD5 qw(md5_hex);

# Replace these values with your MySQL database credentials and SQL query
my $db_user = "squid_user";
my $db_pass = "squid_password";
my $db_name = "squid_db";
my $db_host = "mysql";
my $sql_query = "SELECT password FROM squid_users WHERE username=?";

my $username = lc <STDIN>;
chomp $username;

my $password = lc <STDIN>;
chomp $password;

# Connect to the MySQL database
my $dsn = "DBI:mysql:database=$db_name;host=$db_host";
my $dbh = DBI->connect($dsn, $db_user, $db_pass)
  or die "Can't connect to database: " . DBI->errstr;

# Prepare and execute the SQL query
my $sth = $dbh->prepare($sql_query);
$sth->execute($username);
my ($db_password) = $sth->fetchrow_array();

# Compare the hashed passwords
my $hashed_password = md5_hex("$username:$db_password:$password");
my $is_authenticated = $hashed_password eq $db_password;

if ($is_authenticated) {
  print "OK\n";
} else {
  print "ERR\n";
}

# Disconnect from the database
$dbh->disconnect();
