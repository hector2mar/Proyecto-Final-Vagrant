#!/bin/bash
apt-get install -y nginx
cp /vagrant/config-files/nginx.conf /etc/nginx/sites-available/default
systemctl restart nginx