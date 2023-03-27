#!/bin/bash

apt update
apt upgrade -y
apt install -y ufw

ufw allow 22/TCP
ufw --force enable