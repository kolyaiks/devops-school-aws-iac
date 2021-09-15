#!/bin/bash

#=== OS Update ======

yum update -y

#=== Install Apache Web Sever and MySQL =====

yum install httpd mysql -y
systemctl enable httpd
systemctl start httpd

#==== Install PHP and library to work with images =======

amazon-linux-extras install php7.2 -y
yum install -y php-gd -y

#====== WordPress ========

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
cp wp-cli.phar /usr/local/bin/wp
wp cli update
wp core download --path=/var/www/html
mkdir /var/www/html/wp-content/uploads
chown -R apache:apache /var/www/html/*
cd /var/www/html
wp config create --dbname=${db_name} --dbuser=${db_user} \
--dbpass=${db_password} --dbhost=${db_host}

# in case of already existing database wp installation will fail
# with error "WordPress is already installed.", so we are not allowed
# to have wp database before creation it via command below

wp db create
wp core install --url=http://${alb_dns} --title=wp-${company_name} \
--admin_user=${wp_admin} --admin_password=${wp_password} --admin_email=${wp_admin_email}

#=== Mounting EFS to local system folder used by WP ===

mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport \
${efs_dns_name}:/ \
/var/www/html/wp-content/uploads

#=== Customizing first WP post and saving image to EFS ====

wp post update 1 --path="/var/www/html" \
--post_title="Hello cloud" \
--post_content="This WordPress is spun up at AWS using Terraform by Nikolai Sergeev. <br> Reach out to me: <a href=\"https://www.niks.cloud/\">https://www.niks.cloud/</a>"

wp media import "https://www.niks.cloud/images/photo_2020-03-10_00-31-34.jpg" \
--post_id=1 --title="kolyaiks" --featured_image --path="/var/www/html"

#=== Restart Apache Web Sever ===

systemctl restart httpd




