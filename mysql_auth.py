#!/usr/bin/env python3

import sys
import mysql.connector
import logging

# Set up logging
logging.basicConfig(level=logging.DEBUG)

# MySQL connection information
host = "mysql"
user = "squid_user"
password = "squid_password"
database = "squid_db"

# Get username and password from Squid
line = sys.stdin.readline().strip()
username, password = line.split()

# Connect to MySQL database
logging.debug("Connecting to database...")
cnx = mysql.connector.connect(host=host, user=user, password=password, database=database)
cursor = cnx.cursor()

# Check if user is authenticated
logging.debug("Checking user authentication...")
query = "SELECT * FROM users WHERE username=%s AND password=%s"
cursor.execute(query, (username, password))
result = cursor.fetchone()

if result is not None:
    # User is authenticated
    logging.debug("User authenticated: %s", username)
    print("OK")
else:
    # User is not authenticated
    logging.debug("User authentication failed: %s", username)
    print("ERR")
