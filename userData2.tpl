#!/bin/bash

#=== OS Update ======

yum update -y

#=== Install Apache Web Sever and MySQL =====

yum install httpd mysql -y
systemctl enable httpd
systemctl start httpd

#==== Install PHP =======

amazon-linux-extras install php7.2 -y

#====== WordPress ========

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
cp wp-cli.phar /usr/bin/wp
wp cli update
wp core download --path=/var/www/html
chown -R apache:apache /var/www/html/*
cd /var/www/html
wp config create --dbname=${db_name} --dbuser=${db_user} \
--dbpass=${db_password} --dbhost=${db_host}

# in case of already existing database wp installation will fail
# with error "WordPress is already installed.", so we are not allowed
# to have wp database before creation it via script below

wp db create
wp core install --url=http://${alb_dns} --title=wp-${company_name} \
--admin_user=${wp_admin} --admin_password=${wp_password} --admin_email=${wp_admin_email}

systemctl restart httpd
