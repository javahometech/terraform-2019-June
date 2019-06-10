#!/bin/bash

yum install httpd -y
systemctl enable httpd
echo "<h1> This app id deployed by terraform!!</h1>" > /var/www/html/index.html
systemctl start httpd
