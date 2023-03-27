#!/bin/bash

# Update the package index

# Install MySQL server
apt install mysql-server -y

# Secure the MySQL installation
mysql_secure_installation

# Log in to the MySQL server as the root user
mysql -u root -p

# Create a new database named "wordpress"
CREATE DATABASE wordpress;

# Create a new user named "wordpress" with the password "password"
CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'password';

# Grant all privileges on the "wordpress" database to the "wordpress" user
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';

# Exit the MySQL shell
exit

ufw allow 3306/TCP