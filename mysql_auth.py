#!/usr/bin/perl

use DBI;
use Digest::MD5 qw(md5_hex);

# Replace these values with your MySQL database credentials and DSN string
my $db_user = "squid_user";
my $db_pass = "squid_password";
my $dsn = "DBI:mysql:database=squid_db;host=mysql";

# Get the username and password from Squid
my $username = lc <STDIN>;
chomp $username;

my $password = lc <STDIN>;
chomp $password;

# Connect to the MySQL database using the DSN string
my $dbh = DBI->connect($dsn, $db_user, $db_pass)
  or die "Can't connect to database: " . DBI->errstr;

# Prepare and execute the SQL query
my $sth = $dbh->prepare("SELECT password FROM users WHERE username=?");
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
