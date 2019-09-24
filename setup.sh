#!/bin/bash
yum update -y
yum install httpd -y
sudo systemctl start httpd.service
yum install php php-mysql -y
sudo yum install mariadb-server mariadb -y
sudo systemctl start mariadb
# sudo mysql_secure_installation
sudo systemctl enable mariadb.service
sudo systemctl restart httpd.service
mysqladmin -uroot create mydb
mysql -e "CREATE USER mj@localhost IDENTIFIED BY 'abcd12345';"
mysql -e "GRANT ALL PRIVILEGES ON mydb.* TO 'mj'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
cd /var/www/html
wget https://wordpress.org/wordpress-5.1.1.tar.gz
tar -xzf wordpress-5.1.1.tar.gz
mv wordpress/ testwordpress
cd testwordpress
mv wp-config-sample.php wp-config.php
cd /var/www/html/testwordpress
sed -ir "s/database_name_here/mydb/" wp-config.php
sed -ir "s/username_here/mj/" wp-config.php
sed -ir "s/password_here/abcd12345/" wp-config.php
