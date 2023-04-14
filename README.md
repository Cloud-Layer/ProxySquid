Squid Proxy Server with MySQL Authentication
This is a Dockerized version of the Squid proxy server with MySQL authentication. The Squid proxy server is a caching proxy for the web. This version adds MySQL authentication to Squid so that users can authenticate themselves before accessing the web.
Prerequisites
* Docker
* Docker Compose
Installation
1. Clone the repository
2. Copy the squid.conf, entrypoint.sh, mysql_auth.py, and squid_users files into the cloned directory
3. Build the Docker image with docker-compose build
4. Start the containers with docker-compose up -d
Configuration
The Squid configuration is located in squid.conf. The MySQL authentication script is located in mysql_auth.py. The list of users and their passwords is located in squid_users.
Usage
The Squid proxy server listens on port 3128. To use it, set your web browser to use the Squid server as the proxy server. The Squid server will authenticate users against the MySQL database before allowing them access to the web.
Docker Compose
The docker-compose.yml file defines the services for the MySQL database and the Squid proxy server. The MySQL service is based on the official MySQL Docker image. The Squid service is built from the Dockerfile in this repository.
Dockerfile
The Dockerfile builds an image with Squid proxy server and its dependencies installed. It also copies the configuration files and scripts into the image.
Scripts
The entrypoint.sh script is the entrypoint for the Squid container. It sets up the MySQL authentication and starts the Squid server.
squid.conf
The squid.conf file is the configuration file for the Squid proxy server. It sets up the cache directories, the access control lists, and the authentication parameters.
Disclaimer
This setup is intended for testing and learning purposes only. Please use at your own risk.
