#!/bin/bash

apt update
apt upgrade -y
apt install -y apache2 ufw

ufw allow 22/TCP
ufw allow 80/tcp
ufw --force enable