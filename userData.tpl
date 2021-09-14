#!/bin/bash

yum update -y

#=== Install Apache Web Sever =====

yum install httpd -y
systemctl enable httpd

#==== Install PHP =======

amazon-linux-extras install php7.2 -y

#== Install Wordpress ====

cd /var/www/html/ && wget http://wordpress.org/latest.tar.gz && tar xvf latest.tar.gz
mv wordpress/* /var/www/html/ && rm -rf wordpress
mkdir /var/www/html/wp-content/uploads
chown -R apache:apache /var/www/html/*
cd /var/www/html
cp wp-config-sample.php wp-config.php
sed -i.back 's/database_name_here/${db_name}/' wp-config.php
sed -i.back 's/username_here/${db_user}/' wp-config.php
sed -i.back 's/password_here/${db_password}/' wp-config.php
sed -i.back 's/localhost/${db_host}/' wp-config.php
systemctl start httpd



